From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [PATCH v2 2/3] HID: multitouch: add control of the feature
 "Maximum Contact Number"
Date: Tue, 24 Jan 2012 15:39:09 +0100
Message-ID: <CAN+gG=ERwqDgydj-LLnv2GPLSiW8cC4QZS2f7shxxnNLzJY+xg@mail.gmail.com>
References: <1326887468-5148-1-git-send-email-benjamin.tissoires@enac.fr>
	<1326887468-5148-3-git-send-email-benjamin.tissoires@enac.fr>
	<20120120161956.GB18530@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:54261 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756569Ab2AXOjK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Jan 2012 09:39:10 -0500
In-Reply-To: <20120120161956.GB18530@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, Mohamed Ikbel Boulabiar <boulabiar@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Henrik,

On Fri, Jan 20, 2012 at 17:19, Henrik Rydberg <rydberg@euromail.se> wro=
te:
> Hi Benjamin,
>
>> If the programmer fills the field maxcontacts in the mt_class,
>> then the driver will set the feature to this value. It is safe
>> for current drivers as the feature is read/right in the HID norm
>
> read/write, I presume.

you're right... ;-)

>
>> @@ -609,6 +612,36 @@ static void mt_set_input_mode(struct hid_device=
 *hdev)
>> =A0 =A0 =A0 }
>> =A0}
>>
>> +static void mt_set_maxcontacts(struct hid_device *hdev)
>> +{
>> + =A0 =A0 struct mt_device *td =3D hid_get_drvdata(hdev);
>> + =A0 =A0 struct hid_report *r;
>> + =A0 =A0 struct hid_report_enum *re;
>> + =A0 =A0 int fieldmax, max;
>> +
>> + =A0 =A0 if (td->maxcontact_report_id < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 if (!td->mtclass.maxcontacts)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 re =3D &(hdev->report_enum[HID_FEATURE_REPORT]);
>
> Why parenthesis here?

ok

>
>> + =A0 =A0 r =3D re->report_id_hash[td->maxcontact_report_id];
>> + =A0 =A0 if (r) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 max =3D td->mtclass.maxcontacts;
>> + =A0 =A0 =A0 =A0 =A0 =A0 fieldmax =3D r->field[0]->logical_maximum;
>> + =A0 =A0 =A0 =A0 =A0 =A0 hid_info(hdev, "%s: value =3D %d / %d / %d=
\n", __func__,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r->field[0]->value[0],
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->mtclass.maxcontacts,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fieldmax);
>
> Looks like debug information, please downplay or remove.

I can remove them if you need.

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 max =3D fieldmax < max ? fieldmax : max;
>
> There are kernel variants of min/max functions to consider here.

I'll look for them.

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (r->field[0]->value[0] !=3D max) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r->field[0]->value[0] =3D =
max;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 usbhid_submit_report(hdev,=
 r, USB_DIR_OUT);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>
> So the report is in fact only set when different... Do we know for
> which current devices this is true?

Currently, I've got only the Perixx touchpad that needs this feature
to be set. The initial value is 0 whereas it should be 2.

Maybe some drivers that used the DUAL_MT_CLS_* can handle more, but I
have no idea has I don't have many of them.

Cheers,
Benjamin

>
> Thanks,
> Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
