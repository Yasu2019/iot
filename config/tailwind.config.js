const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    //'./public/*.html',
    '../myapp/public/*.html',

    //'./app/helpers/**/*.rb',
    '../myapp/app/helpers/**/*.rb',
   

    //'./app/javascript/**/*.js',
    '../myapp/app/javascript/**/*.js',


    //'./app/views/**/*.{erb,haml,html,slim}'
    //Tailwind CSS for RailsがDockerコンテナ内で反映されないときの対処法。purge設定に"html.erb"を含めていないことが原因
    //https://qiita.com/hajsu00/items/d7f2c7f382124d6e32ef


    '../myapp/app/views/**/*.{html.erb,erb,haml,html,slim}'



  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('daisyui'),    // ← 追加
  ]
}
