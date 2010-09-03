From: "Mark F. Brown" <mark.brown314@gmail.com>
Subject: Re: [PATCH 5/5] ARM: pxa168: aspenite: add board support for keypad
Date: Fri, 3 Sep 2010 00:50:28 -0400
Message-ID: <AANLkTi=2ZJTy=RD_L0g-HnLF=r27bZLm5hTHemyNQFEi@mail.gmail.com>
References: <1282814339-10934-1-git-send-email-mark.brown314@gmail.com>
	<1282814339-10934-6-git-send-email-mark.brown314@gmail.com>
	<AANLkTi=OkRUmBgx_ezWtGHywGJkFAJsdGLR07v8dgzD7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:62201 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753355Ab0ICEub convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 Sep 2010 00:50:31 -0400
In-Reply-To: <AANLkTi=OkRUmBgx_ezWtGHywGJkFAJsdGLR07v8dgzD7@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>

On Tue, Aug 31, 2010 at 1:00 AM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> On Thu, Aug 26, 2010 at 5:18 PM, Mark F. Brown <mark.brown314@gmail.c=
om> wrote:
>> Signed-off-by: Mark F. Brown <mark.brown314@gmail.com>
>> ---
>> =A0arch/arm/mach-mmp/aspenite.c | =A0 27 +++++++++++++++++++++++++++
>> =A01 files changed, 27 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspeni=
te.c
>> index 9e1bd6b..1b788c5 100644
>> --- a/arch/arm/mach-mmp/aspenite.c
>> +++ b/arch/arm/mach-mmp/aspenite.c
>> @@ -24,6 +24,8 @@
>> =A0#include <mach/pxa168.h>
>> =A0#include <mach/gpio.h>
>> =A0#include <video/pxa168fb.h>
>> +#include <linux/input.h>
>> +#include <plat/pxa27x_keypad.h>
>>
>> =A0#include "common.h"
>>
>> @@ -97,6 +99,13 @@ static unsigned long common_pin_config[] __initda=
ta =3D {
>> =A0 =A0 =A0 =A0GPIO81_LCD_DD21,
>> =A0 =A0 =A0 =A0GPIO82_LCD_DD22,
>> =A0 =A0 =A0 =A0GPIO83_LCD_DD23,
>> +
>> + =A0 =A0 =A0 /* Keypad */
>> + =A0 =A0 =A0 GPIO109_KP_MKIN1,
>> + =A0 =A0 =A0 GPIO110_KP_MKIN0,
>> + =A0 =A0 =A0 GPIO111_KP_MKOUT7,
>> + =A0 =A0 =A0 GPIO112_KP_MKOUT6,
>> + =A0 =A0 =A0 GPIO121_KP_MKIN4,
>> =A0};
>>
>> =A0static struct smc91x_platdata smc91x_info =3D {
>> @@ -193,6 +202,23 @@ struct pxa168fb_mach_info aspenite_lcd_info =3D=
 {
>> =A0 =A0 =A0 =A0.invert_pixclock =A0 =A0 =A0 =A0=3D 0,
>> =A0};
>>
>> +static unsigned int aspenite_matrix_key_map[] =3D {
>> + =A0 =A0 =A0 KEY(0, 6, KEY_UP), =A0 =A0 =A0/* SW 4 */
>> + =A0 =A0 =A0 KEY(0, 7, KEY_DOWN), =A0 =A0/* SW 5 */
>> + =A0 =A0 =A0 KEY(1, 6, KEY_LEFT), =A0 =A0/* SW 6 */
>> + =A0 =A0 =A0 KEY(1, 7, KEY_RIGHT), =A0 /* SW 7 */
>> + =A0 =A0 =A0 KEY(4, 6, KEY_ENTER), =A0 /* SW 8 */
>> + =A0 =A0 =A0 KEY(4, 7, KEY_ESC), =A0 =A0 /* SW 9 */
>> +};
>> +
>> +static struct pxa27x_keypad_platform_data aspenite_keypad_info __in=
itdata =3D {
>> + =A0 =A0 =A0 .matrix_key_rows =A0 =A0 =A0 =A0=3D 8,
>> + =A0 =A0 =A0 .matrix_key_cols =A0 =A0 =A0 =A0=3D 8,
> It seems that maxium columns is 5, not 8.
>
>> + =A0 =A0 =A0 .matrix_key_map =A0 =A0 =A0 =A0 =3D aspenite_matrix_ke=
y_map,
>> + =A0 =A0 =A0 .matrix_key_map_size =A0 =A0=3D ARRAY_SIZE(aspenite_ma=
trix_key_map),
>> + =A0 =A0 =A0 .debounce_interval =A0 =A0 =A0=3D 30,
>> +};
>> +
>> =A0static void __init common_init(void)
>> =A0{
>> =A0 =A0 =A0 =A0mfp_config(ARRAY_AND_SIZE(common_pin_config));
>> @@ -203,6 +229,7 @@ static void __init common_init(void)
>> =A0 =A0 =A0 =A0pxa168_add_ssp(1);
>> =A0 =A0 =A0 =A0pxa168_add_nand(&aspenite_nand_info);
>> =A0 =A0 =A0 =A0pxa168_add_fb(&aspenite_lcd_info);
>> + =A0 =A0 =A0 pxa168_add_keypad(&aspenite_keypad_info);
>>
>> =A0 =A0 =A0 =A0/* off-chip devices */
>> =A0 =A0 =A0 =A0platform_device_register(&smc91x_device);
>> --
>> 1.7.0.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kern=
el" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at =A0http://www.tux.org/lkml/
>>
>
The maximum keypad columns are 8 and the maximum keypad rows are 5 for
Aspenite. I will correct that in my patch resubmission!

Regards,
-- Mark
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
