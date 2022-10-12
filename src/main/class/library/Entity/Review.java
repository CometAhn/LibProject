package library.Entity;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.util.List;

@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Review {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	@ManyToOne
	private Login login;
	@ManyToOne
	private Library library;
	@ManyToOne
	private Loan loan;
	private String title;
	private String contents;
	private String date;
	private int score;
	private int likes;
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "review")
	private List<ReviewLikes> reviewLikesList;
}
