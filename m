From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH 1/3] input: alps: Reset mouse before identifying it
Date: Fri,  3 Oct 2014 11:43:10 +0200
Message-ID: <1412329392-5580-2-git-send-email-pali.rohar@gmail.com>
References: <1412329392-5580-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1412329392-5580-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Yunkang Tang <yunkang.tang@cn.alps.com>, Tommy Will <tommywill2011@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-input@vger.kernel.org

On some systems after starting computer function alps_identify() does n=
ot detect
dual ALPS touchpad+trackstick device correctly and detect only touchpad=
=2E

Resetting ALPS device before identifiying it fixing this problem and bo=
th parts
touchpad and trackstick are detected.

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
Tested-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
---
 drivers/input/mouse/alps.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 35a49bf..1bd5aa1 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -2403,6 +2403,8 @@ int alps_detect(struct psmouse *psmouse, bool set=
_properties)
 {
 	struct alps_data dummy;
=20
+	psmouse_reset(psmouse);
+
 	if (alps_identify(psmouse, &dummy) < 0)
 		return -1;
=20
--=20
1.7.9.5
