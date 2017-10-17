/* Dating Database */

/* Facts */

% Gender

girl(alice).
boy(bob).
girl(carol).
boy(dave).
girl(evelyn).
boy(frank).
girl(grace).
boy(henry).

% Gender Preference

likes_boys(alice).
likes_girls(bob).
likes_girls(carol).
likes_boys(dave).
likes_girls(evelyn).
likes_boys(evelyn).
likes_girls(frank).
likes_boys(frank).
likes_boys(grace).
likes_girls(henry).

% Likes animals?

likes_animals(alice).
likes_animals(bob).
likes_animals(dave).
likes_animals(grace).

% Likes	math?

likes_math(carol).
likes_math(evelyn).
likes_math(frank).
likes_math(henry).

/* Rules */

match_likes(X, Y) :-
	likes_animals(X),
	likes_animals(Y).

match_likes(X, Y) :-
	likes_math(X),
	likes_math(Y).

match_preference(X, Y) :-
	girl(X),
	girl(Y),
	likes_girls(X),
	likes_girls(Y).

match_preference(X, Y) :-
	girl(X),
	boy(Y),
	likes_boys(X),
	likes_girls(Y).

match_preference(X, Y) :-
	boy(X),
	girl(Y),
	likes_girls(X),
	likes_boys(Y).

match_preference(X, Y) :-
	boy(X),
	boy(Y),
	likes_boys(X),
	likes_boys(Y).

match(X, Y) :-
        match_preference(X, Y),
	match_likes(X, Y),
	X \= Y.
