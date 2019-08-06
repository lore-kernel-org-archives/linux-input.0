From: "Gerecke, Jason" <killertofu@gmail.com>
Subject: [PATCH] HID: wacom: Correct distance scale for 2nd-gen Intuos devices
Date: Tue,  6 Aug 2019 13:58:05 -0700
Message-ID: <20190806205805.21168-1-jason.gerecke@wacom.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Ping Cheng <pinglinux@gmail.com>, Aaron Armstrong Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Jason Gerecke <jason.gerecke@wacom.com>

Distance values reported by 2nd-gen Intuos tablets are on an inveted scale
(0 == far, 63 == near). We need to change them over to a normal scale before
reporting to userspace or else userspace drivers and applications can get
confused.

Ref: https://github.com/linuxwacom/input-wacom/issues/98
Fixes: eda01dab53 ("HID: wacom: Add four new Intuos devices")
Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
Cc: <stable@vger.kernel.org> # v4.4+
---
 drivers/hid/wacom_wac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 7a8ddc999a8e..879e41fbf604 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -846,6 +846,9 @@ static int wacom_intuos_general(struct wacom_wac *wacom)
 		y >>= 1;
 		distance >>= 1;
 	}
+	if (features->type == INTUOSHT2) {
+		distance = features->distance_max - distance;
+	}
 	input_report_abs(input, ABS_X, x);
 	input_report_abs(input, ABS_Y, y);
 	input_report_abs(input, ABS_DISTANCE, distance);
-- 
2.22.0
