# frozen_string_literal: true

Grover.configure do |config|
  config.options = {
    format: 'A4',
    margin: {
      top: '5px',
      bottom: '10cm'
    },
    viewport: {
      width: 640,
      height: 480
    },
    prefer_css_page_size: true,
    emulate_media: 'screen',
    cache: false,
    timeout: 0, # Timeout in ms. A value of `0` means 'no timeout'
    launch_args: ['--font-render-hinting=medium', '--lang=kh', '--allow-http-screen-capture'],
    wait_until: 'networkidle0',
    display_url: "http://localhost:3000",
  }
end
