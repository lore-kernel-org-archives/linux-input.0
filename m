From: Mauro Carvalho Chehab <mchehab@redhat.com>
Subject: [PATCH 6/8] V4L/DVB: ir-core: fix gcc warning noise
Date: Thu, 8 Apr 2010 16:37:17 -0300
Message-ID: <20100408163717.322a8d9c@pedra>
References: <cover.1270754989.git.mchehab@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <cover.1270754989.git.mchehab@redhat.com>
Sender: linux-media-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Linux Media Mailing List <linux-media@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

drivers/media/IR/ir-sysfs.c: In function =E2=80=98store_protocol=E2=80=99=
:
drivers/media/IR/ir-sysfs.c:93: warning: suggest parentheses around ass=
ignment used as truth value

Signed-off-by: Mauro Carvalho Chehab <mchehab@redhat.com>

diff --git a/drivers/media/IR/ir-sysfs.c b/drivers/media/IR/ir-sysfs.c
index 9d132d0..17d4341 100644
--- a/drivers/media/IR/ir-sysfs.c
+++ b/drivers/media/IR/ir-sysfs.c
@@ -90,7 +90,7 @@ static ssize_t store_protocol(struct device *d,
 	unsigned long flags;
 	char *buf;
=20
-	while (buf =3D strsep((char **) &data, " \n")) {
+	while ((buf =3D strsep((char **) &data, " \n")) !=3D NULL) {
 		if (!strcasecmp(buf, "rc-5") || !strcasecmp(buf, "rc5"))
 			ir_type |=3D IR_TYPE_RC5;
 		if (!strcasecmp(buf, "pd") || !strcasecmp(buf, "pulse-distance"))
--=20
1.6.6.1
