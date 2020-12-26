open import Relation.Binary.PropositionalEquality


open import Data.Nat
open import Data.Nat.Properties using (+-suc)

open import Data.Product renaming (_×_ to _∧_)
open import Data.Sum renaming (_⊎_ to _∨_ ; inj₁ to left ; inj₂ to right)


--5.1 Extrinsic approach


div2 : ℕ → ℕ
div2 zero = zero
div2 (suc zero) = zero
div2 (suc (suc n)) = suc (div2 n)

test5 : ℕ
test5 = div2 (suc (suc (suc (suc (suc zero)))))

div2-correct : (n : ℕ) → (2 * div2 n ≡ n ∨ suc (2 * div2 n) ≡ n)
div2-correct zero = left refl
div2-correct (suc zero) = right refl
div2-correct (suc (suc n)) with div2-correct n
... | left p = left (cong suc (trans (+-suc (div2 n) (div2 n + 0)) (cong suc p)))
... | right p = right (cong suc (cong suc (trans (+-suc (div2 n) (div2 n + 0)) p)))

--5.2 Intrinsic approach

div2' : (n : ℕ) → Σ ℕ (λ q → (2 * q ≡ n) ∨ (suc (2 * q) ≡ n) )
div2' zero = zero , (left refl)
div2' (suc zero) = zero , (right refl)
div2' (suc (suc n)) with (div2' n)
... | q , (left p) = (suc q) , (left (cong suc (trans (+-suc q (q + 0)) (cong suc p))))
... | q , (right p) = (suc q) , (right (cong suc (cong suc (trans (+-suc q (q + 0)) p))))
