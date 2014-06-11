From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] HID: rmi: Protect PM-only functions by #ifdef CONFIG_PM
Date: Wed, 11 Jun 2014 21:03:18 +0200
Message-ID: <1402513398-17546-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:47634 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578AbaFKTDY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Jun 2014 15:03:24 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

If CONFIG_PM=3Dn:

drivers/hid/hid-rmi.c:432: warning: =E2=80=98rmi_post_reset=E2=80=99 de=
fined but not used
drivers/hid/hid-rmi.c:437: warning: =E2=80=98rmi_post_resume=E2=80=99 d=
efined but not used

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/hid/hid-rmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
index 2451c7e5febd..578bbe65902b 100644
--- a/drivers/hid/hid-rmi.c
+++ b/drivers/hid/hid-rmi.c
@@ -428,6 +428,7 @@ static int rmi_raw_event(struct hid_device *hdev,
 	return 0;
 }
=20
+#ifdef CONFIG_PM
 static int rmi_post_reset(struct hid_device *hdev)
 {
 	return rmi_set_mode(hdev, RMI_MODE_ATTN_REPORTS);
@@ -437,6 +438,7 @@ static int rmi_post_resume(struct hid_device *hdev)
 {
 	return rmi_set_mode(hdev, RMI_MODE_ATTN_REPORTS);
 }
+#endif /* CONFIG_PM */
=20
 #define RMI4_MAX_PAGE 0xff
 #define RMI4_PAGE_SIZE 0x0100
--=20
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
