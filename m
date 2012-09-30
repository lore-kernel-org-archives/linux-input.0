From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: HID: picoLCD: optimize for inactive debugfs
Date: Sun, 30 Sep 2012 22:04:19 +0200
Message-ID: <20120930220419.01408e0e@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay.restena.lu ([158.64.1.62]:48783 "EHLO
	smtprelay.restena.lu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790Ab2I3UFV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 30 Sep 2012 16:05:21 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Matthieu CASTET adjusted picolcd_debug_out_report() to only operate whe=
n
there is an active listener on debugfs for events.

His change got lost while splitting hid_picolcd.c, restore it.

Signed-off-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
---


diff --git a/drivers/hid/hid-picolcd_debugfs.c b/drivers/hid/hid-picolc=
d_debugfs.c
index 6ef03be..4809aa1 100644
--- a/drivers/hid/hid-picolcd_debugfs.c
+++ b/drivers/hid/hid-picolcd_debugfs.c
@@ -402,7 +402,7 @@ void picolcd_debug_out_report(struct picolcd_data *=
data,
 #define BUFF_SZ 256
=20
 	/* Avoid unnecessary overhead if debugfs is disabled */
-	if (!hdev->debug_events)
+	if (list_empty(&hdev->debug_list))
 		return;
=20
 	buff =3D kmalloc(BUFF_SZ, GFP_ATOMIC);
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
