From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [RFC v2 01/10] hid: add feature_mapping callback
Date: Fri, 7 Jan 2011 12:12:19 +0100
Message-ID: <AANLkTim3WY4yUWMQUBMV0q--w2U6LeVb_CYVgkUL_5tT@mail.gmail.com>
References: <1294248468-19979-1-git-send-email-benjamin.tissoires@enac.fr>
	<1294248468-19979-2-git-send-email-benjamin.tissoires@enac.fr>
	<20110106162223.GB1790@polaris.bitmath.org>
	<AANLkTi=xdPJP9okhRL8q-0vL5cVPKniAjve6BQHmB=+p@mail.gmail.com>
	<20110107101839.GA2312@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:40253 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751456Ab1AGLMV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Jan 2011 06:12:21 -0500
In-Reply-To: <20110107101839.GA2312@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Stephane Chatty <chatty@enac.fr>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jan 7, 2011 at 11:18 AM, Henrik Rydberg <rydberg@euromail.se> w=
rote:
>> >> =A0 =A0 =A0 struct input_dev *input_dev;
>> >> =A0 =A0 =A0 int i, j, k;
>> >> - =A0 =A0 int max_report_type =3D HID_OUTPUT_REPORT;
>> >> + =A0 =A0 int max_report_type =3D HID_FEATURE_REPORT;
>> >
>> > Doing it this way conflicts with the HID_QUIRK_SKIP_OUTPUT_REPORTS=
 quirk.
>>
>>
>> Do you agree on this way? (will send the patch in the next version)
>>
>> @@ -834,11 +842,10 @@ int hidinput_connect(struct hid_device *hid,
>> unsigned int force)
>> =A0{
>> =A0 =A0 =A0 struct hid_report *report;
>> =A0 =A0 =A0 struct hid_input *hidinput =3D NULL;
>> =A0 =A0 =A0 struct input_dev *input_dev;
>> =A0 =A0 =A0 int i, j, k;
>> - =A0 =A0 int max_report_type =3D HID_OUTPUT_REPORT;
>>
>> =A0 =A0 =A0 INIT_LIST_HEAD(&hid->inputs);
>>
>> =A0 =A0 =A0 if (!force) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < hid->maxcollection; i+=
+) {
>> @@ -851,14 +858,14 @@ int hidinput_connect(struct hid_device *hid,
>> unsigned int force)
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (i =3D=3D hid->maxcollection)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>> =A0 =A0 =A0 }
>>
>> - =A0 =A0 if (hid->quirks & HID_QUIRK_SKIP_OUTPUT_REPORTS)
>> - =A0 =A0 =A0 =A0 =A0 =A0 max_report_type =3D HID_INPUT_REPORT;
>> + =A0 =A0 for (k =3D HID_INPUT_REPORT; k <=3D HID_FEATURE_REPORT; k+=
+)
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (hid->quirks & HID_QUIRK_SKIP_OUTPUT_RE=
PORTS)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>>
>> - =A0 =A0 for (k =3D HID_INPUT_REPORT; k <=3D max_report_type; k++)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_for_each_entry(report, &hid->report=
_enum[k].report_list, list) {
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!report->maxfield)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue=
;
>
> Perfect.

Well, in fact, I made 2 big mistakes (forgot the brackets after
for(;;), and test if k=3D=3DHID_OUTPUT_REPORT...), but the idea is stil=
l
the same.

Sorry,
Benjamin
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
