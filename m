From: Harry Cutts <hcutts@chromium.org>
Subject: [PATCH 0/3] Add support for high-resolution scrolling on Logitech mice
Date: Thu, 23 Aug 2018 11:30:54 -0700
Message-ID: <20180823183057.247630-1-hcutts@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Jiri Kosina <jiri.kosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Harry Cutts <hcutts@chromium.org>, linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Jiri Kosina <jikos@kernel.org>
List-Id: linux-input@vger.kernel.org

Hi everyone,

This set of patches adds support for high-resolution scroll wheels on
Logitech mice. See the linux-input "Reporting high-resolution scroll
events" thread [0] for previous discussion of the evdev changes. I would
love to hear your feedback.

Thanks,

Harry Cutts
Chrome OS Touch/Input team

[0]: https://www.spinics.net/lists/linux-input/msg57380.html



Harry Cutts (3):
  Add the `REL_WHEEL_HI_RES` event code
  Create a utility class for counting scroll events
  Enable high-resolution scrolling on Logitech mice

 Documentation/input/event-codes.rst    |  11 +-
 drivers/hid/hid-ids.h                  |  15 ++
 drivers/hid/hid-input.c                |  44 ++++
 drivers/hid/hid-logitech-hidpp.c       | 341 +++++++++++++++++++++++--
 drivers/hid/hid-quirks.c               |  11 +
 include/linux/hid.h                    |  28 ++
 include/uapi/linux/input-event-codes.h |   1 +
 7 files changed, 423 insertions(+), 28 deletions(-)

-- 
2.18.0.1017.ga543ac7ca45-goog
