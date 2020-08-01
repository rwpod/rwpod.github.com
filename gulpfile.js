const gulp = require('gulp')
const del = require('del')
const critical = require('critical').stream

const criticalOptions = {
  base: 'public/',
  inline: true,
  minify: true,
  width: 1440,
  height: 1024
}

gulp.task('cleanup:assets', () => {
  return del([
    '.tmp/dist/**/*'
  ])
})

// Generate & Inline Critical-path CSS
gulp.task('critical:index', () => {
  return gulp
    .src(['public/*.html', '!public/404.html'])
    .pipe(critical(criticalOptions))
    .on('error', (err) => {
      console.error(err.message)
    })
    .pipe(gulp.dest('public'))
})

// Generate & Inline Critical-path CSS
gulp.task('critical:this_year', () => {
  const currentYear = (new Date()).getFullYear()
  return gulp
    .src([`public/posts/${currentYear}/**/*.html`])
    .pipe(critical(criticalOptions))
    .on('error', function (err) {
      console.error(err.message)
    })
    .pipe(gulp.dest(`public/posts/${currentYear}`))
})

gulp.task('critical', gulp.parallel('critical:index', 'critical:this_year'))
