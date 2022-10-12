
package library.DAO;

import library.Entity.*;
import library.Repository.LoanRepository;
import library.Repository.ReviewLikesRepository;
import library.Repository.ReviewRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Component
public class ReviewLikesDAO {
	@Autowired
	ReviewLikesRepository reviewLikesRepository;


	// 좋아요 기록 추가
	public void addReviewLikes(ReviewLikes rl) throws Exception {
		ReviewLikes newreviewlikes = reviewLikesRepository.save(rl);
	}

	// 로그인 아이디로 조회용
	public ReviewLikes checklid(String lid) throws Exception {
		return reviewLikesRepository.findByLoginLid(lid);
	}

	// 책 아이디로 조회용
	public ReviewLikes checklid(int id) throws Exception {
		return reviewLikesRepository.findByReviewId(id);
	}

	// 좋아요 기록 삭제
	public void delReviewlikes(ReviewLikes rl) throws SQLException {
		reviewLikesRepository.delete(rl);
	}
}