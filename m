Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDEE3CAE80;
	Wed, 15 Jul 2026 08:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784104470; cv=none; b=mHPz42lKfOkN0zOZD9FG22JbJb1OZWLdPN7doV5pGY+7A195C+fV2ETMUuWgsnXP+vD1cxx0q/bgTIuMOY9HOTnVwWMi0qo71GSMH0CBuZKxZfheO3VEJTAOoR+Y3npUv+/f4xHx/fnWvY3ld53PNdyDIrE04xDXsS9809pTM3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784104470; c=relaxed/simple;
	bh=GaF3bveAV+1/XBZaAXQDhVW2GCqtiEQ8N9B3VML6F9E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kSNLgo0ufgpdXqwNkqfh51UsEvV3Y6JDILRqDIKUPBoCqRFpoI195O/wCezZgO+4iiHq9yzi9h1BVmGnklT8ITAkyuEe1wyTPOhLKSQJdE98xm/Ou6SFDtKVshDX0KeBIEHyhTjrUsJam0VI3oQtSuPVBM3TgFxxMcvvRebVlAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowAAXnP8QRldqM0JHGA--.25383S2;
	Wed, 15 Jul 2026 16:34:24 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ted Mielczarek <ted@mielczarek.org>
Subject: [PATCH] Input: xpad: validate Xbox One report lengths
Date: Wed, 15 Jul 2026 16:34:24 +0800
Message-ID: <20260715083424.25944-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAXnP8QRldqM0JHGA--.25383S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAr1rCrW8Zr45tw1kXw1UJrb_yoWrAw1xpF
	Z0ga4j9rWktF13KF4ftr4ruFW5tF97J343KF93u340vasIvryYqrZFy3WvqFy5JFs5XayU
	trsIy3yDGFnrXa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUDpnQUUU
	UU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

xpadone_process_packet() receives a 64-byte USB buffer, but only
urb->actual_length belongs to the current report. The function still reads
fixed offsets for virtual-key, firmware, input, profile, and paddle layouts
without proving that the report reaches those offsets.

Ignore malformed short reports before consuming mandatory fields, and skip
optional profile or paddle fields when their layout-specific minimum length
is absent. This preserves processing of the validated common input prefix
while avoiding reads of bytes outside the current USB item.

Fixes: 1a48ff81b391 ("Input: xpad - add support for Xbox One controllers")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/input/joystick/xpad.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index feb8f368f834..9a32e7eb464d 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -1035,8 +1035,19 @@ static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char
 	struct input_dev *dev = xpad->dev;
 	bool do_sync = false;
 
+	/*
+	 * The interrupt buffer has room for XPAD_PKT_LEN bytes, but only
+	 * urb->actual_length belongs to this report. Do not interpret bytes
+	 * left over from an earlier, longer report as fields of this one.
+	 */
+	if (!len)
+		return;
+
 	/* the xbox button has its own special report */
 	if (data[0] == GIP_CMD_VIRTUAL_KEY) {
+		if (len < 5)
+			return;
+
 		/*
 		 * The Xbox One S controller requires these reports to be
 		 * acked otherwise it continues sending them forever and
@@ -1052,6 +1063,9 @@ static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char
 	} else if (data[0] == GIP_CMD_FIRMWARE) {
 		/* Some packet formats force us to use this separate to poll paddle inputs */
 		if (xpad->packet_type == PKT_XBE2_FW_5_11) {
+			if (len < 20)
+				return;
+
 			/* Mute paddles if controller is in a custom profile slot
 			 * Checked by looking at the active profile slot to
 			 * verify it's the default slot
@@ -1079,6 +1093,9 @@ static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char
 					 error);
 		}
 	} else if (data[0] == GIP_CMD_INPUT) { /* The main valid packet type for inputs */
+		if (len < 18)
+			return;
+
 		/* menu/view buttons */
 		input_report_key(dev, BTN_START,  data[4] & BIT(2));
 		input_report_key(dev, BTN_SELECT, data[4] & BIT(3));
@@ -1145,13 +1162,16 @@ static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char
 		}
 
 		/* Profile button has a value of 0-3, so it is reported as an axis */
-		if (xpad->mapping & MAP_PROFILE_BUTTON)
+		if ((xpad->mapping & MAP_PROFILE_BUTTON) && len >= 35)
 			input_report_abs(dev, ABS_PROFILE, data[34]);
 
 		/* paddle handling */
 		/* based on SDL's SDL_hidapi_xboxone.c */
 		if (xpad->mapping & MAP_PADDLES) {
 			if (xpad->packet_type == PKT_XBE1) {
+				if (len < 33)
+					goto input_done;
+
 				/* Mute paddles if controller has a custom mapping applied.
 				 * Checked by comparing the current mapping
 				 * config against the factory mapping config
@@ -1165,6 +1185,9 @@ static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char
 				input_report_key(dev, BTN_GRIPL, data[32] & BIT(0));
 				input_report_key(dev, BTN_GRIPL2, data[32] & BIT(2));
 			} else if (xpad->packet_type == PKT_XBE2_FW_OLD) {
+				if (len < 20)
+					goto input_done;
+
 				/* Mute paddles if controller has a custom mapping applied.
 				 * Checked by comparing the current mapping
 				 * config against the factory mapping config
@@ -1178,6 +1201,9 @@ static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char
 				input_report_key(dev, BTN_GRIPL, data[18] & BIT(2));
 				input_report_key(dev, BTN_GRIPL2, data[18] & BIT(3));
 			} else if (xpad->packet_type == PKT_XBE2_FW_5_EARLY) {
+				if (len < 24)
+					goto input_done;
+
 				/* Mute paddles if controller has a custom mapping applied.
 				 * Checked by comparing the current mapping
 				 * config against the factory mapping config
@@ -1195,6 +1221,7 @@ static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char
 			}
 		}
 
+input_done:
 		do_sync = true;
 	}
 
-- 
2.43.0

