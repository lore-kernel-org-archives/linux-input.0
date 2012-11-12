From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH] HID: microsoft, do not use compound literal
Date: Mon, 12 Nov 2012 10:16:09 +0100
Message-ID: <1352711769-28911-1-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.pripojeni.net ([178.22.112.14]:40594 "EHLO
	smtp.pripojeni.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502Ab2KLJQQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Nov 2012 04:16:16 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, jirislaby@gmail.com

In patch "HID: microsoft: fix invalid rdesc for 3k kbd" I fixed
support for MS 3k keyboards. However the added check using memcmp and
a compound statement breaks build on architectures where memcmp is a
macro with parameters. The error looks there like (m68k-linux-gnu-gcc
4.1.2):
hid-microsoft.c:51:18: error: macro "memcmp" passed 6 arguments, but ta=
kes just 3
hid-microsoft.c: In function =E2=80=98ms_report_fixup=E2=80=99:
drivers/hid/hid-microsoft.c:50: error: =E2=80=98memcmp=E2=80=99 undecla=
red (first use in this function)
hid-microsoft.c:50: error: (Each undeclared identifier is reported only=
 once
/hid-microsoft.c:50: error: for each function it appears in.)

On x86_64, memcmp is a function, so I did not see the error.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/hid/hid-microsoft.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
index f676c01..6fcd466 100644
--- a/drivers/hid/hid-microsoft.c
+++ b/drivers/hid/hid-microsoft.c
@@ -46,9 +46,9 @@ static __u8 *ms_report_fixup(struct hid_device *hdev,=
 __u8 *rdesc,
 		rdesc[559] =3D 0x45;
 	}
 	/* the same as above (s/usage/physical/) */
-	if ((quirks & MS_RDESC_3K) && *rsize =3D=3D 106 &&
-			!memcmp((char []){ 0x19, 0x00, 0x29, 0xff },
-				&rdesc[94], 4)) {
+	if ((quirks & MS_RDESC_3K) && *rsize =3D=3D 106 && rdesc[94] =3D=3D 0=
x19 &&
+			rdesc[95] =3D=3D 0x00 && rdesc[96] =3D=3D 0x29 &&
+			rdesc[97] =3D=3D 0xff) {
 		rdesc[94] =3D 0x35;
 		rdesc[96] =3D 0x45;
 	}
--=20
1.8.0


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
