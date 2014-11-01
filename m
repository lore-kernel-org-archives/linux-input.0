From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH v3 2/4] input: alps: Allow 2 invalid packets without resetting device
Date: Sun,  2 Nov 2014 00:25:08 +0100
Message-ID: <1414884310-19842-3-git-send-email-pali.rohar@gmail.com>
References: <1412329392-5580-1-git-send-email-pali.rohar@gmail.com>
 <1414884310-19842-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1414884310-19842-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Yunkang Tang <yunkang.tang@cn.alps.com>, Tommy Will <tommywill2011@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-input@vger.kernel.org

On some Dell Latitude laptops ALPS device or Dell EC send one invalid b=
yte in
6 bytes ALPS packet. In this case psmouse driver enter out of sync stat=
e. It
looks like that all other bytes in packets are valid and also device wo=
rking
properly. So there is no need to do full device reset, just need to wai=
t
for byte which match condition for first byte (start of packet). Becaus=
e ALPS
packets are bigger (6 or 8 bytes) default limit is small.

This patch increase number of invalid bytes to size of 2 ALPS packets w=
hich
psmouse driver can drop before do full reset.

Resetting ALPS devices take some time and when doing reset on some Dell=
 laptops
touchpad, trackstick and also keyboard do not respond. So it is better =
to do it
only if really necessary.

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
Tested-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/input/mouse/alps.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index a772745..7c47e97 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -2391,6 +2391,9 @@ int alps_init(struct psmouse *psmouse)
 	/* We are having trouble resyncing ALPS touchpads so disable it for n=
ow */
 	psmouse->resync_time =3D 0;
=20
+	/* Allow 2 invalid packets without resetting device */
+	psmouse->resetafter =3D psmouse->pktsize * 2;
+
 	return 0;
=20
 init_fail:
--=20
1.7.9.5
