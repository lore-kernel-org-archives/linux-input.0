From: Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH 0/3] HID: google: whiskers, minor fixes.
Date: Sat,  5 Oct 2019 17:44:16 +0800
Message-ID: <20191005094416.126152-1-ikjn@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benson Leung <bleung@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Guenter Roeck <groeck@chromium.org>, Brian Norris <briannorris@chromium.org>, Enrico Granata <egranata@google.com>, Ting Shen <phoenixshen@chromium.org>, Ikjoon Jang <ikjn@chromium.org>
List-Id: linux-input@vger.kernel.org

Ikjoon Jang (3):
  dt-bindings: input: Add DT bindings for Whiskers switch
  HID: google: Add of_match table to Whiskers switch device.
  HID: google: whiskers: mask out extra flags in EC event_type

 .../devicetree/bindings/input/cros-cbas.yaml  | 25 +++++++++++++++++++
 drivers/hid/hid-google-hammer.c               | 13 +++++++++-
 2 files changed, 37 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/input/cros-cbas.yaml

-- 
2.23.0.581.g78d2f28ef7-goog
