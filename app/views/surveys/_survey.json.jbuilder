json.extract! survey, :id, :user_id, :category_id, :title, :description, :reward, :start_date, :end_date, :active, :created_at, :updated_at
json.url survey_url(survey, format: :json)
