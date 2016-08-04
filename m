From: AceLan Kao <acelan.kao@canonical.com>
Subject: [PATCH] HID: input: add mic mute key on HP slim keyboard
Date: Thu,  4 Aug 2016 10:26:20 +0800
Message-ID: <1470277580-5517-1-git-send-email-acelan.kao@canonical.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:36779 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752806AbcHDC0X (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Aug 2016 22:26:23 -0400
Received: by mail-pa0-f67.google.com with SMTP id ez1so15270291pab.3
        for <linux-input@vger.kernel.org>; Wed, 03 Aug 2016 19:26:23 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

Add MIC mute key which is found on HP Business Slim Keyboard

T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 23 Spd=1.5 MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=03f0 ProdID=2f4a Rev=00.10
S:  Manufacturer=Chicony
S:  Product=HP Business Slim Keyboard
C:  #Ifs= 2 Cfg#= 1 Atr=a0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=01 Driver=usbhid
I:  If#= 1 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=00 Prot=00 Driver=usbhid

Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
---
 drivers/hid/hid-input.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index bcfaf32..d51c43b 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -953,6 +953,7 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 	case HID_UP_HPVENDOR2:
 		set_bit(EV_REP, input->evbit);
 		switch (usage->hid & HID_USAGE) {
+		case 0x001: map_key_clear(KEY_MICMUTE);		break;
 		case 0x003: map_key_clear(KEY_BRIGHTNESSDOWN);	break;
 		case 0x004: map_key_clear(KEY_BRIGHTNESSUP);	break;
 		default:    goto ignore;
-- 
2.7.4

