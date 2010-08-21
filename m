From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: [PATCH] Input: mousedev - fix regression of inverting axes
Date: Sat, 21 Aug 2010 15:50:03 +0200
Message-ID: <20100821135002.GA3357@lovely.krouter>
References: <20100820223316.4f6ac734@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41060 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459Ab0HUNp7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 21 Aug 2010 09:45:59 -0400
Content-Disposition: inline
In-Reply-To: <20100820223316.4f6ac734@neptune.home>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>, Daniel Mack <daniel@caiaq.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Aug 20, 2010 at 10:33:16PM +0200, Bruno Pr=E9mont wrote:
> Somewhere between 2.6.35 and Linus's tree as of this writing gpm
> started moving its cursor to the opposite direction of mouse movement=
=2E
>=20
> e.g. moving mouse up causes cursor to move down, moving mouse left
>      causes cursor to go right
>=20
> Under 2.6.35 the cursor moved into the same direction as the mouse.
>=20
> Note, mouse is synaptics touchpad (Acer TravelMate660):
>   Synaptics Touchpad, model: 1, fw: 5.8, id: 0x9d48b1, caps: 0x904713=
/0x4006/0x0
>=20
>=20
> When I get around to it I will try to get more precise information as
> to when this regression got introduced, eventually bisecting.
>=20
> Bruno

Thanks Bruno,
 I successfully tested the patch below with gpm.

---
Introduced by 987a6c0298260b7aa40702b349282554d6180e4b a swap in max/mi=
n
calculation gets fixed by this patch.

Reported-by: Bruno Pr=E9mont <bonbons@linux-vserver.org>
Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 drivers/input/mousedev.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/mousedev.c b/drivers/input/mousedev.c
index 83c24cc..d528a2d 100644
--- a/drivers/input/mousedev.c
+++ b/drivers/input/mousedev.c
@@ -138,8 +138,8 @@ static void mousedev_touchpad_event(struct input_de=
v *dev,
=20
 		fx(0) =3D value;
 		if (mousedev->touch && mousedev->pkt_count >=3D 2) {
-			size =3D input_abs_get_min(dev, ABS_X) -
-					input_abs_get_max(dev, ABS_X);
+			size =3D input_abs_get_max(dev, ABS_X) -
+					input_abs_get_min(dev, ABS_X);
 			if (size =3D=3D 0)
 				size =3D 256 * 2;
=20
@@ -155,8 +155,8 @@ static void mousedev_touchpad_event(struct input_de=
v *dev,
 		fy(0) =3D value;
 		if (mousedev->touch && mousedev->pkt_count >=3D 2) {
 			/* use X size for ABS_Y to keep the same scale */
-			size =3D input_abs_get_min(dev, ABS_X) -
-					input_abs_get_max(dev, ABS_X);
+			size =3D input_abs_get_max(dev, ABS_X) -
+					input_abs_get_min(dev, ABS_X);
 			if (size =3D=3D 0)
 				size =3D 256 * 2;
=20
--=20
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
