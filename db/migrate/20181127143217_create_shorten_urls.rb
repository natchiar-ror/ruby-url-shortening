class CreateShortenUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :shorten_urls do |t|
	    t.text :base_original_url
	    t.string :minimized_url
	    t.string :clean_url	    

      t.timestamps
    end
  end
end
