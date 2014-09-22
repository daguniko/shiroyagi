shiroyagi
=========

- 1. construct training data from training_data.csv

$ perl make_liblinear_input.pl training_data.csv > training

- 2. construct test data from test_data_v2.csv

$ perl make_liblinear_input.pl test_data.csv > test

- 3. training

$ ./train training

- 4. prediction

$ ./predict test training.model output

- 5. add "Article_read" to submission_data_v2.csv

$ perl add_article_read.pl output submission_data_v2.csv > submission_data.csv

- 6. add "user_id","on_cid","p_topic_id" to submission_data.csv using a editor
