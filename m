From: Jim Keir <jimkeir@oracledbadirect.com>
Subject: [PATCH 2/2] Fix force effect modifications for the Microsoft Sidewinder Force Feedback Pro 2 joystick
Date: Fri, 23 Jan 2015 17:21:13 +0000
Message-ID: <0000014b17cfde4d-df42e887-9524-4f07-a46b-5d81f01fc687-000000@email.amazonses.com>
References: <1422033640-4104-1-git-send-email-jimkeir@oracledbadirect.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1422033640-4104-1-git-send-email-jimkeir@oracledbadirect.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, jkosina@suse.cz
Cc: Jim Keir <jimkeir@oracledbadirect.com>
List-Id: linux-input@vger.kernel.org

---
Hi,

Changes from previous patches: 
- All changes removed from higher-level files
- Extra debug line removed

Signed-off-by: Jim Keir <jimkeir@oracledbadirect.com> 

 drivers/hid/usbhid/hid-pidff.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.c
index 0b531c6..1b3fa70 100644
--- a/drivers/hid/usbhid/hid-pidff.c
+++ b/drivers/hid/usbhid/hid-pidff.c
@@ -568,6 +568,12 @@ static int pidff_upload_effect(struct input_dev *dev, struct ff_effect *effect,
 	int type_id;
 	int error;
 
+	pidff->block_load[PID_EFFECT_BLOCK_INDEX].value[0] = 0;
+	if (old && effect) {
+		pidff->block_load[PID_EFFECT_BLOCK_INDEX].value[0] =
+			pidff->pid_id[effect->id];
+	}
+
 	switch (effect->type) {
 	case FF_CONSTANT:
 		if (!old) {
-- 
1.9.1
