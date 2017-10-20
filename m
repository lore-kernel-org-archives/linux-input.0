From: David Strobach <lalochcz@gmail.com>
Subject: [PATCH] HID: hid-kensington: add alternative button mapping
Date: Fri, 20 Oct 2017 14:41:33 +0200
Message-ID: <2082258.qPnAmo2zZ4@str>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:45535 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751244AbdJTMlg (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 20 Oct 2017 08:41:36 -0400
Received: by mail-wr0-f194.google.com with SMTP id k7so11255208wre.2
        for <linux-input@vger.kernel.org>; Fri, 20 Oct 2017 05:41:35 -0700 (PDT)
Received: from str.localnet (a155.dkm.cz. [62.24.65.155])
        by smtp.gmail.com with ESMTPSA id w126sm1030821wme.25.2017.10.20.05.41.33
        for <linux-input@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Oct 2017 05:41:33 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

The current mapping of the proprietary Kensington Slimblade buttons
is as follows:
 +---+---+
 | 2 | 8 |
 +---X---+
 | 1 | 3 |
 +---+---+

This modification adds an alternative button mapping for users,
who prefer to use middle mouse button emulation (buttons 1+3) in
order to get one extra button at the top right. The alternative
button mapping is:
 +---+---+
 | 9 | 8 |
 +---X---+
 | 1 | 3 |
 +---+---+

The desired behavior should ideally be achievable in userland,
but in reality only recent evdev Xorg driver since v2.10.5 is
able to handle middle mouse button remapping together with middle
button emulation.
---
 drivers/hid/hid-kensington.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-kensington.c b/drivers/hid/hid-kensington.c
index fe9a99dd8d08..1673e461338f 100644
--- a/drivers/hid/hid-kensington.c
+++ b/drivers/hid/hid-kensington.c
@@ -20,6 +20,11 @@
 
 #define ks_map_key(c)	hid_map_usage(hi, usage, bit, max, EV_KEY, (c))
 
+static bool use_alt_mapping;
+module_param(use_alt_mapping, bool, S_IRUGO);
+MODULE_PARM_DESC(use_alt_mapping,
+        "Use alternative button mapping (default = false)");
+
 static int ks_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		struct hid_field *field, struct hid_usage *usage,
 		unsigned long **bit, int *max)
@@ -28,8 +33,18 @@ static int ks_input_mapping(struct hid_device *hdev, struct 
hid_input *hi,
 		return 0;
 
 	switch (usage->hid & HID_USAGE) {
-	case 0x01: ks_map_key(BTN_MIDDLE);	break;
-	case 0x02: ks_map_key(BTN_SIDE);	break;
+	case 0x01:
+		if (use_alt_mapping)
+			ks_map_key(BTN_SIDE);
+		else
+			ks_map_key(BTN_MIDDLE);
+		break;
+	case 0x02:
+		if (use_alt_mapping)
+			ks_map_key(BTN_EXTRA);
+		else
+			ks_map_key(BTN_SIDE);
+		break;
 	default:
 		return 0;
 	}
-- 
2.14.2



