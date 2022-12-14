package library.Repository;

import library.Entity.Library;
import library.Entity.Login;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface LoginRepository extends JpaRepository<Login, String> {
	Login findByLid(String id);

	Login findByToken(String token);

	List<Login> findAllByLid(String id);

	Login findByLidAndPassword(String id, String password);

	List<Login> findAllByEmail(String email);

	Login findByEmail(String email);

	Login findByEmailAndLid(String email, String lid);

	List<Login> findTop3ByOrderByReviewCountDesc();

	List<Login> findTop3ByOrderByLoanCountDesc();

	List<Login> findTop3ByOrderByLikesCountDesc();
}
