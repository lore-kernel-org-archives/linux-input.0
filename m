From: Pawel Moll <pawel.moll@arm.com>
Subject: [PATCH v2 01/13] input: ambakmi: (Un)prepare clocks when (dis)enabling
Date: Tue, 18 Sep 2012 15:17:43 +0100
Message-ID: <1347977875-16855-2-git-send-email-pawel.moll@arm.com>
References: <1347977875-16855-1-git-send-email-pawel.moll@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:37375 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933183Ab2IROSE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Sep 2012 10:18:04 -0400
In-Reply-To: <1347977875-16855-1-git-send-email-pawel.moll@arm.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
Cc: Pawel Moll <pawel.moll@arm.com>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Clocks must be prepared before enabling and unprepared
after disabling. Use appropriate functions to do this
in one go.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 drivers/input/serio/ambakmi.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Hi Russell, Dmitry,

What would be your preference regarding merging this patch? Russell's patch
system? Dmitry's git tree? Or maybe you want me to add it to a pull request
for arm-soc guys?

Cheers!

Pawel

diff --git a/drivers/input/serio/ambakmi.c b/drivers/input/serio/ambakmi.c
index 2ffd110..2e77246 100644
--- a/drivers/input/serio/ambakmi.c
+++ b/drivers/input/serio/ambakmi.c
@@ -72,7 +72,7 @@ static int amba_kmi_open(struct serio *io)
 =09unsigned int divisor;
 =09int ret;
=20
-=09ret =3D clk_enable(kmi->clk);
+=09ret =3D clk_prepare_enable(kmi->clk);
 =09if (ret)
 =09=09goto out;
=20
@@ -92,7 +92,7 @@ static int amba_kmi_open(struct serio *io)
 =09return 0;
=20
  clk_disable:
-=09clk_disable(kmi->clk);
+=09clk_disable_unprepare(kmi->clk);
  out:
 =09return ret;
 }
@@ -104,7 +104,7 @@ static void amba_kmi_close(struct serio *io)
 =09writeb(0, KMICR);
=20
 =09free_irq(kmi->irq, kmi);
-=09clk_disable(kmi->clk);
+=09clk_disable_unprepare(kmi->clk);
 }
=20
 static int __devinit amba_kmi_probe(struct amba_device *dev,
--=20
1.7.9.5


