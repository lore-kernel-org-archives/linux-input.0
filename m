From: Wolfgang Draxinger <wdraxinger@darkstargames.de>
Subject: Re: input-evdev patch adding option to override XDevice type Atom,
	option to force EV_REL events being treated as absolute values.
Date: Fri, 14 Mar 2008 15:36:35 +0100
Message-ID: <200803141536.43525.wdraxinger@darkstargames.de>
References: <200803110052.00181.wdraxinger@darkstargames.de>
	<20080311090537.ZZRA012@mailhub.coreip.homeip.net>
	<Pine.LNX.4.64.0803141317540.30831@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0020935263=="
Return-path: <xorg-bounces@lists.freedesktop.org>
In-Reply-To: <Pine.LNX.4.64.0803141317540.30831@jikos.suse.cz>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/xorg>
List-Post: <mailto:xorg@lists.freedesktop.org>
List-Help: <mailto:xorg-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=subscribe>
Mime-version: 1.0
Sender: xorg-bounces@lists.freedesktop.org
Errors-To: xorg-bounces@lists.freedesktop.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Nicolas Mailhot <nicolas.mailhot@laposte.net>, xorg@lists.freedesktop.org
List-Id: linux-input@vger.kernel.org

--===============0020935263==
Content-Type: multipart/signed;
  boundary="nextPart4916715.cxdLiVvRbu";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart4916715.cxdLiVvRbu
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Freitag, 14. M=E4rz 2008 schrieb Jiri Kosina:

> Exactly, I fully agree with Dmitry here.
>
> We can easily fix up the device report descriptor in the kernel
> code, so that it would send EV_ABS instead of EV_REL events. We do
> similar fixups (not this particular one) for quite a few devices
> already.
>
> The real question here is whether it is really buggy device, or
> just EV_REL interpretation makes more sense so X input driver, but
> the device itself doesn't send buggy data. Could you please
> elaborate a little bit more?

The device I'm refering to is a 3Dconnexion SpaceNavigator i.e. a=20
Spaceball used to input 3D transformation data*; technically this=20
means it is a 6DOF 'joystick'. 3 axes of translation, 3 axes of=20
rotation (some people/applications treat them as Euler angles, but=20
there's a different method, which suits Spaceballs better).

The values it reports are the translation and rotation of the handle=20
knob, which are by nature absolute values (the device has a neutral=20
position and mechanical limits).

XInput already defines a device type SPACEBALL, which is mostly used=20
as an absolute valuator. A application using it would use the values=20
the device sends, and integrates them using a timer.

Now the SpaceNavigator has some very unusual behaviour: If it's _not_=20
in neutral position it repeatedly sends EV_REL movements, the=20
repeated sending at constant time intervalls causing the valuator in=20
the X server to integrate the values, which are then reported as axis=20
values (just like how a mouse is treated). This is "fine" if you set=20
the device as "SendCoreEvents" to control the pointer with it. But to=20
use it that way in a 3D application (Blender, CADs, whatever) this is=20
definitely the wrong behaviour. I'd even assume, that some 3D apps=20
with spaceball support don't even check, it the device is reported as=20
relative valuator and just assume the motion event axes values as=20
absolute --- checking on the valuator mode, one could differentiate=20
and reintegrate the values, thus removing any offset, but it still=20
requires some extra handling: If the device is (back) in neutral=20
position it doesn't send any events at all. When I first wrote my=20
patch I've overseen this. It has the nasty side effect, that if the=20
device has gone into neutral there's still the very last non-0-value=20
in the application's driver's state machine. The solution is simple:=20
Have a timeout that get's released with each EV_SYN and when it=20
signals send a 0-vector.

So here are the quirks needed to make the SpaceNavigator behave sanely=20
against end user applications --- which might be written naively with=20
the assumption all devices implement the (de facto) standards=20
corrently:

* Values the device report are absolute:
  =3D> Replace EV_REL with EV_ABS.

* Repeatedly sent absolute events of the same value
  don't hurt, but cause some overhead/eat bandwidth
  if X is networked:
  =3D> Only pass on the event if a value changed

* Some devices, like spaceballs, rely on events that
  contain the values of all non-commutative valuators
  (for a spaceball this is rotation):
  =3D> In such case only send full events

* If the device reports absolute values in relative events
  it's likely, that 0-vectors (i.e. device is in neutral
  position) are not reported in form of a event:
  =3D> Add a timeout that triggers a synthetic 0-vector absolute
     event to inform the application of the device being in
     neutral position

=46inally, and completely outside any wrong/kludgy behaviour of the=20
device: Spaceballs should be listed a XDevice with the type=20
atom "SPACEBALL". IMHO an option to override the atom should become a=20
InputSection option, rather than a xf86-input-evdev option: There are=20
a few other drivers that report non-standard atoms. linuxwacom, e.g.=20
set's the atom to "Wacom Stylus" or "Wacom Eraser" whereas there's a=20
proper standard XDevice type atom "TABLET". Anyway xf86-input-evdev=20
needs a option (or some device database) to set the atom to anything=20
else than "KEYBOARD" or "MOUSE", which are the only types it can=20
determine from what the kernel tells. Technically such an option is=20
implemented by replacing just two lines in the current code, like I=20
did in the patch I posted.

And last but not least I noticed (I also reported in my very first=20
post about this) that xf86-input-evdev has a element 'sync' in it's=20
state struct that is nowhere explicitly initialzed. However evdev=20
events are immediately xf86PostMotionEvent-ed if this flag is not set=20
(which it not is, as the compiler silently initialzes it to 0). As=20
long as the axis vectos can be concatenated commutatively (ordinary=20
translation i.e. vector addition) this doesn't hurt. However=20
rotations --- and a spaceball reports rotations --- are not=20
commutative. You can easyly try it out with some cardboard box of=20
some of your computer equipment: First rotate it around the global=20
(i.e. the coordinate system of your desk) X axis (tilt) and then=20
around the Z axis (roll). Memorize the new position. Now bring it=20
back to the original position, then rotate around Z and then X. You=20
see..?
The correct behaviour (just as it is correctly implemented, and only=20
overriden by the sync flag in xf86-input-evdev) is to wait for EV_SYN=20
to post a complete MotionEvent, especially with spaceballs, since the=20
spaceball sends a rotation, for which the values are needed as a=20
bunch. My suggestion: Just drop the sync flag, it's not properly used=20
anyway. I did so in my demonstration patch.

cheers

Wolfgang Draxinger

*) P.S.: Here's some quick and dirty introduction into the basic math=20
of 3D applications, for those not intimate with 3D graphics=20
(programming):

Usually 3D transformations are stored using a 4x4 matrix in homogenous=20
coordinates: The general structure is:

    | R T | =20
M =3D | 0 1 |

where R is a 3x3 rotation matrix (usually being orthonormal), but also=20
determines the scale though the reciprocal normalisation factor (if R=20
is just orthogonal), T is (x, y, z, 1)^t (^t means transposed). The=20
nice things about homogenous transformation matrices is, that any=20
transformations can be concatenated by simple matrix multiplication.

To save space and computation cycles R can be represented in form of a=20
quaternion (a 4 vector, something like a complex number on=20
steroids :-) ), with the first element denoting the angle of rotation=20
and the 3 last elements (which are imaginary numbers) denoting the=20
axis. Determining the equivalent quaternion from a rotation matrix is=20
a eigenvalue problem.

The nice this about quaternions is, that concatenating them requires=20
just 16 scalar multiplications, whereas matrix multiplication=20
requires 64 scalar multiplications.

--nextPart4916715.cxdLiVvRbu
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.6 (GNU/Linux)

iD8DBQBH2o17BfWmRR/TvT4RAq50AKCyjwz2tDtsu5MLPxonJ8kreL5pxgCfZdlR
TPNQRtnsErTj3ywdwNqpgFc=
=va54
-----END PGP SIGNATURE-----

--nextPart4916715.cxdLiVvRbu--

--===============0020935263==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
xorg mailing list
xorg@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/xorg
--===============0020935263==--
