From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: [patch] HID: picoLCD: off by one in dump_buff_as_hex()
Date: Wed, 19 Sep 2012 21:35:35 +0200
Message-ID: <20120919213535.34712fb5@neptune.home>
References: <20120914110414.GA1152@elgon.mountain>
	<20120917225437.6f2847ee@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay.restena.lu ([158.64.1.62]:58008 "EHLO
	smtprelay.restena.lu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851Ab2ISTgb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Sep 2012 15:36:31 -0400
In-Reply-To: <20120917225437.6f2847ee@neptune.home>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

Dan,

What's your opinion on below alternative patch?
In addition to yours it makes would-overflow visible.

It does not check for output buffer having non-zero size but
as callers are local with #defined buffer size I don't think that would
be needed.





Author: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
Date:   Wed Sep 19 21:18:10 2012 +0200
Subject: HID: picoLCD: bounds check in dump_buff_as_hex()

Make sure we keep enough space for terminating NUL character after last
newline. If we have too much data, replace last byte with '.'s to
make overflow visible.

Using hex_dump_to_buffer() is not interesting as it adds more overhead
and does not append the trailing linefeed.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
---
 drivers/hid/hid-picolcd_debugfs.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-picolcd_debugfs.c b/drivers/hid/hid-picolc=
d_debugfs.c
index 868853a..c5c2fd9 100644
--- a/drivers/hid/hid-picolcd_debugfs.c
+++ b/drivers/hid/hid-picolcd_debugfs.c
@@ -381,16 +381,16 @@ static void dump_buff_as_hex(char *dst, size_t ds=
t_sz, const u8 *data,
 		const size_t data_len)
 {
 	int i, j;
-	for (i =3D j =3D 0; i < data_len && j + 3 < dst_sz; i++) {
+	for (i =3D j =3D 0; i < data_len && j + 4 < dst_sz; i++) {
 		dst[j++] =3D hex_asc[(data[i] >> 4) & 0x0f];
 		dst[j++] =3D hex_asc[data[i] & 0x0f];
 		dst[j++] =3D ' ';
 	}
-	if (j < dst_sz) {
-		dst[j--] =3D '\0';
-		dst[j] =3D '\n';
-	} else
-		dst[j] =3D '\0';
+	dst[j]   =3D '\0';
+	if (j > 0)
+		dst[j-1] =3D '\n';
+	if (i < data_len && j > 2)
+		dst[j-2] =3D dst[j-3] =3D '.';
 }
=20
 void picolcd_debug_out_report(struct picolcd_data *data,
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
