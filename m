From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 5/6] HID: wacom: cleanup input devices
Date: Fri, 12 Feb 2016 17:27:44 +0100
Message-ID: <1455294465-13694-6-git-send-email-benjamin.tissoires@redhat.com>
References: <1455294465-13694-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455294465-13694-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org
Cc: Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Just some cleaning up when the input devices are unregistered.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/wacom_sys.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 5cb8528..9a41035 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1357,6 +1357,9 @@ static void wacom_clean_inputs(struct wacom *wacom)
 	wacom->wacom_wac.pen_input = NULL;
 	wacom->wacom_wac.touch_input = NULL;
 	wacom->wacom_wac.pad_input = NULL;
+	wacom->wacom_wac.pen_registered = false;
+	wacom->wacom_wac.touch_registered = false;
+	wacom->wacom_wac.pad_registered = false;
 	wacom_destroy_leds(wacom);
 }
 
-- 
2.5.0
