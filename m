From: "Mark F. Brown" <mark.brown314@gmail.com>
Subject: Re: [PATCH v2 6/6] ARM: pxa168: aspenite: add board support for keypad
Date: Fri, 3 Sep 2010 22:56:27 -0400
Message-ID: <AANLkTiniX5w6Uy6xhs3k_FZc4REvpNPaixet3d8TTPVy@mail.gmail.com>
References: <1282836457-5651-1-git-send-email-mark.brown314@gmail.com>
	<1282836457-5651-7-git-send-email-mark.brown314@gmail.com>
	<201009040412.01067.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59454 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754219Ab0IDC42 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 Sep 2010 22:56:28 -0400
In-Reply-To: <201009040412.01067.marek.vasut@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Fri, Sep 3, 2010 at 10:12 PM, Marek Vasut <marek.vasut@gmail.com> wr=
ote:
> Dne =C4=8Ct 26. srpna 2010 17:27:37 Mark F. Brown napsal(a):
>> Signed-off-by: Mark F. Brown <mark.brown314@gmail.com>
>
> Ditto, which is V2 and which are just resubmissions please ?
>> ---
>> =C2=A0arch/arm/mach-mmp/aspenite.c | =C2=A0 27 +++++++++++++++++++++=
++++++
>> =C2=A01 files changed, 27 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspeni=
te.c
>> index 9e1bd6b..f04bae6 100644
>> --- a/arch/arm/mach-mmp/aspenite.c
>> +++ b/arch/arm/mach-mmp/aspenite.c
>> @@ -24,6 +24,8 @@
>> =C2=A0#include <mach/pxa168.h>
>> =C2=A0#include <mach/gpio.h>
>> =C2=A0#include <video/pxa168fb.h>
>> +#include <linux/input.h>
>> +#include <plat/pxa27x_keypad.h>
>>
>> =C2=A0#include "common.h"
>>
>> @@ -97,6 +99,13 @@ static unsigned long common_pin_config[] __initda=
ta =3D {
>> =C2=A0 =C2=A0 =C2=A0 GPIO81_LCD_DD21,
>> =C2=A0 =C2=A0 =C2=A0 GPIO82_LCD_DD22,
>> =C2=A0 =C2=A0 =C2=A0 GPIO83_LCD_DD23,
>> +
>> + =C2=A0 =C2=A0 /* Keypad */
>> + =C2=A0 =C2=A0 GPIO109_KP_MKIN1,
>> + =C2=A0 =C2=A0 GPIO110_KP_MKIN0,
>> + =C2=A0 =C2=A0 GPIO111_KP_MKOUT7,
>> + =C2=A0 =C2=A0 GPIO112_KP_MKOUT6,
>> + =C2=A0 =C2=A0 GPIO121_KP_MKIN4,
>> =C2=A0};
>>
>> =C2=A0static struct smc91x_platdata smc91x_info =3D {
>> @@ -193,6 +202,23 @@ struct pxa168fb_mach_info aspenite_lcd_info =3D=
 {
>> =C2=A0 =C2=A0 =C2=A0 .invert_pixclock =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=
 0,
>> =C2=A0};
>>
>> +static unsigned int aspenite_matrix_key_map[] =3D {
>> + =C2=A0 =C2=A0 KEY(0, 6, KEY_UP), =C2=A0 =C2=A0 =C2=A0/* SW 4 */
>> + =C2=A0 =C2=A0 KEY(0, 7, KEY_DOWN), =C2=A0 =C2=A0/* SW 5 */
>> + =C2=A0 =C2=A0 KEY(1, 6, KEY_LEFT), =C2=A0 =C2=A0/* SW 6 */
>> + =C2=A0 =C2=A0 KEY(1, 7, KEY_RIGHT), =C2=A0 /* SW 7 */
>> + =C2=A0 =C2=A0 KEY(4, 6, KEY_ENTER), =C2=A0 /* SW 8 */
>> + =C2=A0 =C2=A0 KEY(4, 7, KEY_ESC), =C2=A0 =C2=A0 /* SW 9 */
>> +};
>> +
>> +static struct pxa27x_keypad_platform_data aspenite_keypad_info __in=
itdata
>> =3D { + .matrix_key_rows =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 5,
>> + =C2=A0 =C2=A0 .matrix_key_cols =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 8,
>> + =C2=A0 =C2=A0 .matrix_key_map =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D aspe=
nite_matrix_key_map,
>> + =C2=A0 =C2=A0 .matrix_key_map_size =C2=A0 =C2=A0=3D ARRAY_SIZE(asp=
enite_matrix_key_map),
>> + =C2=A0 =C2=A0 .debounce_interval =C2=A0 =C2=A0 =C2=A0=3D 30,
>> +};
>> +
>> =C2=A0static void __init common_init(void)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 mfp_config(ARRAY_AND_SIZE(common_pin_config));
>> @@ -203,6 +229,7 @@ static void __init common_init(void)
>> =C2=A0 =C2=A0 =C2=A0 pxa168_add_ssp(1);
>> =C2=A0 =C2=A0 =C2=A0 pxa168_add_nand(&aspenite_nand_info);
>> =C2=A0 =C2=A0 =C2=A0 pxa168_add_fb(&aspenite_lcd_info);
>> + =C2=A0 =C2=A0 pxa168_add_keypad(&aspenite_keypad_info);
>>
>> =C2=A0 =C2=A0 =C2=A0 /* off-chip devices */
>> =C2=A0 =C2=A0 =C2=A0 platform_device_register(&smc91x_device);
>

Sorry I am new to this! If I am updating the patchset based on
community recommendations should I consider that the next version of
the patchset or something else? I think I am confused about the
distinction.

Thanks,
-- Mark
-- Mark
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
