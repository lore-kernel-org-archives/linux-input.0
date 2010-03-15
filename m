From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: [PATCH] hid: avoid '\0' in hid debugfs events file
Date: Mon, 15 Mar 2010 19:00:27 +0100
Message-ID: <20100315190027.752c82ea@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from legolas.restena.lu ([158.64.1.34]:57419 "EHLO
	legolas.restena.lu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757045Ab0COSBN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Mar 2010 14:01:13 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

When dumping /sys/kernel/debug/hid/$device/events '\0' characters show =
up
(invisible if cat to console but shown by less or while looking at a du=
mp
file).
These are due to hid_debug_event() adding strlen()+1 bytes to the ring
buffer (e.g. including the trailing '\0').
Any roll-over causes a '\0' as well as hid_debug_event() handles the ri=
ng
buffers with HID_DEBUG_BUFSIZE-1 size while hid_debug_events_read() han=
dles
it with full HID_DEBUG_BUFSIZE size.

Signed-off-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
---
Note:
The ring buffer overflow case (when tail crosses head) seems to be
suboptimal at best.
Would there be a good way to mark those cases so reader can know where
data got lost. (though this might not be easy keeping the lockless
design)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index 6abd036..2602695 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -564,10 +564,10 @@ void hid_debug_event(struct hid_device *hdev, cha=
r *buf)
 	struct hid_debug_list *list;
=20
 	list_for_each_entry(list, &hdev->debug_list, node) {
-		for (i =3D 0; i <=3D strlen(buf); i++)
-			list->hid_debug_buf[(list->tail + i) % (HID_DEBUG_BUFSIZE - 1)] =3D
+		for (i =3D 0; i < strlen(buf); i++)
+			list->hid_debug_buf[(list->tail + i) % HID_DEBUG_BUFSIZE] =3D
 				buf[i];
-		list->tail =3D (list->tail + i) % (HID_DEBUG_BUFSIZE - 1);
+		list->tail =3D (list->tail + i) % HID_DEBUG_BUFSIZE;
         }
 }
 EXPORT_SYMBOL_GPL(hid_debug_event);
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
