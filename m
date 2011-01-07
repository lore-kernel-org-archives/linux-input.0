From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [RFC v3 1/5] hid: add feature_mapping callback
Date: Fri, 7 Jan 2011 20:09:59 +0100
Message-ID: <AANLkTimJG=+VxrjVvAtFjZG__Y9a_NSV335_ys_d5yc4@mail.gmail.com>
References: <1294425762-29730-1-git-send-email-benjamin.tissoires@enac.fr>
	<1294425762-29730-2-git-send-email-benjamin.tissoires@enac.fr>
	<20110107185939.GA29913@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:49430 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755116Ab1AGTKB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Jan 2011 14:10:01 -0500
In-Reply-To: <20110107185939.GA29913@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Stephane Chatty <chatty@enac.fr>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Oops, I missed the checkpatch for this one.

thanks,
Benjamin

On Fri, Jan 7, 2011 at 7:59 PM, Henrik Rydberg <rydberg@euromail.se> wr=
ote:
> On Fri, Jan 07, 2011 at 07:42:38PM +0100, Benjamin Tissoires wrote:
>> Currently hid doesn't export the features it knows to the specific m=
odules.
>> Some information can be really important in such features: MosArt an=
d
>> Cypress devices are by default not in a multitouch mode.
>> We have to send the value 2 on the right feature.
>>
>> This patch exports to the module the features report so they can fin=
d the
>> right feature to set up the correct mode.
>>
>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
>> ---
>
> Hi Benjamin,
>
> the patch series has some impurities (see checkpatch), and some minor=
 comments below, but all in all,
>
> Acked-by: Henrik Rydberg <rydberg@euromail.se>
>
>> =A0drivers/hid/hid-input.c | =A0 17 +++++++++++++----
>> =A0include/linux/hid.h =A0 =A0 | =A0 =A04 ++++
>> =A02 files changed, 17 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
>> index bb0b365..e1b48e4 100644
>> --- a/drivers/hid/hid-input.c
>> +++ b/drivers/hid/hid-input.c
>> @@ -287,6 +287,14 @@ static void hidinput_configure_usage(struct hid=
_input *hidinput, struct hid_fiel
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto ignore;
>> =A0 =A0 =A0 }
>>
>> + =A0 =A0 if (field->report_type =3D=3D HID_FEATURE_REPORT) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (device->driver->feature_mapping) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device->driver->feature_ma=
pping(device, hidinput, field,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0usa=
ge);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto ignore;
>> + =A0 =A0 }
>> +
>> =A0 =A0 =A0 if (device->driver->input_mapping) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 int ret =3D device->driver->input_mappin=
g(device, hidinput, field,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 usage, &=
bit, &max);
>> @@ -836,7 +844,6 @@ int hidinput_connect(struct hid_device *hid, uns=
igned int force)
>> =A0 =A0 =A0 struct hid_input *hidinput =3D NULL;
>> =A0 =A0 =A0 struct input_dev *input_dev;
>> =A0 =A0 =A0 int i, j, k;
>> - =A0 =A0 int max_report_type =3D HID_OUTPUT_REPORT;
>>
>> =A0 =A0 =A0 INIT_LIST_HEAD(&hid->inputs);
>>
>> @@ -853,10 +860,11 @@ int hidinput_connect(struct hid_device *hid, u=
nsigned int force)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>> =A0 =A0 =A0 }
>>
>> - =A0 =A0 if (hid->quirks & HID_QUIRK_SKIP_OUTPUT_REPORTS)
>> - =A0 =A0 =A0 =A0 =A0 =A0 max_report_type =3D HID_INPUT_REPORT;
>> + =A0 =A0 for (k =3D HID_INPUT_REPORT; k <=3D HID_FEATURE_REPORT; k+=
+) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (k =3D=3D HID_OUTPUT_REPORT &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hid->quirks & HID_QUIRK_SK=
IP_OUTPUT_REPORTS)
>
> Omitting the parenthesis here is not wrong, but not really customary =
either.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>>
>> - =A0 =A0 for (k =3D HID_INPUT_REPORT; k <=3D max_report_type; k++)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_for_each_entry(report, &hid->report=
_enum[k].report_list, list) {
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!report->maxfield)
>> @@ -909,6 +917,7 @@ int hidinput_connect(struct hid_device *hid, uns=
igned int force)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hidinput=
 =3D NULL;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>>
>> =A0 =A0 =A0 if (hidinput && input_register_device(hidinput->input))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_cleanup;
>> diff --git a/include/linux/hid.h b/include/linux/hid.h
>> index bb0f56f..75303b0 100644
>> --- a/include/linux/hid.h
>> +++ b/include/linux/hid.h
>> @@ -593,6 +593,7 @@ struct hid_usage_id {
>> =A0 * @report_fixup: called before report descriptor parsing (NULL m=
eans nop)
>> =A0 * @input_mapping: invoked on input registering before mapping an=
 usage
>> =A0 * @input_mapped: invoked on input registering after mapping an u=
sage
>> + * @feature_mapping: invoked on feature registering
>> =A0 * @suspend: invoked on suspend (NULL means nop)
>> =A0 * @resume: invoked on resume if device was not reset (NULL means=
 nop)
>> =A0 * @reset_resume: invoked on resume if device was reset (NULL mea=
ns nop)
>> @@ -636,6 +637,9 @@ struct hid_driver {
>> =A0 =A0 =A0 int (*input_mapped)(struct hid_device *hdev,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct hid_input *hidinp=
ut, struct hid_field *field,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct hid_usage *usage,=
 unsigned long **bit, int *max);
>> + =A0 =A0 void (*feature_mapping)(struct hid_device *hdev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct hid_input *hidinput=
, struct hid_field *field,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct hid_usage *usage);
>> =A0#ifdef CONFIG_PM
>> =A0 =A0 =A0 int (*suspend)(struct hid_device *hdev, pm_message_t mes=
sage);
>> =A0 =A0 =A0 int (*resume)(struct hid_device *hdev);
>> --
>> 1.7.3.4
>>
>
> Thanks,
> Henrik
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
