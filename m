From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 0/2] HID special drivers converted to devres API
Date: Wed, 24 Jul 2013 19:38:03 +0200
Message-ID: <1374687485-31440-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, Andy Shevchenko <andy.shevchenko@gmail.com>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi guys,

this is the v2 of this series.

Cheers,
Benjamin

changes since v1:
- make the exit code of probe() in hid-a4tech.c returning 0
- fix a typo in the commit message of 2/2

Benjamin Tissoires (2):
  HID: trivial devm conversion for special hid drivers
  HID: multitouch: devm conversion

 drivers/hid/hid-a4tech.c     | 21 +++----------
 drivers/hid/hid-apple.c      | 16 ++--------
 drivers/hid/hid-magicmouse.c | 17 ++---------
 drivers/hid/hid-multitouch.c | 71 ++++++++++++++------------------------------
 drivers/hid/hid-sony.c       |  9 ++----
 drivers/hid/hid-zydacron.c   | 19 ++----------
 6 files changed, 39 insertions(+), 114 deletions(-)

-- 
1.8.3.1
