From: JJ Ding <jj_ding@emc.com.tw>
Subject: Re: elantech touchpad issues
Date: Thu, 08 Sep 2011 12:18:08 +0800
Message-ID: <87sjo7oef3.fsf@emc.com.tw>
References: <4E6633E5.6080108@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:38659 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902Ab1IHEP7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Sep 2011 00:15:59 -0400
In-Reply-To: <4E6633E5.6080108@t-online.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Richard =?utf-8?Q?Sch=C3=BCtz?= <r.schtz@t-online.de>, linux-input@vger.kernel.org
Cc: Aaron Huang <aaron_huang@emc.com.tw>, Tom Lin <tom_lin@emc.com.tw>

Hi Richard,

It turns out that v2 hardware has debounce packet, too. But with
different signature compared to v3. To the best of my knowledge, I can
only say some models of v2 hardware have this, and others don't. So we
always check for debounce.

Please test this patch and see if it works for you.
Please apply this on up of my v5 series.

Thanks
---
diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 38fb155..1e5ea1d 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -613,6 +613,13 @@ static int elantech_packet_check_v1(struct psmouse *psmouse)
 	       etd->parity[packet[3]] == p3;
 }
 
+static int elantech_check_debounce_v2(struct psmouse *psmouse)
+{
+	const u8 debounce_packet[] = { 0x84, 0xff, 0xff, 0x02, 0xff, 0xff };
+	unsigned char *packet = psmouse->packet;
+	return !memcmp(packet, debounce_packet, sizeof(debounce_packet));
+}
+
 static int elantech_packet_check_v2(struct psmouse *psmouse)
 {
 	struct elantech_data *etd = psmouse->private;
@@ -708,6 +715,9 @@ static psmouse_ret_t elantech_process_byte(struct psmouse *psmouse)
 		break;
 
 	case 2:
+		if (elantech_check_debounce_v2(psmouse))
+			return PSMOUSE_FULL_PACKET;
+
 		if (etd->paritycheck && !elantech_packet_check_v2(psmouse))
 			return PSMOUSE_BAD_DATA;
--
jj
