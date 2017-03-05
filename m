From: Stephen Lyons <slysven@virginmedia.com>
Subject: [patch] input: psmouse - fix for second scroll wheel on A4Tech
 Dual-Scroll wheel mice
Date: Sun, 5 Mar 2017 23:52:11 +0000
Message-ID: <c371ffe0-bbe5-a1f4-7f0a-d012da63d232@virginmedia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cfe4NjDM3h8oile1NG1Q7e9OwcWlhaUKk"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from know-smtprelay-omc-5.server.virginmedia.net ([80.0.253.69]:35136
        "EHLO know-smtprelay-omc-5.server.virginmedia.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752442AbdCEX6i (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 5 Mar 2017 18:58:38 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cfe4NjDM3h8oile1NG1Q7e9OwcWlhaUKk
Content-Type: multipart/mixed; boundary="xiFNnGnOj0wPU6xQTbKrURCxLnd9oJPIM";
 protected-headers="v1"
From: Stephen Lyons <slysven@virginmedia.com>
To: linux-input@vger.kernel.org
Message-ID: <c371ffe0-bbe5-a1f4-7f0a-d012da63d232@virginmedia.com>
Subject: [patch] input: psmouse - fix for second scroll wheel on A4Tech
 Dual-Scroll wheel mice

--xiFNnGnOj0wPU6xQTbKrURCxLnd9oJPIM
Content-Type: multipart/mixed;
 boundary="------------40EFEBBF6A2A262D71AF739F"

This is a multi-part message in MIME format.
--------------40EFEBBF6A2A262D71AF739F
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This Far-Eastern company's PS/2 mice use a deviant format for the data
relating to movement of the scroll wheels for, at least, their dual
wheel mice, such as their "Optical GreatEye Wheelmouse" model "WOP-35".
This product has five "buttons" (one of which is the click action on the
first wheel) and TWO scroll wheels.  However for a byte comprising d0-d7
instead of setting one of d6-7 in the forth byte of the mouse data
packet and a twos complement number of scroll steps in the remaining
d5-d0 (or d3-d0 should there be a fourth (BTN_SIDE - d4) or fifth
(BTN_EXTRA - d5) button to report; they only report a single +/- event
for each wheel and use a bit pattern that corresponds to +/-1 for the
first wheel and +/- 2 for the second in the lower nibble of the fourth by=
te.

The effect with existing code is that the second mouse wheel merely
repeats the effect of the first but providing two steps per click rather
than the one of the first wheel - so there is no HORIZONTAL scroll wheel
movement detected from the device as far as the rest of the kernel sees i=
t.

This patch, if enabled by the "a4tech_workaround" module parameter
modifies the handling just for mice of type PSMOUSE_IMEX so that the
second scroll wheel movement gets correctly reported as REL_HWHEEL
events.  Should this module parameter be activated for other mice of the
same PSMOUSE_IMEX type then it is possible that at the point where the
mouse reports more than a single movement step the user may start seeing
horizontal rather than vertical wheel events, but should the movement
steps get to be more than two at a time the hack will get immediately
deactivated and the behaviour will revert to the past code.

This was discussed around fifteen years ago on the LKML and the best
summary is in post https://lkml.org/lkml/2002/7/18/111 "Re: PS2 Input
Core Support" by Vojtech Pavlik. I was not able to locate any discussion
later than this on this topic.

Given that most users of the "psmouse" module will NOT want this
additional feature enabled I have taken the apparently erroneous step of
defaulting the module parameter that enables it to be "disabled" - this
functionality may interfere with the operation of "normal" mice of this
type (until a large enough scroll wheel movement is detected) so I
cannot see how it would want to be enabled for "normal" users - i.e.
everyone without this brand of mouse.

I am using this patch at the moment and I can confirm that it is working
for me as both a module and compiled into the kernel for my mouse that
is of the type (WOP-35) described - I note that it is still available
from certain on-line retailers and that the manufacturers site does not
list GNU/Linux as being supported on the product page - this patch
enables full use of this product:
http://www.a4tech.com/product.asp?cid=3D1&scid=3D8&id=3D22

Tested-by: Stephen Lyons <slysven@virginmedia.com>
Signed-off-by: Stephen Lyons <slysven@virginmedia.com>

--------------40EFEBBF6A2A262D71AF739F
Content-Type: text/x-patch;
 name="a4tech_2scroll_wheel.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="a4tech_2scroll_wheel.patch"

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psm=
ouse-base.c
index a598b72..cb3d68a 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -68,6 +68,10 @@ static bool psmouse_smartscroll =3D true;
 module_param_named(smartscroll, psmouse_smartscroll, bool, 0644);
 MODULE_PARM_DESC(smartscroll, "Logitech Smartscroll autorepeat, 1 =3D en=
abled (default), 0 =3D disabled.");
=20
+static bool psmouse_a4tech_2wheels =3D false;
+module_param_named(a4tech_workaround, psmouse_a4tech_2wheels, bool, 0644=
);
+MODULE_PARM_DESC(a4tech_workaround, "A4Tech second scroll wheel workarou=
nd, 1 =3D enabled, 0 =3D disabled(default).");
+
 static unsigned int psmouse_resetafter =3D 5;
 module_param_named(resetafter, psmouse_resetafter, uint, 0644);
 MODULE_PARM_DESC(resetafter, "Reset device after so many bad packets (0 =
=3D never).");
@@ -164,13 +168,64 @@ psmouse_ret_t psmouse_process_byte(struct psmouse *=
psmouse)
 			input_report_rel(dev, REL_HWHEEL, (int) (packet[3] & 32) - (int) (pac=
ket[3] & 31));
 			break;
 		case 0x00:
-		case 0xC0:
-			input_report_rel(dev, REL_WHEEL, (int) (packet[3] & 8) - (int) (packe=
t[3] & 7));
+		case 0xC0: /*
+			    * Some A4Tech mice have two scroll wheels but they
+			    * only return +/-1 for first or +/-2 for second
+			    * scroll wheel using LS Nibble so standard code
+			    * effectively multipled the movement by two for the
+			    * second wheel but reported it as a first wheel
+			    * movement.
+			    */
+			if (psmouse_a4tech_2wheels)
+				switch (packet[3] & 0x0F) {
+				case 0x0F: /* Upwards on first wheel*/
+					input_report_rel(dev, REL_WHEEL,
+								(int) (+1));
+					break;
+				case 0x0E: /*
+					    * Upwards on second wheel, sign
+					    * inverted so it becomes to the left
+					    */
+					input_report_rel(dev, REL_HWHEEL,
+								(int) (-1));
+					break;
+				case 0x02: /*
+					    * Downwards on second wheel, sign
+					    * inverted so it becomes to the
+					    * right
+					    */
+					input_report_rel(dev, REL_HWHEEL,
+								(int) (+1));
+					break;
+				case 0x01: /* Downwards on first wheel */
+					input_report_rel(dev, REL_WHEEL,
+								(int) (-1));
+					break;
+				case 0x00: /* Valid, but no-op */
+					break;
+				default: /*
+					  * Out of range data, assume hack is not
+					  * applicable after all.
+					  */
+					psmouse_warn(psmouse,
+							"%s at %s - unexpected scroll wheel data detected!\n"
+							"Bytes processed were: 0x%02x%02x%02x%02x.\n"
+							"The A4Tech Second scroll wheel workaround has been disabled.\n",=

+							psmouse->name, psmouse->phys,
+							packet[0], packet[1],
+							packet[2], packet[3]);
+					psmouse_a4tech_2wheels =3D false;
+				}
+			else
+				input_report_rel(dev, REL_WHEEL,
+							(int) (packet[3] & 8)
+							-(int) (packet[3] & 7));
+
 			input_report_key(dev, BTN_SIDE, (packet[3] >> 4) & 1);
 			input_report_key(dev, BTN_EXTRA, (packet[3] >> 5) & 1);
 			break;
-		}
-		break;
+		} /* switch (packet[3] & 0xC) cases 0x00 AND 0xC0 */
+		break; /* case PSMOUSE_IMEX */
=20
 	case PSMOUSE_GENPS:
 		/* Report scroll buttons on NetMice */

--------------40EFEBBF6A2A262D71AF739F--

--xiFNnGnOj0wPU6xQTbKrURCxLnd9oJPIM--

--cfe4NjDM3h8oile1NG1Q7e9OwcWlhaUKk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYvKS3AAoJEOvWitvKtOVW3G8H/39TScfP/qzGuHZBUPhWzw/+
CT5avJIkkT0SKwoR5ONiEXsiBvUbOaT+hDN76xlkr1bXBzB4WwukahvuoKeTW7Z3
Imxl8K4GWEqoTj2+h0LHWKOuoB0/jtQIOUhHPA0AHZe+6cdijO8vm29t8CakiCw7
tDJKaor2L588AUAbwgnSgqJY25wS0KSKv7wQSQd0b391avxBX+cTmFNP1lBukQF7
VScRq5c1TnJWy9mmeA0iKysnzgK8fXwbmbV/jiklY7KQzmVoK7kbZivnhhNT6sHj
BZeU3+tzxM/x25230Gv/BDaJ5paT172ScRwOKVJekAz0a2FuEgrTZfkfAO7s5NM=
=1Hj8
-----END PGP SIGNATURE-----

--cfe4NjDM3h8oile1NG1Q7e9OwcWlhaUKk--
