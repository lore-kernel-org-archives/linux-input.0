From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] HID: wacom: Don't clear bits unintentionally
Date: Thu, 10 Nov 2016 22:25:39 +0300
Message-ID: <20161110192539.GA32533@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This is trying to clear the lower 32 bits but the type is wrong so it
clears everything.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 0723ba8..1cf4608 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1765,7 +1765,7 @@ static int wacom_wac_pen_event(struct hid_device *hdev, struct hid_field *field,
 		wacom_wac->hid_data.tipswitch |= value;
 		return 0;
 	case HID_DG_TOOLSERIALNUMBER:
-		wacom_wac->serial[0] = (wacom_wac->serial[0] & ~0xFFFFFFFF);
+		wacom_wac->serial[0] = (wacom_wac->serial[0] & ~0xFFFFFFFFULL);
 		wacom_wac->serial[0] |= value;
 		return 0;
 	case WACOM_HID_WD_SENSE:
