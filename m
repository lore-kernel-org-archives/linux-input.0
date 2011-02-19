From: Dustan Bower <dustan.bower@gmail.com>
Subject: [PATCH] Input: serio: Compile error fix (altera_ps2.c)
Date: Sat, 19 Feb 2011 15:04:19 -0500
Message-ID: <1298145859-10892-1-git-send-email-dustan.bower@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:63417 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753568Ab1BSUFt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 19 Feb 2011 15:05:49 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dustan Bower <dustan.bower@gmail.com>

=46ixed compile error, today's linux-next tree:

  CC [M]  drivers/input/serio/altera_ps2.o
drivers/input/serio/altera_ps2.c:182:1: error: expected =E2=80=98,=E2=80=
=99 or =E2=80=98;=E2=80=99 before =E2=80=98extern=E2=80=99
make[1]: *** [drivers/input/serio/altera_ps2.o] Error 1
make: *** [_module_drivers/input/serio] Error 2

Signed-off-by: Dustan Bower <dustan.bower@gmail.com>
---
 drivers/input/serio/altera_ps2.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/serio/altera_ps2.c b/drivers/input/serio/alt=
era_ps2.c
index 3fee88b..d363dc4 100644
--- a/drivers/input/serio/altera_ps2.c
+++ b/drivers/input/serio/altera_ps2.c
@@ -178,7 +178,7 @@ static int __devexit altera_ps2_remove(struct platf=
orm_device *pdev)
 static const struct of_device_id altera_ps2_match[] =3D {
 	{ .compatible =3D "ALTR,ps2-1.0", },
 	{},
-}
+};
 MODULE_DEVICE_TABLE(of, altera_ps2_match);
 #else /* CONFIG_OF */
 #define altera_ps2_match NULL
--=20
1.7.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
