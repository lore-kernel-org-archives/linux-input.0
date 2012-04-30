From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 2/3] hid-logitech: Collect report descriptors before sending
Date: Mon, 30 Apr 2012 16:44:58 +0200
Message-ID: <CAN+gG=EDbtZkRZ+zr6awvK8fDYdV-c59On8B3O=vSMYhdQs_cw@mail.gmail.com>
References: <1335097300-11881-1-git-send-email-rydberg@euromail.se>
	<1335097300-11881-3-git-send-email-rydberg@euromail.se>
	<CAE7qMrqEJmBWo7JDHuB2DnWJ4vkvv9jya7RDJguiXsrs2xgadQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:46734 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755901Ab2D3Oo7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Apr 2012 10:44:59 -0400
In-Reply-To: <CAE7qMrqEJmBWo7JDHuB2DnWJ4vkvv9jya7RDJguiXsrs2xgadQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nestor Lopez Casado <nlopezcasad@logitech.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hello Henrik,

I've been able to test the changes with different Logitech mice and key=
boards.

So Jiri,
Tested-By: Benjamin Tissoires <benjamin.tissoires@gmail.com
for this change and this patch and the 3rd one (Hid: Handle
driver-specific device descriptor in core).

Cheers,
Benjamin

On Mon, Apr 23, 2012 at 15:23, Nestor Lopez Casado
<nlopezcasad@logitech.com> wrote:
> This change looks good to me. I can't test right now, but I will chec=
k as
> soon as I have some time to work on our kernel drivers again.
>
> Nestor.
>
>
> On Sun, Apr 22, 2012 at 2:21 PM, Henrik Rydberg <rydberg@euromail.se>=
 wrote:
>>
>> The current code allows several consecutive calls to hid_parse_repor=
t(),
>> which may have happened to work before, but would cause a memory lea=
k
>> and generally be incorrect. This patch collects all the reports
>> before sending them once.
>>
>> Compiled, not tested.
>>
>> Cc: Nestor Lopez Casado <nlopezcasad@logitech.com>
>> Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>
>> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
>> ---
>> =A0drivers/hid/hid-logitech-dj.c | =A0 71
>> +++++++++++++++++------------------------
>> =A01 file changed, 29 insertions(+), 42 deletions(-)
>>
>> diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitec=
h-dj.c
>> index 2b56efc..e1c38bb 100644
>> --- a/drivers/hid/hid-logitech-dj.c
>> +++ b/drivers/hid/hid-logitech-dj.c
>> @@ -155,6 +155,14 @@ static const char media_descriptor[] =3D {
>> =A0/* Maximum size of all defined hid reports in bytes (including re=
port id)
>> */
>> =A0#define MAX_REPORT_SIZE 8
>>
>> +/* Make sure all descriptors are present here */
>> +#define MAX_RDESC_SIZE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 \
>> + =A0 =A0 =A0 (sizeof(kbd_descriptor) + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
\
>> + =A0 =A0 =A0 =A0sizeof(mse_descriptor) + =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 \
>> + =A0 =A0 =A0 =A0sizeof(consumer_descriptor) + =A0 =A0 =A0 =A0 =A0\
>> + =A0 =A0 =A0 =A0sizeof(syscontrol_descriptor) + =A0 =A0 =A0 =A0\
>> + =A0 =A0 =A0 =A0sizeof(media_descriptor))
>> +
>> =A0/* Number of possible hid report types that can be created by thi=
s
>> driver.
>> =A0*
>> =A0* Right now, RF report types have the same report types (or repor=
t id's)
>> @@ -473,9 +481,17 @@ static int logi_dj_output_hidraw_report(struct
>> hid_device *hid, u8 * buf,
>> =A0 =A0 =A0 =A0return 0;
>> =A0}
>>
>> +static void rdcat(char **rdesc, unsigned int *rsize, const char *da=
ta,
>> unsigned int size)
>> +{
>> + =A0 =A0 =A0 memcpy(*rdesc + *rsize, data, size);
>> + =A0 =A0 =A0 *rsize +=3D size;
>> +}
>> +
>> =A0static int logi_dj_ll_parse(struct hid_device *hid)
>> =A0{
>> =A0 =A0 =A0 =A0struct dj_device *djdev =3D hid->driver_data;
>> + =A0 =A0 =A0 unsigned int rsize =3D 0;
>> + =A0 =A0 =A0 char *rdesc;
>> =A0 =A0 =A0 =A0int retval;
>>
>> =A0 =A0 =A0 =A0dbg_hid("%s\n", __func__);
>> @@ -483,70 +499,38 @@ static int logi_dj_ll_parse(struct hid_device =
*hid)
>> =A0 =A0 =A0 =A0djdev->hdev->version =3D 0x0111;
>> =A0 =A0 =A0 =A0djdev->hdev->country =3D 0x00;
>>
>> + =A0 =A0 =A0 rdesc =3D kmalloc(MAX_RDESC_SIZE, GFP_KERNEL);
>> + =A0 =A0 =A0 if (!rdesc)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> +
>> =A0 =A0 =A0 =A0if (djdev->reports_supported & STD_KEYBOARD) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dbg_hid("%s: sending a kbd descriptor=
, reports_supported:
>> %x\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, djdev->repo=
rts_supported);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D hid_parse_report(hid,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 (u8 *) kbd_descriptor,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 sizeof(kbd_descriptor));
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (retval) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dbg_hid("%s: sending a=
 kbd descriptor, hid_parse
>> failed"
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " erro=
r: %d\n", __func__, retval);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return retval;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rdcat(&rdesc, &rsize, kbd_descriptor,
>> sizeof(kbd_descriptor));
>> =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0if (djdev->reports_supported & STD_MOUSE) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dbg_hid("%s: sending a mouse descript=
or, reports_supported:
>> "
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"%x\n", __func__, djd=
ev->reports_supported);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D hid_parse_report(hid,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 (u8 *) mse_descriptor,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 sizeof(mse_descriptor));
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (retval) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dbg_hid("%s: sending a=
 mouse descriptor, hid_parse
>> "
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "faile=
d error: %d\n", __func__, retval);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return retval;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rdcat(&rdesc, &rsize, mse_descriptor,
>> sizeof(mse_descriptor));
>> =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0if (djdev->reports_supported & MULTIMEDIA) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dbg_hid("%s: sending a multimedia rep=
ort descriptor: %x\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, djdev->repo=
rts_supported);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D hid_parse_report(hid,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 (u8 *) consumer_descriptor,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 sizeof(consumer_descriptor));
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (retval) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dbg_hid("%s: sending a=
 consumer_descriptor,
>> hid_parse "
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "faile=
d error: %d\n", __func__, retval);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return retval;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rdcat(&rdesc, &rsize, consumer_descrip=
tor,
>> sizeof(consumer_descriptor));
>> =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0if (djdev->reports_supported & POWER_KEYS) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dbg_hid("%s: sending a power keys rep=
ort descriptor: %x\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, djdev->repo=
rts_supported);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D hid_parse_report(hid,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 (u8 *) syscontrol_descriptor,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 sizeof(syscontrol_descriptor));
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (retval) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dbg_hid("%s: sending a=
 syscontrol_descriptor, "
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "hid_p=
arse failed error: %d\n",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func=
__, retval);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return retval;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rdcat(&rdesc, &rsize, syscontrol_descr=
iptor,
>> sizeof(syscontrol_descriptor));
>> =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0if (djdev->reports_supported & MEDIA_CENTER) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dbg_hid("%s: sending a media center r=
eport descriptor:
>> %x\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, djdev->repo=
rts_supported);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D hid_parse_report(hid,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 (u8 *) media_descriptor,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 sizeof(media_descriptor));
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (retval) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dbg_hid("%s: sending a=
 media_descriptor, hid_parse
>> "
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "faile=
d error: %d\n", __func__, retval);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return retval;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rdcat(&rdesc, &rsize, media_descriptor=
,
>> sizeof(media_descriptor));
>> =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0if (djdev->reports_supported & KBD_LEDS) {
>> @@ -554,7 +538,10 @@ static int logi_dj_ll_parse(struct hid_device *=
hid)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, djdev->repo=
rts_supported);
>> =A0 =A0 =A0 =A0}
>>
>> - =A0 =A0 =A0 return 0;
>> + =A0 =A0 =A0 retval =3D hid_parse_report(hid, rdesc, rsize);
>> + =A0 =A0 =A0 kfree(rdesc);
>> +
>> + =A0 =A0 =A0 return retval;
>> =A0}
>>
>> =A0static int logi_dj_ll_input_event(struct input_dev *dev, unsigned=
 int
>> type,
>> --
>> 1.7.10
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
