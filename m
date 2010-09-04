From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH v2 6/6] ARM: pxa168: aspenite: add board support for keypad
Date: Sat, 4 Sep 2010 07:23:32 +0200
Message-ID: <201009040723.33131.marek.vasut@gmail.com>
References: <1282836457-5651-1-git-send-email-mark.brown314@gmail.com> <201009040412.01067.marek.vasut@gmail.com> <AANLkTiniX5w6Uy6xhs3k_FZc4REvpNPaixet3d8TTPVy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59093 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340Ab0IDFY2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 4 Sep 2010 01:24:28 -0400
In-Reply-To: <AANLkTiniX5w6Uy6xhs3k_FZc4REvpNPaixet3d8TTPVy@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Mark F. Brown" <mark.brown314@gmail.com>
Cc: Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Dne So 4. z=C3=A1=C5=99=C3=AD 2010 04:56:27 Mark F. Brown napsal(a):
> On Fri, Sep 3, 2010 at 10:12 PM, Marek Vasut <marek.vasut@gmail.com> =
wrote:
> > Dne =C4=8Ct 26. srpna 2010 17:27:37 Mark F. Brown napsal(a):
> >> Signed-off-by: Mark F. Brown <mark.brown314@gmail.com>
> >=20
> > Ditto, which is V2 and which are just resubmissions please ?
> >=20
> >> ---
> >>  arch/arm/mach-mmp/aspenite.c |   27 +++++++++++++++++++++++++++
> >>  1 files changed, 27 insertions(+), 0 deletions(-)
> >>=20
> >> diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspe=
nite.c
> >> index 9e1bd6b..f04bae6 100644
> >> --- a/arch/arm/mach-mmp/aspenite.c
> >> +++ b/arch/arm/mach-mmp/aspenite.c
> >> @@ -24,6 +24,8 @@
> >>  #include <mach/pxa168.h>
> >>  #include <mach/gpio.h>
> >>  #include <video/pxa168fb.h>
> >> +#include <linux/input.h>
> >> +#include <plat/pxa27x_keypad.h>
> >>=20
> >>  #include "common.h"
> >>=20
> >> @@ -97,6 +99,13 @@ static unsigned long common_pin_config[] __init=
data =3D
> >> { GPIO81_LCD_DD21,
> >>       GPIO82_LCD_DD22,
> >>       GPIO83_LCD_DD23,
> >> +
> >> +     /* Keypad */
> >> +     GPIO109_KP_MKIN1,
> >> +     GPIO110_KP_MKIN0,
> >> +     GPIO111_KP_MKOUT7,
> >> +     GPIO112_KP_MKOUT6,
> >> +     GPIO121_KP_MKIN4,
> >>  };
> >>=20
> >>  static struct smc91x_platdata smc91x_info =3D {
> >> @@ -193,6 +202,23 @@ struct pxa168fb_mach_info aspenite_lcd_info =3D=
 {
> >>       .invert_pixclock        =3D 0,
> >>  };
> >>=20
> >> +static unsigned int aspenite_matrix_key_map[] =3D {
> >> +     KEY(0, 6, KEY_UP),      /* SW 4 */
> >> +     KEY(0, 7, KEY_DOWN),    /* SW 5 */
> >> +     KEY(1, 6, KEY_LEFT),    /* SW 6 */
> >> +     KEY(1, 7, KEY_RIGHT),   /* SW 7 */
> >> +     KEY(4, 6, KEY_ENTER),   /* SW 8 */
> >> +     KEY(4, 7, KEY_ESC),     /* SW 9 */
> >> +};
> >> +
> >> +static struct pxa27x_keypad_platform_data aspenite_keypad_info
> >> __initdata =3D { + .matrix_key_rows        =3D 5,
> >> +     .matrix_key_cols        =3D 8,
> >> +     .matrix_key_map         =3D aspenite_matrix_key_map,
> >> +     .matrix_key_map_size    =3D ARRAY_SIZE(aspenite_matrix_key_m=
ap),
> >> +     .debounce_interval      =3D 30,
> >> +};
> >> +
> >>  static void __init common_init(void)
> >>  {
> >>       mfp_config(ARRAY_AND_SIZE(common_pin_config));
> >> @@ -203,6 +229,7 @@ static void __init common_init(void)
> >>       pxa168_add_ssp(1);
> >>       pxa168_add_nand(&aspenite_nand_info);
> >>       pxa168_add_fb(&aspenite_lcd_info);
> >> +     pxa168_add_keypad(&aspenite_keypad_info);
> >>=20
> >>       /* off-chip devices */
> >>       platform_device_register(&smc91x_device);
>=20
> Sorry I am new to this! If I am updating the patchset based on
> community recommendations should I consider that the next version of
> the patchset or something else? I think I am confused about the
> distinction.

Stick the description of the changes made from previous version to wher=
e=20
diffstat is.

Also, mark "vN+1" only those patches, that are really changed in the pa=
tchset.=20
Cheers
>=20
> Thanks,
> -- Mark
> -- Mark
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
