From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 03/59] Revert "HID: add NOGET quirk for Eaton Ellipse MAX UPS"
Date: Wed, 14 Nov 2018 17:22:35 -0500
Message-ID: <20181114222335.99339-3-sashal@kernel.org>
References: <20181114222335.99339-1-sashal@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181114222335.99339-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>

[ Upstream commit 6298944d8f57f40ee2a3e6dcea1253e78d7a9969 ]

This reverts commit 67ddbb3e6568fb1820b2cc45b00c50702b114801.

67ddbb3e656 ("HID: add NOGET quirk for Eaton Ellipse MAX UPS") was reported
by Laurent Bigonville. It turns out that a later model Laurent got
doesn't need the quirk after all.

My take is that Eaton upgraded their firmwares, so we don't need it
anymore.

The old model was from 2012, so better make sure the new line works
properly by removing the quirk. This allows upower to actually fetch
the current data.

Reported-by: Laurent Bigonville <bigon@bigon.be>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-quirks.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 249d49b6b16c..caafbea94882 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -106,7 +106,6 @@ static const struct hid_device_id hid_quirks[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOUSE_C05A), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOUSE_C06A), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MCS, USB_DEVICE_ID_MCS_GAMEPADBLOCK), HID_QUIRK_MULTI_INPUT },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_MGE, USB_DEVICE_ID_MGE_UPS), HID_QUIRK_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_POWER_COVER), HID_QUIRK_NO_INIT_REPORTS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_SURFACE_PRO_2), HID_QUIRK_NO_INIT_REPORTS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TOUCH_COVER_2), HID_QUIRK_NO_INIT_REPORTS },
-- 
2.17.1
