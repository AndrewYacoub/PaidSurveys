namespace :import do
    desc "Import dummy data from CSV file"
    task dummy_data: :environment do
      require 'csv'
  
      file_path = Rails.root.join('public', 'productSurveyDummyData.csv')
  
      CSV.foreach(file_path, headers: true) do |row|
        category_name = row['category_name']
        product_name = row['product_name']
        product_description = row['product_description']
        survey_title = row['survey_title']
        survey_description = row['survey_description']
        question_content = row['question_content']
        choice_content = row['choice_content']
        response_content = row['response_content']
  
        category = Category.find_or_create_by(name: category_name)
        product = category.products.find_or_create_by(name: product_name, description: product_description)
        survey = product.surveys.find_or_create_by(title: survey_title, description: survey_description, user: User.first, reward: 10, active: true, category: category)
        question = survey.questions.find_or_create_by(content: question_content, question_type: 'multiple_choice')
        choice = question.choices.find_or_create_by(content: choice_content)
        response = Response.find_or_create_by(user: User.first, survey: survey, question: question, choice: choice)
    end
  
      puts "Dummy data imported successfully."
    end
  end
  