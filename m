From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH 2/2] input : wacom - report resolution for pen devices
Date: Sun, 27 Mar 2011 09:32:48 -0500
Message-ID: <AANLkTi=tAt8ZoBur1qdyK3aroquBHGhUnMY458RROHhz@mail.gmail.com>
References: <1301099376-5502-1-git-send-email-pinglinux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:37266 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753550Ab1C0Ocv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 27 Mar 2011 10:32:51 -0400
Received: by bwz15 with SMTP id 15so1874655bwz.19
        for <linux-input@vger.kernel.org>; Sun, 27 Mar 2011 07:32:49 -0700 (PDT)
In-Reply-To: <1301099376-5502-1-git-send-email-pinglinux@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, Ping Cheng <pingc@wacom.com>

On Fri, Mar 25, 2011 at 7:29 PM, Ping Cheng <pinglinux@gmail.com> wrote=
:
> Touch resolution is reported to the userland by retrieving
> the value from the HID descriptor. But pen resolution is not
> since it can not be retrieved. The current Wacom X driver
> has a resolution table. To centralize the source of these
> values, the resolution entries are added in the wacom_features
> struct for x and y coordinates respectively. The values are
> then reported to the userland.
>
> Signed-off-by: Ping Cheng <pingc@wacom.com>

I'm glad you gave up on me saying I'd eventually make this change. :-)

My hold up was I was debating to myself if it should have separate X/Y
resolutions or just a single field.  Its unlikely Wacom will ship
unmatched X/Y's.  For what its worth, a  version of this change in my
local tree also kept separate X/Y's.

Reviewed-by: Chris Bagwell <chris@cnpbagwell.com>

> ---
> =A0drivers/input/tablet/wacom_wac.c | =A0271 ++++++++++++++++++++++++=
+-------------
> =A0drivers/input/tablet/wacom_wac.h | =A0 =A02 +
> =A02 files changed, 181 insertions(+), 92 deletions(-)
>
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/=
wacom_wac.c
> index ba6e17c..6b527cb 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -12,6 +12,14 @@
> =A0* (at your option) any later version.
> =A0*/
>
> +/* resolution for penabled devices */
> +#define WACOM_PL_RES =A0 =A0 =A0 =A0 =A0 20
> +#define WACOM_PENPRTN_RES =A0 =A0 =A040
> +#define WACOM_VOLITO_RES =A0 =A0 =A0 50
> +#define WACOM_GRAPHIRE_RES =A0 =A0 80
> +#define WACOM_INTUOS_RES =A0 =A0 =A0 100
> +#define WACOM_INTUOS3_RES =A0 =A0 =A0200
> +
> =A0#include "wacom_wac.h"
> =A0#include "wacom.h"
> =A0#include <linux/input/mt.h>
> @@ -1055,6 +1063,19 @@ void wacom_setup_input_capabilities(struct inp=
ut_dev *input_dev,
> =A0 =A0 =A0 =A0input_set_abs_params(input_dev, ABS_PRESSURE, 0, featu=
res->pressure_max,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->pre=
ssure_fuzz, 0);
>
> + =A0 =A0 =A0 if (features->device_type =3D=3D BTN_TOOL_PEN) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* penabled devices have fixed resoluti=
on for each model */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_abs_set_res(input_dev, ABS_X, fea=
tures->x_resolution);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_abs_set_res(input_dev, ABS_Y, fea=
tures->y_resolution);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_abs_set_res(input_dev, ABS_X,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom_calculate_touch_r=
es(features->x_max,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 features->x_phy));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_abs_set_res(input_dev, ABS_Y,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom_calculate_touch_r=
es(features->y_max,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 features->y_phy));
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0__set_bit(ABS_MISC, input_dev->absbit);
>
> =A0 =A0 =A0 =A0switch (wacom_wac->features.type) {
> @@ -1171,15 +1192,9 @@ void wacom_setup_input_capabilities(struct inp=
ut_dev *input_dev,
> =A0 =A0 =A0 =A0case TABLETPC:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__clear_bit(ABS_MISC, input_dev->absbi=
t);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (features->device_type !=3D BTN_TOOL=
_PEN) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_abs_set_res(input=
_dev, ABS_X,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom_c=
alculate_touch_res(features->x_max,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->x_phy));
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_abs_set_res(input=
_dev, ABS_Y,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom_c=
alculate_touch_res(features->y_max,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->y_phy));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (features->device_type !=3D BTN_TOOL=
_PEN)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break; =A0/* no need t=
o process stylus stuff */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* fall through */
>
> =A0 =A0 =A0 =A0case PL:
> @@ -1216,12 +1231,6 @@ void wacom_setup_input_capabilities(struct inp=
ut_dev *input_dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_set_abs_params(i=
nput_dev, ABS_MT_PRESSURE,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 0, features->pressure_max,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 features->pressure_fuzz, 0);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_abs_set_res(input=
_dev, ABS_X,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom_c=
alculate_touch_res(features->x_max,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->x_phy));
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_abs_set_res(input=
_dev, ABS_Y,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom_c=
alculate_touch_res(features->y_max,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->y_phy));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else if (features->device_type =3D=3D=
 BTN_TOOL_PEN) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__set_bit(BTN_TOOL_RUB=
BER, input_dev->keybit);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__set_bit(BTN_TOOL_PEN=
, input_dev->keybit);
> @@ -1233,161 +1242,239 @@ void wacom_setup_input_capabilities(struct =
input_dev *input_dev,
> =A0}
>
> =A0static const struct wacom_features wacom_features_0x00 =3D
> - =A0 =A0 =A0 { "Wacom Penpartner", =A0 =A0 WACOM_PKGLEN_PENPRTN, =A0=
 =A05040, =A03780, =A0255, =A00, PENPARTNER };
> + =A0 =A0 =A0 { "Wacom Penpartner", =A0 =A0 WACOM_PKGLEN_PENPRTN, =A0=
 =A05040, =A03780, =A0255,
> + =A0 =A0 =A0 =A0 0, PENPARTNER, WACOM_PENPRTN_RES, WACOM_PENPRTN_RES=
 };
> =A0static const struct wacom_features wacom_features_0x10 =3D
> - =A0 =A0 =A0 { "Wacom Graphire", =A0 =A0 =A0 WACOM_PKGLEN_GRAPHIRE, =
=A010206, =A07422, =A0511, 63, GRAPHIRE };
> + =A0 =A0 =A0 { "Wacom Graphire", =A0 =A0 =A0 WACOM_PKGLEN_GRAPHIRE, =
=A010206, =A07422, =A0511,
> + =A0 =A0 =A0 =A0 63, GRAPHIRE, WACOM_GRAPHIRE_RES, WACOM_GRAPHIRE_RE=
S };
> =A0static const struct wacom_features wacom_features_0x11 =3D
> - =A0 =A0 =A0 { "Wacom Graphire2 4x5", =A0WACOM_PKGLEN_GRAPHIRE, =A01=
0206, =A07422, =A0511, 63, GRAPHIRE };
> + =A0 =A0 =A0 { "Wacom Graphire2 4x5", =A0WACOM_PKGLEN_GRAPHIRE, =A01=
0206, =A07422, =A0511,
> + =A0 =A0 =A0 =A0 63, GRAPHIRE, WACOM_GRAPHIRE_RES, WACOM_GRAPHIRE_RE=
S };
> =A0static const struct wacom_features wacom_features_0x12 =3D
> - =A0 =A0 =A0 { "Wacom Graphire2 5x7", =A0WACOM_PKGLEN_GRAPHIRE, =A01=
3918, 10206, =A0511, 63, GRAPHIRE };
> + =A0 =A0 =A0 { "Wacom Graphire2 5x7", =A0WACOM_PKGLEN_GRAPHIRE, =A01=
3918, 10206, =A0511,
> + =A0 =A0 =A0 =A0 63, GRAPHIRE, WACOM_GRAPHIRE_RES, WACOM_GRAPHIRE_RE=
S };
> =A0static const struct wacom_features wacom_features_0x13 =3D
> - =A0 =A0 =A0 { "Wacom Graphire3", =A0 =A0 =A0WACOM_PKGLEN_GRAPHIRE, =
=A010208, =A07424, =A0511, 63, GRAPHIRE };
> + =A0 =A0 =A0 { "Wacom Graphire3", =A0 =A0 =A0WACOM_PKGLEN_GRAPHIRE, =
=A010208, =A07424, =A0511,
> + =A0 =A0 =A0 =A0 63, GRAPHIRE, WACOM_GRAPHIRE_RES, WACOM_GRAPHIRE_RE=
S };
> =A0static const struct wacom_features wacom_features_0x14 =3D
> - =A0 =A0 =A0 { "Wacom Graphire3 6x8", =A0WACOM_PKGLEN_GRAPHIRE, =A01=
6704, 12064, =A0511, 63, GRAPHIRE };
> + =A0 =A0 =A0 { "Wacom Graphire3 6x8", =A0WACOM_PKGLEN_GRAPHIRE, =A01=
6704, 12064, =A0511,
> + =A0 =A0 =A0 =A0 63, GRAPHIRE, WACOM_GRAPHIRE_RES, WACOM_GRAPHIRE_RE=
S };
> =A0static const struct wacom_features wacom_features_0x15 =3D
> - =A0 =A0 =A0 { "Wacom Graphire4 4x5", =A0WACOM_PKGLEN_GRAPHIRE, =A01=
0208, =A07424, =A0511, 63, WACOM_G4 };
> + =A0 =A0 =A0 { "Wacom Graphire4 4x5", =A0WACOM_PKGLEN_GRAPHIRE, =A01=
0208, =A07424, =A0511,
> + =A0 =A0 =A0 =A0 63, WACOM_G4, WACOM_GRAPHIRE_RES, WACOM_GRAPHIRE_RE=
S };
> =A0static const struct wacom_features wacom_features_0x16 =3D
> - =A0 =A0 =A0 { "Wacom Graphire4 6x8", =A0WACOM_PKGLEN_GRAPHIRE, =A01=
6704, 12064, =A0511, 63, WACOM_G4 };
> + =A0 =A0 =A0 { "Wacom Graphire4 6x8", =A0WACOM_PKGLEN_GRAPHIRE, =A01=
6704, 12064, =A0511,
> + =A0 =A0 =A0 =A0 63, WACOM_G4, WACOM_GRAPHIRE_RES, WACOM_GRAPHIRE_RE=
S };
> =A0static const struct wacom_features wacom_features_0x17 =3D
> - =A0 =A0 =A0 { "Wacom BambooFun 4x5", =A0WACOM_PKGLEN_BBFUN, =A0 =A0=
 14760, =A09225, =A0511, 63, WACOM_MO };
> + =A0 =A0 =A0 { "Wacom BambooFun 4x5", =A0WACOM_PKGLEN_BBFUN, =A0 =A0=
 14760, =A09225, =A0511,
> + =A0 =A0 =A0 =A0 63, WACOM_MO, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
> =A0static const struct wacom_features wacom_features_0x18 =3D
> - =A0 =A0 =A0 { "Wacom BambooFun 6x8", =A0WACOM_PKGLEN_BBFUN, =A0 =A0=
 21648, 13530, =A0511, 63, WACOM_MO };
> + =A0 =A0 =A0 { "Wacom BambooFun 6x8", =A0WACOM_PKGLEN_BBFUN, =A0 =A0=
 21648, 13530, =A0511,
> + =A0 =A0 =A0 =A0 63, WACOM_MO, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
> =A0static const struct wacom_features wacom_features_0x19 =3D
> - =A0 =A0 =A0 { "Wacom Bamboo1 Medium", WACOM_PKGLEN_GRAPHIRE, =A0167=
04, 12064, =A0511, 63, GRAPHIRE };
> + =A0 =A0 =A0 { "Wacom Bamboo1 Medium", WACOM_PKGLEN_GRAPHIRE, =A0167=
04, 12064, =A0511,
> + =A0 =A0 =A0 =A0 63, GRAPHIRE, WACOM_GRAPHIRE_RES, WACOM_GRAPHIRE_RE=
S };
> =A0static const struct wacom_features wacom_features_0x60 =3D
> - =A0 =A0 =A0 { "Wacom Volito", =A0 =A0 =A0 =A0 WACOM_PKGLEN_GRAPHIRE=
, =A0 5104, =A03712, =A0511, 63, GRAPHIRE };
> + =A0 =A0 =A0 { "Wacom Volito", =A0 =A0 =A0 =A0 WACOM_PKGLEN_GRAPHIRE=
, =A0 5104, =A03712, =A0511,
> + =A0 =A0 =A0 =A0 63, GRAPHIRE, WACOM_VOLITO_RES, WACOM_VOLITO_RES };
> =A0static const struct wacom_features wacom_features_0x61 =3D
> - =A0 =A0 =A0 { "Wacom PenStation2", =A0 =A0WACOM_PKGLEN_GRAPHIRE, =A0=
 3250, =A02320, =A0255, 63, GRAPHIRE };
> + =A0 =A0 =A0 { "Wacom PenStation2", =A0 =A0WACOM_PKGLEN_GRAPHIRE, =A0=
 3250, =A02320, =A0255,
> + =A0 =A0 =A0 =A0 63, GRAPHIRE, WACOM_VOLITO_RES, WACOM_VOLITO_RES };
> =A0static const struct wacom_features wacom_features_0x62 =3D
> - =A0 =A0 =A0 { "Wacom Volito2 4x5", =A0 =A0WACOM_PKGLEN_GRAPHIRE, =A0=
 5104, =A03712, =A0511, 63, GRAPHIRE };
> + =A0 =A0 =A0 { "Wacom Volito2 4x5", =A0 =A0WACOM_PKGLEN_GRAPHIRE, =A0=
 5104, =A03712, =A0511,
> + =A0 =A0 =A0 =A0 63, GRAPHIRE, WACOM_VOLITO_RES, WACOM_VOLITO_RES };
> =A0static const struct wacom_features wacom_features_0x63 =3D
> - =A0 =A0 =A0 { "Wacom Volito2 2x3", =A0 =A0WACOM_PKGLEN_GRAPHIRE, =A0=
 3248, =A02320, =A0511, 63, GRAPHIRE };
> + =A0 =A0 =A0 { "Wacom Volito2 2x3", =A0 =A0WACOM_PKGLEN_GRAPHIRE, =A0=
 3248, =A02320, =A0511,
> + =A0 =A0 =A0 =A0 63, GRAPHIRE, WACOM_VOLITO_RES, WACOM_VOLITO_RES };
> =A0static const struct wacom_features wacom_features_0x64 =3D
> - =A0 =A0 =A0 { "Wacom PenPartner2", =A0 =A0WACOM_PKGLEN_GRAPHIRE, =A0=
 3250, =A02320, =A0511, 63, GRAPHIRE };
> + =A0 =A0 =A0 { "Wacom PenPartner2", =A0 =A0WACOM_PKGLEN_GRAPHIRE, =A0=
 3250, =A02320, =A0511,
> + =A0 =A0 =A0 =A0 63, GRAPHIRE, WACOM_VOLITO_RES, WACOM_VOLITO_RES };
> =A0static const struct wacom_features wacom_features_0x65 =3D
> - =A0 =A0 =A0 { "Wacom Bamboo", =A0 =A0 =A0 =A0 WACOM_PKGLEN_BBFUN, =A0=
 =A0 14760, =A09225, =A0511, 63, WACOM_MO };
> + =A0 =A0 =A0 { "Wacom Bamboo", =A0 =A0 =A0 =A0 WACOM_PKGLEN_BBFUN, =A0=
 =A0 14760, =A09225, =A0511,
> + =A0 =A0 =A0 =A0 63, WACOM_MO, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
> =A0static const struct wacom_features wacom_features_0x69 =3D
> - =A0 =A0 =A0 { "Wacom Bamboo1", =A0 =A0 =A0 =A0WACOM_PKGLEN_GRAPHIRE=
, =A0 5104, =A03712, =A0511, 63, GRAPHIRE };
> + =A0 =A0 =A0 { "Wacom Bamboo1", =A0 =A0 =A0 =A0WACOM_PKGLEN_GRAPHIRE=
, =A0 5104, =A03712, =A0511,
> + =A0 =A0 =A0 =A0 63, GRAPHIRE, WACOM_PENPRTN_RES, WACOM_PENPRTN_RES =
};
> =A0static const struct wacom_features wacom_features_0x20 =3D
> - =A0 =A0 =A0 { "Wacom Intuos 4x5", =A0 =A0 WACOM_PKGLEN_INTUOS, =A0 =
=A012700, 10600, 1023, 31, INTUOS };
> + =A0 =A0 =A0 { "Wacom Intuos 4x5", =A0 =A0 WACOM_PKGLEN_INTUOS, =A0 =
=A012700, 10600, 1023,
> + =A0 =A0 =A0 =A0 31, INTUOS, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
> =A0static const struct wacom_features wacom_features_0x21 =3D
> - =A0 =A0 =A0 { "Wacom Intuos 6x8", =A0 =A0 WACOM_PKGLEN_INTUOS, =A0 =
=A020320, 16240, 1023, 31, INTUOS };
> + =A0 =A0 =A0 { "Wacom Intuos 6x8", =A0 =A0 WACOM_PKGLEN_INTUOS, =A0 =
=A020320, 16240, 1023,
> + =A0 =A0 =A0 =A0 31, INTUOS, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
> =A0static const struct wacom_features wacom_features_0x22 =3D
> - =A0 =A0 =A0 { "Wacom Intuos 9x12", =A0 =A0WACOM_PKGLEN_INTUOS, =A0 =
=A030480, 24060, 1023, 31, INTUOS };
> + =A0 =A0 =A0 { "Wacom Intuos 9x12", =A0 =A0WACOM_PKGLEN_INTUOS, =A0 =
=A030480, 24060, 1023,
> + =A0 =A0 =A0 =A0 31, INTUOS, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
> =A0static const struct wacom_features wacom_features_0x23 =3D
> - =A0 =A0 =A0 { "Wacom Intuos 12x12", =A0 WACOM_PKGLEN_INTUOS, =A0 =A0=
30480, 31680, 1023, 31, INTUOS };
> + =A0 =A0 =A0 { "Wacom Intuos 12x12", =A0 WACOM_PKGLEN_INTUOS, =A0 =A0=
30480, 31680, 1023,
> + =A0 =A0 =A0 =A0 31, INTUOS, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
> =A0static const struct wacom_features wacom_features_0x24 =3D
> - =A0 =A0 =A0 { "Wacom Intuos 12x18", =A0 WACOM_PKGLEN_INTUOS, =A0 =A0=
45720, 31680, 1023, 31, INTUOS };
> + =A0 =A0 =A0 { "Wacom Intuos 12x18", =A0 WACOM_PKGLEN_INTUOS, =A0 =A0=
45720, 31680, 1023,
> + =A0 =A0 =A0 =A0 31, INTUOS, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
> =A0static const struct wacom_features wacom_features_0x30 =3D
> - =A0 =A0 =A0 { "Wacom PL400", =A0 =A0 =A0 =A0 =A0WACOM_PKGLEN_GRAPHI=
RE, =A0 5408, =A04056, =A0255, =A00, PL };
> + =A0 =A0 =A0 { "Wacom PL400", =A0 =A0 =A0 =A0 =A0WACOM_PKGLEN_GRAPHI=
RE, =A0 5408, =A04056, =A0255,
> + =A0 =A0 =A0 =A0 0, PL, WACOM_PL_RES, WACOM_PL_RES };
> =A0static const struct wacom_features wacom_features_0x31 =3D
> - =A0 =A0 =A0 { "Wacom PL500", =A0 =A0 =A0 =A0 =A0WACOM_PKGLEN_GRAPHI=
RE, =A0 6144, =A04608, =A0255, =A00, PL };
> + =A0 =A0 =A0 { "Wacom PL500", =A0 =A0 =A0 =A0 =A0WACOM_PKGLEN_GRAPHI=
RE, =A0 6144, =A04608, =A0255,
> + =A0 =A0 =A0 =A0 0, PL, WACOM_PL_RES, WACOM_PL_RES };
> =A0static const struct wacom_features wacom_features_0x32 =3D
> - =A0 =A0 =A0 { "Wacom PL600", =A0 =A0 =A0 =A0 =A0WACOM_PKGLEN_GRAPHI=
RE, =A0 6126, =A04604, =A0255, =A00, PL };
> + =A0 =A0 =A0 { "Wacom PL600", =A0 =A0 =A0 =A0 =A0WACOM_PKGLEN_GRAPHI=
RE, =A0 6126, =A04604, =A0255,
> + =A0 =A0 =A0 =A0 0, PL, WACOM_PL_RES, WACOM_PL_RES };
> =A0static const struct wacom_features wacom_features_0x33 =3D
> - =A0 =A0 =A0 { "Wacom PL600SX", =A0 =A0 =A0 =A0WACOM_PKGLEN_GRAPHIRE=
, =A0 6260, =A05016, =A0255, =A00, PL };
> + =A0 =A0 =A0 { "Wacom PL600SX", =A0 =A0 =A0 =A0WACOM_PKGLEN_GRAPHIRE=
, =A0 6260, =A05016, =A0255,
> + =A0 =A0 =A0 =A0 0, PL, WACOM_PL_RES, WACOM_PL_RES };
> =A0static const struct wacom_features wacom_features_0x34 =3D
> - =A0 =A0 =A0 { "Wacom PL550", =A0 =A0 =A0 =A0 =A0WACOM_PKGLEN_GRAPHI=
RE, =A0 6144, =A04608, =A0511, =A00, PL };
> + =A0 =A0 =A0 { "Wacom PL550", =A0 =A0 =A0 =A0 =A0WACOM_PKGLEN_GRAPHI=
RE, =A0 6144, =A04608, =A0511,
> + =A0 =A0 =A0 =A0 0, PL, WACOM_PL_RES, WACOM_PL_RES };
> =A0static const struct wacom_features wacom_features_0x35 =3D
> - =A0 =A0 =A0 { "Wacom PL800", =A0 =A0 =A0 =A0 =A0WACOM_PKGLEN_GRAPHI=
RE, =A0 7220, =A05780, =A0511, =A00, PL };
> + =A0 =A0 =A0 { "Wacom PL800", =A0 =A0 =A0 =A0 =A0WACOM_PKGLEN_GRAPHI=
RE, =A0 7220, =A05780, =A0511,
> + =A0 =A0 =A0 =A0 0, PL, WACOM_PL_RES, WACOM_PL_RES };
> =A0static const struct wacom_features wacom_features_0x37 =3D
> - =A0 =A0 =A0 { "Wacom PL700", =A0 =A0 =A0 =A0 =A0WACOM_PKGLEN_GRAPHI=
RE, =A0 6758, =A05406, =A0511, =A00, PL };
> + =A0 =A0 =A0 { "Wacom PL700", =A0 =A0 =A0 =A0 =A0WACOM_PKGLEN_GRAPHI=
RE, =A0 6758, =A05406, =A0511,
> + =A0 =A0 =A0 =A0 0, PL, WACOM_PL_RES, WACOM_PL_RES };
> =A0static const struct wacom_features wacom_features_0x38 =3D
> - =A0 =A0 =A0 { "Wacom PL510", =A0 =A0 =A0 =A0 =A0WACOM_PKGLEN_GRAPHI=
RE, =A0 6282, =A04762, =A0511, =A00, PL };
> + =A0 =A0 =A0 { "Wacom PL510", =A0 =A0 =A0 =A0 =A0WACOM_PKGLEN_GRAPHI=
RE, =A0 6282, =A04762, =A0511,
> + =A0 =A0 =A0 =A0 0, PL, WACOM_PL_RES, WACOM_PL_RES };
> =A0static const struct wacom_features wacom_features_0x39 =3D
> - =A0 =A0 =A0 { "Wacom DTU710", =A0 =A0 =A0 =A0 WACOM_PKGLEN_GRAPHIRE=
, =A034080, 27660, =A0511, =A00, PL };
> + =A0 =A0 =A0 { "Wacom DTU710", =A0 =A0 =A0 =A0 WACOM_PKGLEN_GRAPHIRE=
, =A034080, 27660, =A0511,
> + =A0 =A0 =A0 =A0 0, PL, WACOM_PL_RES, WACOM_PL_RES };
> =A0static const struct wacom_features wacom_features_0xC4 =3D
> - =A0 =A0 =A0 { "Wacom DTF521", =A0 =A0 =A0 =A0 WACOM_PKGLEN_GRAPHIRE=
, =A0 6282, =A04762, =A0511, =A00, PL };
> + =A0 =A0 =A0 { "Wacom DTF521", =A0 =A0 =A0 =A0 WACOM_PKGLEN_GRAPHIRE=
, =A0 6282, =A04762, =A0511,
> + =A0 =A0 =A0 =A0 0, PL, WACOM_PL_RES, WACOM_PL_RES };
> =A0static const struct wacom_features wacom_features_0xC0 =3D
> - =A0 =A0 =A0 { "Wacom DTF720", =A0 =A0 =A0 =A0 WACOM_PKGLEN_GRAPHIRE=
, =A0 6858, =A05506, =A0511, =A00, PL };
> + =A0 =A0 =A0 { "Wacom DTF720", =A0 =A0 =A0 =A0 WACOM_PKGLEN_GRAPHIRE=
, =A0 6858, =A05506, =A0511,
> + =A0 =A0 =A0 =A0 0, PL, WACOM_PL_RES, WACOM_PL_RES };
> =A0static const struct wacom_features wacom_features_0xC2 =3D
> - =A0 =A0 =A0 { "Wacom DTF720a", =A0 =A0 =A0 =A0WACOM_PKGLEN_GRAPHIRE=
, =A0 6858, =A05506, =A0511, =A00, PL };
> + =A0 =A0 =A0 { "Wacom DTF720a", =A0 =A0 =A0 =A0WACOM_PKGLEN_GRAPHIRE=
, =A0 6858, =A05506, =A0511,
> + =A0 =A0 =A0 =A0 0, PL, WACOM_PL_RES, WACOM_PL_RES };
> =A0static const struct wacom_features wacom_features_0x03 =3D
> - =A0 =A0 =A0 { "Wacom Cintiq Partner", WACOM_PKGLEN_GRAPHIRE, =A0204=
80, 15360, =A0511, =A00, PTU };
> + =A0 =A0 =A0 { "Wacom Cintiq Partner", WACOM_PKGLEN_GRAPHIRE, =A0204=
80, 15360, =A0511,
> + =A0 =A0 =A0 =A0 0, PTU, WACOM_PL_RES, WACOM_PL_RES };
> =A0static const struct wacom_features wacom_features_0x41 =3D
> - =A0 =A0 =A0 { "Wacom Intuos2 4x5", =A0 =A0WACOM_PKGLEN_INTUOS, =A0 =
=A012700, 10600, 1023, 31, INTUOS };
> + =A0 =A0 =A0 { "Wacom Intuos2 4x5", =A0 =A0WACOM_PKGLEN_INTUOS, =A0 =
=A012700, 10600, 1023,
> + =A0 =A0 =A0 =A0 31, INTUOS, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
> =A0static const struct wacom_features wacom_features_0x42 =3D
> - =A0 =A0 =A0 { "Wacom Intuos2 6x8", =A0 =A0WACOM_PKGLEN_INTUOS, =A0 =
=A020320, 16240, 1023, 31, INTUOS };
> + =A0 =A0 =A0 { "Wacom Intuos2 6x8", =A0 =A0WACOM_PKGLEN_INTUOS, =A0 =
=A020320, 16240, 1023,
> + =A0 =A0 =A0 =A0 31, INTUOS, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
> =A0static const struct wacom_features wacom_features_0x43 =3D
> - =A0 =A0 =A0 { "Wacom Intuos2 9x12", =A0 WACOM_PKGLEN_INTUOS, =A0 =A0=
30480, 24060, 1023, 31, INTUOS };
> + =A0 =A0 =A0 { "Wacom Intuos2 9x12", =A0 WACOM_PKGLEN_INTUOS, =A0 =A0=
30480, 24060, 1023,
> + =A0 =A0 =A0 =A0 31, INTUOS, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
> =A0static const struct wacom_features wacom_features_0x44 =3D
> - =A0 =A0 =A0 { "Wacom Intuos2 12x12", =A0WACOM_PKGLEN_INTUOS, =A0 =A0=
30480, 31680, 1023, 31, INTUOS };
> + =A0 =A0 =A0 { "Wacom Intuos2 12x12", =A0WACOM_PKGLEN_INTUOS, =A0 =A0=
30480, 31680, 1023,
> + =A0 =A0 =A0 =A0 31, INTUOS, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
> =A0static const struct wacom_features wacom_features_0x45 =3D
> - =A0 =A0 =A0 { "Wacom Intuos2 12x18", =A0WACOM_PKGLEN_INTUOS, =A0 =A0=
45720, 31680, 1023, 31, INTUOS };
> + =A0 =A0 =A0 { "Wacom Intuos2 12x18", =A0WACOM_PKGLEN_INTUOS, =A0 =A0=
45720, 31680, 1023,
> + =A0 =A0 =A0 =A0 31, INTUOS, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
> =A0static const struct wacom_features wacom_features_0xB0 =3D
> - =A0 =A0 =A0 { "Wacom Intuos3 4x5", =A0 =A0WACOM_PKGLEN_INTUOS, =A0 =
=A025400, 20320, 1023, 63, INTUOS3S };
> + =A0 =A0 =A0 { "Wacom Intuos3 4x5", =A0 =A0WACOM_PKGLEN_INTUOS, =A0 =
=A025400, 20320, 1023,
> + =A0 =A0 =A0 =A0 63, INTUOS3S, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES =
};
> =A0static const struct wacom_features wacom_features_0xB1 =3D
> - =A0 =A0 =A0 { "Wacom Intuos3 6x8", =A0 =A0WACOM_PKGLEN_INTUOS, =A0 =
=A040640, 30480, 1023, 63, INTUOS3 };
> + =A0 =A0 =A0 { "Wacom Intuos3 6x8", =A0 =A0WACOM_PKGLEN_INTUOS, =A0 =
=A040640, 30480, 1023,
> + =A0 =A0 =A0 =A0 63, INTUOS3, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES }=
;
> =A0static const struct wacom_features wacom_features_0xB2 =3D
> - =A0 =A0 =A0 { "Wacom Intuos3 9x12", =A0 WACOM_PKGLEN_INTUOS, =A0 =A0=
60960, 45720, 1023, 63, INTUOS3 };
> + =A0 =A0 =A0 { "Wacom Intuos3 9x12", =A0 WACOM_PKGLEN_INTUOS, =A0 =A0=
60960, 45720, 1023,
> + =A0 =A0 =A0 =A0 63, INTUOS3, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES }=
;
> =A0static const struct wacom_features wacom_features_0xB3 =3D
> - =A0 =A0 =A0 { "Wacom Intuos3 12x12", =A0WACOM_PKGLEN_INTUOS, =A0 =A0=
60960, 60960, 1023, 63, INTUOS3L };
> + =A0 =A0 =A0 { "Wacom Intuos3 12x12", =A0WACOM_PKGLEN_INTUOS, =A0 =A0=
60960, 60960, 1023,
> + =A0 =A0 =A0 =A0 63, INTUOS3L, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES =
};
> =A0static const struct wacom_features wacom_features_0xB4 =3D
> - =A0 =A0 =A0 { "Wacom Intuos3 12x19", =A0WACOM_PKGLEN_INTUOS, =A0 =A0=
97536, 60960, 1023, 63, INTUOS3L };
> + =A0 =A0 =A0 { "Wacom Intuos3 12x19", =A0WACOM_PKGLEN_INTUOS, =A0 =A0=
97536, 60960, 1023,
> + =A0 =A0 =A0 =A0 63, INTUOS3L, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES =
};
> =A0static const struct wacom_features wacom_features_0xB5 =3D
> - =A0 =A0 =A0 { "Wacom Intuos3 6x11", =A0 WACOM_PKGLEN_INTUOS, =A0 =A0=
54204, 31750, 1023, 63, INTUOS3 };
> + =A0 =A0 =A0 { "Wacom Intuos3 6x11", =A0 WACOM_PKGLEN_INTUOS, =A0 =A0=
54204, 31750, 1023,
> + =A0 =A0 =A0 =A0 63, INTUOS3, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES }=
;
> =A0static const struct wacom_features wacom_features_0xB7 =3D
> - =A0 =A0 =A0 { "Wacom Intuos3 4x6", =A0 =A0WACOM_PKGLEN_INTUOS, =A0 =
=A031496, 19685, 1023, 63, INTUOS3S };
> + =A0 =A0 =A0 { "Wacom Intuos3 4x6", =A0 =A0WACOM_PKGLEN_INTUOS, =A0 =
=A031496, 19685, 1023,
> + =A0 =A0 =A0 =A0 63, INTUOS3S, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES =
};
> =A0static const struct wacom_features wacom_features_0xB8 =3D
> - =A0 =A0 =A0 { "Wacom Intuos4 4x6", =A0 =A0WACOM_PKGLEN_INTUOS, =A0 =
=A031496, 19685, 2047, 63, INTUOS4S };
> + =A0 =A0 =A0 { "Wacom Intuos4 4x6", =A0 =A0WACOM_PKGLEN_INTUOS, =A0 =
=A031496, 19685, 2047,
> + =A0 =A0 =A0 =A0 63, INTUOS4S, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES =
};
> =A0static const struct wacom_features wacom_features_0xB9 =3D
> - =A0 =A0 =A0 { "Wacom Intuos4 6x9", =A0 =A0WACOM_PKGLEN_INTUOS, =A0 =
=A044704, 27940, 2047, 63, INTUOS4 };
> + =A0 =A0 =A0 { "Wacom Intuos4 6x9", =A0 =A0WACOM_PKGLEN_INTUOS, =A0 =
=A044704, 27940, 2047,
> + =A0 =A0 =A0 =A0 63, INTUOS4, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES }=
;
> =A0static const struct wacom_features wacom_features_0xBA =3D
> - =A0 =A0 =A0 { "Wacom Intuos4 8x13", =A0 WACOM_PKGLEN_INTUOS, =A0 =A0=
65024, 40640, 2047, 63, INTUOS4L };
> + =A0 =A0 =A0 { "Wacom Intuos4 8x13", =A0 WACOM_PKGLEN_INTUOS, =A0 =A0=
65024, 40640, 2047,
> + =A0 =A0 =A0 =A0 63, INTUOS4L, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES =
};
> =A0static const struct wacom_features wacom_features_0xBB =3D
> - =A0 =A0 =A0 { "Wacom Intuos4 12x19", =A0WACOM_PKGLEN_INTUOS, =A0 =A0=
97536, 60960, 2047, 63, INTUOS4L };
> + =A0 =A0 =A0 { "Wacom Intuos4 12x19", =A0WACOM_PKGLEN_INTUOS, =A0 =A0=
97536, 60960, 2047,
> + =A0 =A0 =A0 =A0 63, INTUOS4L, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES =
};
> =A0static const struct wacom_features wacom_features_0xBC =3D
> - =A0 =A0 =A0 { "Wacom Intuos4 WL", =A0 =A0 WACOM_PKGLEN_INTUOS, =A0 =
=A040840, 25400, 2047, 63, INTUOS4 };
> + =A0 =A0 =A0 { "Wacom Intuos4 WL", =A0 =A0 WACOM_PKGLEN_INTUOS, =A0 =
=A040840, 25400, 2047,
> + =A0 =A0 =A0 =A0 63, INTUOS4, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES }=
;
> =A0static const struct wacom_features wacom_features_0x3F =3D
> - =A0 =A0 =A0 { "Wacom Cintiq 21UX", =A0 =A0WACOM_PKGLEN_INTUOS, =A0 =
=A087200, 65600, 1023, 63, CINTIQ };
> + =A0 =A0 =A0 { "Wacom Cintiq 21UX", =A0 =A0WACOM_PKGLEN_INTUOS, =A0 =
=A087200, 65600, 1023,
> + =A0 =A0 =A0 =A0 63, CINTIQ, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
> =A0static const struct wacom_features wacom_features_0xC5 =3D
> - =A0 =A0 =A0 { "Wacom Cintiq 20WSX", =A0 WACOM_PKGLEN_INTUOS, =A0 =A0=
86680, 54180, 1023, 63, WACOM_BEE };
> + =A0 =A0 =A0 { "Wacom Cintiq 20WSX", =A0 WACOM_PKGLEN_INTUOS, =A0 =A0=
86680, 54180, 1023,
> + =A0 =A0 =A0 =A0 63, WACOM_BEE, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES=
 };
> =A0static const struct wacom_features wacom_features_0xC6 =3D
> - =A0 =A0 =A0 { "Wacom Cintiq 12WX", =A0 =A0WACOM_PKGLEN_INTUOS, =A0 =
=A053020, 33440, 1023, 63, WACOM_BEE };
> + =A0 =A0 =A0 { "Wacom Cintiq 12WX", =A0 =A0WACOM_PKGLEN_INTUOS, =A0 =
=A053020, 33440, 1023,
> + =A0 =A0 =A0 =A0 63, WACOM_BEE, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES=
 };
> =A0static const struct wacom_features wacom_features_0xC7 =3D
> - =A0 =A0 =A0 { "Wacom DTU1931", =A0 =A0 =A0 =A0WACOM_PKGLEN_GRAPHIRE=
, =A037832, 30305, =A0511, =A00, PL };
> + =A0 =A0 =A0 { "Wacom DTU1931", =A0 =A0 =A0 =A0WACOM_PKGLEN_GRAPHIRE=
, =A037832, 30305, =A0511,
> + =A0 =A0 =A0 =A0 0, PL, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
> =A0static const struct wacom_features wacom_features_0xCE =3D
> - =A0 =A0 =A0 { "Wacom DTU2231", =A0 =A0 =A0 =A0WACOM_PKGLEN_GRAPHIRE=
, =A047864, 27011, =A0511, =A00, DTU };
> + =A0 =A0 =A0 { "Wacom DTU2231", =A0 =A0 =A0 =A0WACOM_PKGLEN_GRAPHIRE=
, =A047864, 27011, =A0511,
> + =A0 =A0 =A0 =A0 0, DTU, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
> =A0static const struct wacom_features wacom_features_0xF0 =3D
> - =A0 =A0 =A0 { "Wacom DTU1631", =A0 =A0 =A0 =A0WACOM_PKGLEN_GRAPHIRE=
, =A034623, 19553, =A0511, =A00, DTU };
> + =A0 =A0 =A0 { "Wacom DTU1631", =A0 =A0 =A0 =A0WACOM_PKGLEN_GRAPHIRE=
, =A034623, 19553, =A0511,
> + =A0 =A0 =A0 =A0 0, DTU, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
> =A0static const struct wacom_features wacom_features_0xCC =3D
> - =A0 =A0 =A0 { "Wacom Cintiq 21UX2", =A0 WACOM_PKGLEN_INTUOS, =A0 =A0=
87200, 65600, 2047, 63, WACOM_21UX2 };
> + =A0 =A0 =A0 { "Wacom Cintiq 21UX2", =A0 WACOM_PKGLEN_INTUOS, =A0 =A0=
87200, 65600, 2047,
> + =A0 =A0 =A0 =A0 63, WACOM_21UX2, WACOM_INTUOS3_RES, WACOM_INTUOS3_R=
ES };
> =A0static const struct wacom_features wacom_features_0x90 =3D
> - =A0 =A0 =A0 { "Wacom ISDv4 90", =A0 =A0 =A0 WACOM_PKGLEN_GRAPHIRE, =
=A026202, 16325, =A0255, =A00, TABLETPC };
> + =A0 =A0 =A0 { "Wacom ISDv4 90", =A0 =A0 =A0 WACOM_PKGLEN_GRAPHIRE, =
=A026202, 16325, =A0255,
> + =A0 =A0 =A0 =A0 0, TABLETPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
> =A0static const struct wacom_features wacom_features_0x93 =3D
> - =A0 =A0 =A0 { "Wacom ISDv4 93", =A0 =A0 =A0 WACOM_PKGLEN_GRAPHIRE, =
=A026202, 16325, =A0255, =A00, TABLETPC };
> + =A0 =A0 =A0 { "Wacom ISDv4 93", =A0 =A0 =A0 WACOM_PKGLEN_GRAPHIRE, =
=A026202, 16325, =A0255,
> + =A0 =A0 =A0 =A0 0, TABLETPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
> =A0static const struct wacom_features wacom_features_0x9A =3D
> - =A0 =A0 =A0 { "Wacom ISDv4 9A", =A0 =A0 =A0 WACOM_PKGLEN_GRAPHIRE, =
=A026202, 16325, =A0255, =A00, TABLETPC };
> + =A0 =A0 =A0 { "Wacom ISDv4 9A", =A0 =A0 =A0 WACOM_PKGLEN_GRAPHIRE, =
=A026202, 16325, =A0255,
> + =A0 =A0 =A0 =A0 0, TABLETPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
> =A0static const struct wacom_features wacom_features_0x9F =3D
> - =A0 =A0 =A0 { "Wacom ISDv4 9F", =A0 =A0 =A0 WACOM_PKGLEN_GRAPHIRE, =
=A026202, 16325, =A0255, =A00, TABLETPC };
> + =A0 =A0 =A0 { "Wacom ISDv4 9F", =A0 =A0 =A0 WACOM_PKGLEN_GRAPHIRE, =
=A026202, 16325, =A0255,
> + =A0 =A0 =A0 =A0 0, TABLETPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
> =A0static const struct wacom_features wacom_features_0xE2 =3D
> - =A0 =A0 =A0 { "Wacom ISDv4 E2", =A0 =A0 =A0 WACOM_PKGLEN_TPC2FG, =A0=
 =A026202, 16325, =A0255, =A00, TABLETPC2FG };
> + =A0 =A0 =A0 { "Wacom ISDv4 E2", =A0 =A0 =A0 WACOM_PKGLEN_TPC2FG, =A0=
 =A026202, 16325, =A0255,
> + =A0 =A0 =A0 =A0 0, TABLETPC2FG, WACOM_INTUOS_RES, WACOM_INTUOS_RES =
};
> =A0static const struct wacom_features wacom_features_0xE3 =3D
> - =A0 =A0 =A0 { "Wacom ISDv4 E3", =A0 =A0 =A0 WACOM_PKGLEN_TPC2FG, =A0=
 =A026202, 16325, =A0255, =A00, TABLETPC2FG };
> + =A0 =A0 =A0 { "Wacom ISDv4 E3", =A0 =A0 =A0 WACOM_PKGLEN_TPC2FG, =A0=
 =A026202, 16325, =A0255,
> + =A0 =A0 =A0 =A0 0, TABLETPC2FG, WACOM_INTUOS_RES, WACOM_INTUOS_RES =
};
> =A0static const struct wacom_features wacom_features_0x47 =3D
> - =A0 =A0 =A0 { "Wacom Intuos2 6x8", =A0 =A0WACOM_PKGLEN_INTUOS, =A0 =
=A020320, 16240, 1023, 31, INTUOS };
> + =A0 =A0 =A0 { "Wacom Intuos2 6x8", =A0 =A0WACOM_PKGLEN_INTUOS, =A0 =
=A020320, 16240, 1023,
> + =A0 =A0 =A0 =A0 31, INTUOS, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
> =A0static const struct wacom_features wacom_features_0xD0 =3D
> - =A0 =A0 =A0 { "Wacom Bamboo 2FG", =A0 =A0 WACOM_PKGLEN_BBFUN, =A0 =A0=
 14720, =A09200, 1023, 63, BAMBOO_PT };
> + =A0 =A0 =A0 { "Wacom Bamboo 2FG", =A0 =A0 WACOM_PKGLEN_BBFUN, =A0 =A0=
 14720, =A09200, 1023,
> + =A0 =A0 =A0 =A0 63, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES }=
;
> =A0static const struct wacom_features wacom_features_0xD1 =3D
> - =A0 =A0 =A0 { "Wacom Bamboo 2FG 4x5", WACOM_PKGLEN_BBFUN, =A0 =A0 1=
4720, =A09200, 1023, 63, BAMBOO_PT };
> + =A0 =A0 =A0 { "Wacom Bamboo 2FG 4x5", WACOM_PKGLEN_BBFUN, =A0 =A0 1=
4720, =A09200, 1023,
> + =A0 =A0 =A0 =A0 63, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES }=
;
> =A0static const struct wacom_features wacom_features_0xD2 =3D
> - =A0 =A0 =A0 { "Wacom Bamboo Craft", =A0 WACOM_PKGLEN_BBFUN, =A0 =A0=
 14720, =A09200, 1023, 63, BAMBOO_PT };
> + =A0 =A0 =A0 { "Wacom Bamboo Craft", =A0 WACOM_PKGLEN_BBFUN, =A0 =A0=
 14720, =A09200, 1023,
> + =A0 =A0 =A0 =A0 63, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES }=
;
> =A0static const struct wacom_features wacom_features_0xD3 =3D
> - =A0 =A0 =A0 { "Wacom Bamboo 2FG 6x8", WACOM_PKGLEN_BBFUN, =A0 =A0 2=
1648, 13530, 1023, 63, BAMBOO_PT };
> + =A0 =A0 =A0 { "Wacom Bamboo 2FG 6x8", WACOM_PKGLEN_BBFUN, =A0 =A0 2=
1648, 13530, 1023,
> + =A0 =A0 =A0 =A0 63, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES }=
;
> =A0static const struct wacom_features wacom_features_0xD4 =3D
> - =A0 =A0 =A0 { "Wacom Bamboo Pen", =A0 =A0 WACOM_PKGLEN_BBFUN, =A0 =A0=
 14720, =A09200, =A0255, 63, BAMBOO_PT };
> + =A0 =A0 =A0 { "Wacom Bamboo Pen", =A0 =A0 WACOM_PKGLEN_BBFUN, =A0 =A0=
 14720, =A09200, =A0255,
> + =A0 =A0 =A0 =A0 63, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES }=
;
> =A0static const struct wacom_features wacom_features_0xD6 =3D
> - =A0 =A0 =A0 { "Wacom BambooPT 2FG 4x5", WACOM_PKGLEN_BBFUN, =A0 147=
20, =A09200, 1023, 63, BAMBOO_PT };
> + =A0 =A0 =A0 { "Wacom BambooPT 2FG 4x5", WACOM_PKGLEN_BBFUN, =A0 147=
20, =A09200, 1023,
> + =A0 =A0 =A0 =A0 63, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES }=
;
> =A0static const struct wacom_features wacom_features_0xD7 =3D
> - =A0 =A0 =A0 { "Wacom BambooPT 2FG Small", WACOM_PKGLEN_BBFUN, 14720=
, =A09200, 1023, 63, BAMBOO_PT };
> + =A0 =A0 =A0 { "Wacom BambooPT 2FG Small", WACOM_PKGLEN_BBFUN, 14720=
, =A09200, 1023,
> + =A0 =A0 =A0 =A0 63, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES }=
;
> =A0static const struct wacom_features wacom_features_0xD8 =3D
> - =A0 =A0 =A0 { "Wacom Bamboo Comic 2FG", WACOM_PKGLEN_BBFUN, =A0 216=
48, 13530, 1023, 63, BAMBOO_PT };
> + =A0 =A0 =A0 { "Wacom Bamboo Comic 2FG", WACOM_PKGLEN_BBFUN, =A0 216=
48, 13530, 1023,
> + =A0 =A0 =A0 =A0 63, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES }=
;
> =A0static const struct wacom_features wacom_features_0xDA =3D
> - =A0 =A0 =A0 { "Wacom Bamboo 2FG 4x5 SE", WACOM_PKGLEN_BBFUN, =A0147=
20, =A09200, 1023, 63, BAMBOO_PT };
> + =A0 =A0 =A0 { "Wacom Bamboo 2FG 4x5 SE", WACOM_PKGLEN_BBFUN, =A0147=
20, =A09200, 1023,
> + =A0 =A0 =A0 =A0 63, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES }=
;
> =A0static struct wacom_features wacom_features_0xDB =3D
> - =A0 =A0 =A0 { "Wacom Bamboo 2FG 6x8 SE", WACOM_PKGLEN_BBFUN, =A0216=
48, 13530, 1023, 63, BAMBOO_PT };
> + =A0 =A0 =A0 { "Wacom Bamboo 2FG 6x8 SE", WACOM_PKGLEN_BBFUN, =A0216=
48, 13530, 1023,
> + =A0 =A0 =A0 =A0 63, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES }=
;
> =A0static const struct wacom_features wacom_features_0x6004 =3D
> - =A0 =A0 =A0 { "ISD-V4", =A0 =A0 =A0 =A0 =A0 =A0 =A0 WACOM_PKGLEN_GR=
APHIRE, =A012800, 8000, 255, 0, TABLETPC };
> + =A0 =A0 =A0 { "ISD-V4", =A0 =A0 =A0 =A0 =A0 =A0 =A0 WACOM_PKGLEN_GR=
APHIRE, =A012800, =A08000, =A0255,
> + =A0 =A0 =A0 =A0 0, TABLETPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
>
> =A0#define USB_DEVICE_WACOM(prod) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> =A0 =A0 =A0 =A0USB_DEVICE(USB_VENDOR_ID_WACOM, prod), =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0\
> diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/=
wacom_wac.h
> index 835f756..53eb71b 100644
> --- a/drivers/input/tablet/wacom_wac.h
> +++ b/drivers/input/tablet/wacom_wac.h
> @@ -74,6 +74,8 @@ struct wacom_features {
> =A0 =A0 =A0 =A0int pressure_max;
> =A0 =A0 =A0 =A0int distance_max;
> =A0 =A0 =A0 =A0int type;
> + =A0 =A0 =A0 int x_resolution;
> + =A0 =A0 =A0 int y_resolution;
> =A0 =A0 =A0 =A0int device_type;
> =A0 =A0 =A0 =A0int x_phy;
> =A0 =A0 =A0 =A0int y_phy;
> --
> 1.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
