From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [PATCH] hid: Do not create input devices for feature reports
Date: Tue, 1 Mar 2011 17:21:28 +0100
Message-ID: <AANLkTikd67q_j_ySam7RZvau8WoESLEmdXkfCWerVrLp@mail.gmail.com>
References: <1298572259-18173-1-git-send-email-rydberg@euromail.se>
	<alpine.LNX.2.00.1103011702240.32580@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:44876 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756468Ab1CAQVa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Mar 2011 11:21:30 -0500
In-Reply-To: <alpine.LNX.2.00.1103011702240.32580@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Jiri,

Tested-by: Benjamin Tissoires <benjmain.tissoires@gmail.com>
Acked-by: Benjamin Tissoires <benjmain.tissoires@gmail.com>

Cheers,
Benjamin

On Tue, Mar 1, 2011 at 17:03, Jiri Kosina <jkosina@suse.cz> wrote:
> On Thu, 24 Feb 2011, Henrik Rydberg wrote:
>
>> When the multi input quirk is set, there is a new input device
>> created for every feature report. Since the idea is to present
>> features per hid device, not per input device, revert back to
>> the original report loop and change the feature_mapping() callback
>> to not take the input device as argument.
>>
>> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
>
> Hi Henrik,
>
> I agree with this implementation.
>
> Benjamin, did you manage to do the tests with hid-multitouch driver s=
o
> that I could put your Tested-by: to the patch and apply it?
>
> Thanks.
>
>> ---
>> Hi Jiri, Benjamin,
>>
>> It seems the feature report callback was a bit intrusive, after all;
>> for some devices such as ntrig, with multi input, there are addition=
al
>> input devices created. The following patch seems to fix the problem,
>> but it has not been tested on any device using the hid-multitouch
>> driver.
>>
>> Thanks,
>> Henrik
>>
>> =A0drivers/hid/hid-input.c =A0 =A0 =A0| =A0 30 +++++++++++++++++++++=
---------
>> =A0drivers/hid/hid-multitouch.c | =A0 =A02 +-
>> =A0include/linux/hid.h =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
>> =A03 files changed, 23 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
>> index 7f552bf..ebcc02a 100644
>> --- a/drivers/hid/hid-input.c
>> +++ b/drivers/hid/hid-input.c
>> @@ -290,14 +290,6 @@ static void hidinput_configure_usage(struct hid=
_input *hidinput, struct hid_fiel
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto ignore;
>> =A0 =A0 =A0 }
>>
>> - =A0 =A0 if (field->report_type =3D=3D HID_FEATURE_REPORT) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (device->driver->feature_mapping) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device->driver->feature_ma=
pping(device, hidinput, field,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 usage);
>> - =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 =A0 =A0 =A0 goto ignore;
>> - =A0 =A0 }
>> -
>> =A0 =A0 =A0 if (device->driver->input_mapping) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 int ret =3D device->driver->input_mappin=
g(device, hidinput, field,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 usage, &=
bit, &max);
>> @@ -835,6 +827,24 @@ static void hidinput_close(struct input_dev *de=
v)
>> =A0 =A0 =A0 hid_hw_close(hid);
>> =A0}
>>
>> +static void report_features(struct hid_device *hid)
>> +{
>> + =A0 =A0 struct hid_driver *drv =3D hid->driver;
>> + =A0 =A0 struct hid_report_enum *rep_enum;
>> + =A0 =A0 struct hid_report *rep;
>> + =A0 =A0 int i, j;
>> +
>> + =A0 =A0 if (!drv->feature_mapping)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 rep_enum =3D &hid->report_enum[HID_FEATURE_REPORT];
>> + =A0 =A0 list_for_each_entry(rep, &rep_enum->report_list, list)
>> + =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < rep->maxfield; i++)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (j =3D 0; j < rep->fie=
ld[i]->maxusage; j++)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 drv->featu=
re_mapping(hid, rep->field[i],
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rep->field[i]->usage + j);
>> +}
>> +
>> =A0/*
>> =A0 * Register the input device; print a message.
>> =A0 * Configure the input layer interface
>> @@ -863,7 +873,9 @@ int hidinput_connect(struct hid_device *hid, uns=
igned int force)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>> =A0 =A0 =A0 }
>>
>> - =A0 =A0 for (k =3D HID_INPUT_REPORT; k <=3D HID_FEATURE_REPORT; k+=
+) {
>> + =A0 =A0 report_features(hid);
>> +
>> + =A0 =A0 for (k =3D HID_INPUT_REPORT; k <=3D HID_OUTPUT_REPORT; k++=
) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (k =3D=3D HID_OUTPUT_REPORT &&
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hid->quirks & HID_QUIRK_=
SKIP_OUTPUT_REPORTS)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitou=
ch.c
>> index 07d3183..2bbc954 100644
>> --- a/drivers/hid/hid-multitouch.c
>> +++ b/drivers/hid/hid-multitouch.c
>> @@ -122,7 +122,7 @@ struct mt_class mt_classes[] =3D {
>> =A0 =A0 =A0 { }
>> =A0};
>>
>> -static void mt_feature_mapping(struct hid_device *hdev, struct hid_=
input *hi,
>> +static void mt_feature_mapping(struct hid_device *hdev,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct hid_field *field, struct hid_usag=
e *usage)
>> =A0{
>> =A0 =A0 =A0 if (usage->hid =3D=3D HID_DG_INPUTMODE) {
>> diff --git a/include/linux/hid.h b/include/linux/hid.h
>> index d91c25e..fc5faf6 100644
>> --- a/include/linux/hid.h
>> +++ b/include/linux/hid.h
>> @@ -638,7 +638,7 @@ struct hid_driver {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct hid_input *hidinp=
ut, struct hid_field *field,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct hid_usage *usage,=
 unsigned long **bit, int *max);
>> =A0 =A0 =A0 void (*feature_mapping)(struct hid_device *hdev,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct hid_input *hidinput=
, struct hid_field *field,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct hid_field *field,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct hid_usage *usage)=
;
>> =A0#ifdef CONFIG_PM
>> =A0 =A0 =A0 int (*suspend)(struct hid_device *hdev, pm_message_t mes=
sage);
>> --
>> 1.7.4.1
>>
>
> --
> Jiri Kosina
> SUSE Labs, Novell Inc.
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
