From: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Subject: [PATCH v3 2/3] HID: quirks: Fix keyboard + touchpad on Lenovo Miix 630 for DT
Date: Mon, 15 Apr 2019 09:11:08 -0700
Message-ID: <20190415161108.16419-1-jeffrey.l.hugo@gmail.com>
References: <20190415160915.16324-1-jeffrey.l.hugo@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190415160915.16324-1-jeffrey.l.hugo@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: lee.jones@linaro.org, bjorn.andersson@linaro.org, dmitry.torokhov@gmail.com, agross@kernel.org, david.brown@linaro.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
List-Id: linux-input@vger.kernel.org

Following up on commit 2bafa1e96254 ("HID: quirks: Fix keyboard + touchpad
on Lenovo Miix 630"), the devicetree (DT) identifier for the combo keyboard
+ touchpad device is "elan,combo400-i2c", which differs from the ACPI ID,
thus if we want the quirk to work properly when booting via DT instead of
ACPI, we need to key off the DT id as well.

Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
---
 drivers/hid/hid-quirks.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 77ffba48cc73..00c08f8318b8 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -997,7 +997,8 @@ bool hid_ignore(struct hid_device *hdev)
 			return true;
 		/* Same with product id 0x0400 */
 		if (hdev->product == 0x0400 &&
-		    strncmp(hdev->name, "QTEC0001", 8) != 0)
+		    (strncmp(hdev->name, "QTEC0001", 8) != 0 ||
+		     strncmp(hdev->name, "elan,combo400-i2c", 17) != 0))
 			return true;
 		break;
 	}
-- 
2.17.1
