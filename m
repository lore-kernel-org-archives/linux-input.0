From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH 3/3] HID: rmi: disable palm detect gesture when present
Date: Tue, 24 Feb 2015 17:36:50 -0800
Message-ID: <1424828210-18972-3-git-send-email-aduggan@synaptics.com>
References: <1424828210-18972-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424828210-18972-1-git-send-email-aduggan@synaptics.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Gabriele Mazzotta <gabriele.mzt@gmail.com>
List-Id: linux-input@vger.kernel.org

A touchpad may have firmware based palm detection code enabled which
suppresses 2D data from being reported when the firmware believes a palm is
on the touchpad. This functionality is meant to be used in mouse mode without
a driver. When a driver is present, the driver can do a better job of
determining if a contact is a palm. If this gesture is enabled on a touchpad
operating in rmi mode then the firmware will not properly clear the palm detect
interrupt, causing the touchpad to interrupt indefinately. This patch disables
the palm detect gesture when the touchpad is operating in rmi mode.

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
---
Hi Gabriele,

Can you test this patch on your system to confirm that it fixes your issue?
I was able to test the  other two patches so I can confirm that the write
fuction works. But, I don't have a touchpad with the palm detect gesture
enabled so it would be good to double check that I have the right address and
mask.

Andrew


 drivers/hid/hid-rmi.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
index 6e74eae..368ffdf 100644
--- a/drivers/hid/hid-rmi.c
+++ b/drivers/hid/hid-rmi.c
@@ -752,6 +752,7 @@ static int rmi_populate_f11(struct hid_device *hdev)
 	bool has_rel;
 	bool has_data40 = false;
 	bool has_dribble = false;
+	bool has_palm_detect = false;
 	unsigned x_size, y_size;
 	u16 query_offset;
 
@@ -820,6 +821,7 @@ static int rmi_populate_f11(struct hid_device *hdev)
 				ret);
 			return ret;
 		}
+		has_palm_detect = !!(buf[0] & BIT(0));
 		has_query10 = !!(buf[0] & BIT(2));
 
 		query_offset += 2; /* query 7 and 8 are present */
@@ -906,11 +908,11 @@ static int rmi_populate_f11(struct hid_device *hdev)
 	 * retrieve the ctrl registers
 	 * the ctrl register has a size of 20 but a fw bug split it into 16 + 4,
 	 * and there is no way to know if the first 20 bytes are here or not.
-	 * We use only the first 10 bytes, so get only them.
+	 * We use only the first 12 bytes, so get only them.
 	 */
-	ret = rmi_read_block(hdev, data->f11.control_base_addr, buf, 10);
+	ret = rmi_read_block(hdev, data->f11.control_base_addr, buf, 12);
 	if (ret) {
-		hid_err(hdev, "can not read ctrl block of size 10: %d.\n", ret);
+		hid_err(hdev, "can not read ctrl block of size 11: %d.\n", ret);
 		return ret;
 	}
 
@@ -927,6 +929,17 @@ static int rmi_populate_f11(struct hid_device *hdev)
 		}
 	}
 
+	if (has_palm_detect) {
+		buf[11] = buf[11] & ~BIT(0);
+		ret = rmi_write(hdev, data->f11.control_base_addr + 11,
+				&buf[11]);
+		if (ret) {
+			hid_err(hdev, "can not write to control reg 11: %d.\n",
+				ret);
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.1.0
