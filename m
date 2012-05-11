From: Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: Re: [PATCH/RFC] HID: logitech: read all 32 bits of report type bitfield
Date: Fri, 11 May 2012 09:36:08 +0200
Message-ID: <CAE7qMrp6VvdWNrMhdcisig8pKdzuNQQDmQLrF4x6bnfF880tCA@mail.gmail.com>
References: <20120503052420.GD15205@burratino> <4FA217B7.7070908@osvaldobarrera.com.ar>
 <20120503055051.GA15960@burratino> <CAE7qMrqtmu+bYYYp43s7Ek=UxfUG8HzwQSQBsdCGcVCBzCMQQw@mail.gmail.com>
 <20120506031428.GA20044@hugoo.com.ar> <20120506055508.GA21209@burratino>
 <4FA6162F.1020408@osvaldobarrera.com.ar> <20120506062309.GB26002@burratino>
 <20120511050639.GA13777@hugoo.com.ar> <CAE7qMroedSu_-GJ3mye0vnKtQKiS1jEuDAkk75=qdTVQMTgaxQ@mail.gmail.com>
 <20120511072231.GA5733@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog135.obsmtp.com ([74.125.149.84]:33051 "EHLO
	na3sys009aog135.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752557Ab2EKHgk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 11 May 2012 03:36:40 -0400
Received: by pbbrq13 with SMTP id rq13so3493814pbb.22
        for <linux-input@vger.kernel.org>; Fri, 11 May 2012 00:36:38 -0700 (PDT)
In-Reply-To: <20120511072231.GA5733@burratino>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Hugo Osvaldo Barrera <hugo@osvaldobarrera.com.ar>, linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@enac.fr>, 671292@bugs.debian.org, Jiri Kosina <jkosina@suse.cz>

The patch looks perfect to me. Wonderful 'get_unaligned_le32' that I
looked for and did not find when trying to fix the original code.

On my side no issues for Jiri to apply it.

Thanks again Jonathan and Hugo.

Cheers,
Nestor.

On Fri, May 11, 2012 at 9:22 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> On big-endian systems (e.g., Apple PowerBook), trying to use a
> logitech wireless mouse with the Logitech Unifying Receiver does not
> work with v3.2 and later kernels. =A0The device doesn't show up in
> /dev/input. =A0Older kernels work fine.
>
> That is because the new hid-logitech-dj driver claims the device. =A0=
The
> device arrival notification appears:
>
> =A0 =A0 =A0 =A020 00 41 02 00 00 00 00 00 00 00 00 00 00 00
>
> and we read the report_types bitfield (02 00 00 00) to find out what
> kind of device it is. =A0Unfortunately the driver only reads the firs=
t 8
> bits and treats that value as a 32-bit little-endian number, so on a
> powerpc the report type seems to be 0x02000000 and is not recognized.
>
> Even on little-endian machines, connecting a media center remote
> control (report type 00 01 00 00) with this driver loaded would
> presumably fail for the same reason.
>
> Fix both problems by using get_unaligned_le32() to read all four
> bytes, which is a little clearer anyway. =A0After this change, the
> wireless mouse works on Hugo's PowerBook again.
>
> Based on a patch by Nestor Lopez Casado.
> Addresses http://bugs.debian.org/671292
>
> Reported-by: Hugo Osvaldo Barrera <hugo@osvaldobarrera.com.ar>
> Inspired-by: Nestor Lopez Casado <nlopezcasad@logitech.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> Cc: <stable@vger.kernel.org>
> ---
> Nestor Lopez Casado wrote:
>
>> Great news. Thanks Hugo for your help testing the patches.
>>
>> Jonathan, how do we proceed now, I mean to submit the fix ?
>
> If the patch looks good to you, we ask Jiri to pick it up. =A0What do
> you think?
>
> Thanks,
> Jonathan
>
> =A0drivers/hid/hid-logitech-dj.c | =A0 =A05 +++--
> =A01 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech=
-dj.c
> index 38b12e45780c..2eac8c566b17 100644
> --- a/drivers/hid/hid-logitech-dj.c
> +++ b/drivers/hid/hid-logitech-dj.c
> @@ -26,6 +26,7 @@
> =A0#include <linux/hid.h>
> =A0#include <linux/module.h>
> =A0#include <linux/usb.h>
> +#include <asm/unaligned.h>
> =A0#include "usbhid/usbhid.h"
> =A0#include "hid-ids.h"
> =A0#include "hid-logitech-dj.h"
> @@ -265,8 +266,8 @@ static void logi_dj_recv_add_djhid_device(struct =
dj_receiver_dev *djrcv_dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto dj_device_allocate_fail;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 dj_dev->reports_supported =3D le32_to_cpu(
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dj_report->report_params[DEVICE_PAIRED_=
RF_REPORT_TYPE]);
> + =A0 =A0 =A0 dj_dev->reports_supported =3D get_unaligned_le32(
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dj_report->report_params + DEVICE_PAIRE=
D_RF_REPORT_TYPE);
> =A0 =A0 =A0 =A0dj_dev->hdev =3D dj_hiddev;
> =A0 =A0 =A0 =A0dj_dev->dj_receiver_dev =3D djrcv_dev;
> =A0 =A0 =A0 =A0dj_dev->device_index =3D dj_report->device_index;
> --
> 1.7.10.1
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
