From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [PATCH] Input: Let the FT5x06 driver build without debugfs
Date: Thu, 16 Aug 2012 17:15:16 -0700
Message-ID: <87k3wy1ii3.fsf@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:40813 "EHLO
	out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531Ab2HQAPZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Aug 2012 20:15:25 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Budig <simon.budig@kernelconcepts.de>
Cc: Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org


When testing to make certain my user namespace code works
in various configurations I tripped over the tf5x06.c not
building with debugfs disabled.

drivers/input/touchscreen/edt-ft5x06.c: In function =E2=80=98edt_ft5x06=
_ts_remove=E2=80=99:
drivers/input/touchscreen/edt-ft5x06.c:846:14: error: =E2=80=98struct e=
dt_ft5x06_ts_data=E2=80=99 has no member named =E2=80=98raw_buffer=E2=80=
=99

=46ix the build by placing an #ifdef around the problem kfree.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 drivers/input/touchscreen/edt-ft5x06.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/tou=
chscreen/edt-ft5x06.c
index 9afc777..bc160b3 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -843,7 +843,9 @@ static int __devexit edt_ft5x06_ts_remove(struct i2=
c_client *client)
 	if (gpio_is_valid(pdata->reset_pin))
 		gpio_free(pdata->reset_pin);
=20
+#if defined(CONFIG_DEBUG_FS)
 	kfree(tsdata->raw_buffer);
+#endif
 	kfree(tsdata);
=20
 	return 0;
--=20
1.7.5.4

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
