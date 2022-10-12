package library.Repository;

import library.Entity.Loan;
import library.Entity.Review;
import library.Entity.ReviewLikes;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ReviewLikesRepository extends JpaRepository<ReviewLikes, Integer> {


	ReviewLikes findByLoginLid(String lid);

	ReviewLikes findByReviewId(int id);

}
