From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: Re: [PATCHv2 1/7] input/cma3000_d0x: Support devices without pdata
Date: Tue, 18 Oct 2011 14:58:33 +0200
Message-ID: <CAPybu_3mC5HnHZeic+D7G=K3oz_yyMAOkepBZmGmj6gPEZoY4A@mail.gmail.com>
References: <1318939596-27330-1-git-send-email-ricardo.ribalda@gmail.com>
 <1318939596-27330-2-git-send-email-ricardo.ribalda@gmail.com> <4E9D76D9.7070302@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:34850 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755139Ab1JRM7N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Oct 2011 08:59:13 -0400
In-Reply-To: <4E9D76D9.7070302@cam.ac.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: dmitry.torokhov@gmail.com, sameo@linux.intel.com, peter.ujfalusi@ti.com, aghayal@codeaurora.org, david@hardeman.nu, Shubhrajyoti@ti.com, saaguirre@ti.com, hemanthv@ti.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hello Jonathan

I think I am going to do it like ads1015.c. I will check for the
pdata, then for the dt info (if it is there) and finally go for the
default, if all fails. What do you think? Shall I fix it in cma3000
and cmr3000?

 Thanks again

On Tue, Oct 18, 2011 at 14:53, Jonathan Cameron <jic23@cam.ac.uk> wrote=
:
> On 10/18/11 13:06, Ricardo Ribalda Delgado wrote:
>> Architectures based on device-tree does not have platform data
>> associated to the spi/i2c devices.
>> This patch allows those architectures to use the cma3000 driver with
>> a default configuration.
> Fine except for this description. Looks to be a perfectly reasonable
> way of specifying these in DT. =A0So fix that and I'm happy.
> Whoever wants to pass this in from DT can do a patch for it!
>>
>> ---
>>
>> v2: Fixes suggested by Jonathan Cameron
>> =A0 =A0 -Spelling
>> =A0 =A0 -Simplify pdata!=3DNULL check
>>
>> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
>> ---
>> =A0drivers/input/misc/cma3000_d0x.c | =A0 20 +++++++++++++++-----
>> =A01 files changed, 15 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/input/misc/cma3000_d0x.c b/drivers/input/misc/c=
ma3000_d0x.c
>> index 1633b63..f2e87e3 100644
>> --- a/drivers/input/misc/cma3000_d0x.c
>> +++ b/drivers/input/misc/cma3000_d0x.c
>> @@ -62,6 +62,18 @@
>> =A0#define BIT_TO_2G =A018
>> =A0#define BIT_TO_8G =A071
>>
>> +static struct cma3000_platform_data cma3000_default_pdata =3D {
>> + =A0 =A0 .mdthr =3D 0x8,
>> + =A0 =A0 .mdfftmr =3D 0x33,
>> + =A0 =A0 .ffthr =3D 0x8,
>> + =A0 =A0 .mode =3D CMAMODE_MEAS400,
>> + =A0 =A0 .g_range =3D CMARANGE_2G,
>> + =A0 =A0 .fuzz_x =3D BIT_TO_2G,
>> + =A0 =A0 .fuzz_y =3D BIT_TO_2G,
>> + =A0 =A0 .fuzz_z =3D BIT_TO_2G,
>> + =A0 =A0 .irqflags =3D 0,
>> +};
>> +
>> =A0struct cma3000_accl_data {
>> =A0 =A0 =A0 const struct cma3000_bus_ops *bus_ops;
>> =A0 =A0 =A0 const struct cma3000_platform_data *pdata;
>> @@ -289,13 +301,11 @@ struct cma3000_accl_data *cma3000_init(struct =
device *dev, int irq,
>> =A0 =A0 =A0 int rev;
>> =A0 =A0 =A0 int error;
>>
>> - =A0 =A0 if (!pdata) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "platform data not found\n");
>> - =A0 =A0 =A0 =A0 =A0 =A0 error =3D -EINVAL;
>> - =A0 =A0 =A0 =A0 =A0 =A0 goto err_out;
>> + =A0 =A0 if (pdata =3D=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_info(dev, "platform data not found, us=
ing default\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 pdata =3D &cma3000_default_pdata;
>> =A0 =A0 =A0 }
>>
>> -
>> =A0 =A0 =A0 /* if no IRQ return error */
>> =A0 =A0 =A0 if (irq =3D=3D 0) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D -EINVAL;
>
>



--=20
Ricardo Ribalda
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
