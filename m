From: =?UTF-8?q?Thomas=20B=C3=A4chler?= <thomas@archlinux.org>
Subject: [PATCH] input: alps: Add support for the touchpad of the Toshiba Tecra A11-11L
Date: Tue,  9 Mar 2010 19:56:07 +0100
Message-ID: <1268160967-21403-1-git-send-email-thomas@archlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gerolde.archlinux.org ([66.211.214.132]:39554 "EHLO
	archlinux.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755359Ab0CITGJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Mar 2010 14:06:09 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, =?UTF-8?q?Thomas=20B=C3=A4chler?= <thomas@archlinux.org>


Signed-off-by: Thomas B=C3=A4chler <thomas@archlinux.org>
---
This patch was made by trial-and-error, I copied the byte0 and
mask0 value from another model, tried different flags settings
and it seems to work. I have no idea if there might be side-
effects due to incorrect settings. Please tell me if I can do
anything to verify or correct these values.

 drivers/input/mouse/alps.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index f93c2c0..f6dad83 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -63,6 +63,8 @@ static const struct alps_model_info alps_model_data[]=
 =3D {
 	{ { 0x62, 0x02, 0x14 }, 0xcf, 0xcf,
 		ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_INTERLEAVED },
 	{ { 0x73, 0x02, 0x50 }, 0xcf, 0xcf, ALPS_FOUR_BUTTONS },	  /* Dell Vo=
stro 1400 */
+	{ { 0x52, 0x01, 0x14 }, 0xff, 0xff,
+		ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_INTERLEAVED },	  /* Toshiba Te=
cra A11-11L */
 };
=20
 /*
--=20
1.7.0.1

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
