From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: Fix sudden warps in mousedev
Date: Sun, 25 Mar 2007 23:19:38 -0400
Message-ID: <200703252319.39676.dtor@insightbb.com>
References: <20070324001610.724a820a.zaitcev@redhat.com> <200703250134.03416.dtor@insightbb.com> <20070325111930.f6428509.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070325111930.f6428509.zaitcev@redhat.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Sunday 25 March 2007 14:19, Pete Zaitcev wrote:
> On Sun, 25 Mar 2007 01:34:02 -0400, Dmitry Torokhov <dtor@insightbb.com> =
wrote:
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * Without this, a touchpad may report an unchanged=
 position,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * then a sync. The input_event() eats the position=
 report, but
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * lets the sync through. We increment pkt_count an=
d leave=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * a stale position in the ring. If a future refere=
nce to fx(2)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * hits the stale position, a large dx is reported,=
 and the
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * pointer warps across the screen.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0dev =3D mousedev->handle.dev;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0fx(0) =3D dev->abs[ABS_X];
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0fy(0) =3D dev->abs[ABS_Y];
> >=20
> > I do not like input hanlders poking into input devices... Can't we just
> > reset pkt_count at the beginning of the touch to get rid of stale data?
>=20
> The pkt_count is zero at the moment of assignment above.

Riiight... Of course you are right...

I tried to reproduce warping on console but could not for some reason. Coul=
d you
please try the patch below and tell me if it fixes the problem for you?

=2D-=20
Dmitry

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
=2D--

 drivers/input/mousedev.c |   51 +++++++++++++++++++++++-------------------=
=2D----
 1 files changed, 26 insertions(+), 25 deletions(-)

Index: work/drivers/input/mousedev.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- work.orig/drivers/input/mousedev.c
+++ work/drivers/input/mousedev.c
@@ -124,32 +124,33 @@ static void mousedev_touchpad_event(stru
 	int size, tmp;
 	enum { FRACTION_DENOM =3D 128 };
=20
=2D	if (mousedev->touch) {
=2D		size =3D dev->absmax[ABS_X] - dev->absmin[ABS_X];
=2D		if (size =3D=3D 0)
=2D			size =3D 256 * 2;
=2D
=2D		switch (code) {
=2D			case ABS_X:
=2D				fx(0) =3D value;
=2D				if (mousedev->pkt_count >=3D 2) {
=2D					tmp =3D ((value - fx(2)) * (256 * FRACTION_DENOM)) / size;
=2D					tmp +=3D mousedev->frac_dx;
=2D					mousedev->packet.dx =3D tmp / FRACTION_DENOM;
=2D					mousedev->frac_dx =3D tmp - mousedev->packet.dx * FRACTION_DENOM;
=2D				}
=2D				break;
+	switch (code) {
+		case ABS_X:
+			fx(0) =3D value;
+			if (mousedev->touch && mousedev->pkt_count >=3D 2) {
+				size =3D dev->absmax[ABS_X] - dev->absmin[ABS_X];
+				if (size =3D=3D 0)
+					size =3D 256 * 2;
+				tmp =3D ((value - fx(2)) * (256 * FRACTION_DENOM)) / size;
+				tmp +=3D mousedev->frac_dx;
+				mousedev->packet.dx =3D tmp / FRACTION_DENOM;
+				mousedev->frac_dx =3D tmp - mousedev->packet.dx * FRACTION_DENOM;
+			}
+			break;
=20
=2D			case ABS_Y:
=2D				fy(0) =3D value;
=2D				if (mousedev->pkt_count >=3D 2) {
=2D					tmp =3D -((value - fy(2)) * (256 * FRACTION_DENOM)) / size;
=2D					tmp +=3D mousedev->frac_dy;
=2D					mousedev->packet.dy =3D tmp / FRACTION_DENOM;
=2D					mousedev->frac_dy =3D tmp - mousedev->packet.dy * FRACTION_DENOM;
=2D				}
=2D				break;
=2D		}
+		case ABS_Y:
+			fy(0) =3D value;
+			if (mousedev->touch && mousedev->pkt_count >=3D 2) {
+				/* use X size to keep the same scale */
+				size =3D dev->absmax[ABS_X] - dev->absmin[ABS_X];
+				if (size =3D=3D 0)
+					size =3D 256 * 2;
+				tmp =3D -((value - fy(2)) * (256 * FRACTION_DENOM)) / size;
+				tmp +=3D mousedev->frac_dy;
+				mousedev->packet.dy =3D tmp / FRACTION_DENOM;
+				mousedev->frac_dy =3D tmp - mousedev->packet.dy * FRACTION_DENOM;
+			}
+			break;
 	}
 }
=20
