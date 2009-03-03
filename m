From: Richard Walmsley <richwalm@gmail.com>
Subject: Re: [PATCH] input: DragonRise Inc. game controller force feedback
	support
Date: Tue, 3 Mar 2009 16:47:02 +1300
Message-ID: <167575d80903021947k3a9d4b01vebea2e94a83d1ddc@mail.gmail.com>
References: <167575d80902261744h3d133416g1afeb5b68d760cbf@mail.gmail.com>
	 <20090228141046.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.232]:1165 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756121AbZCCDrE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Mar 2009 22:47:04 -0500
Received: by rv-out-0506.google.com with SMTP id g37so2587570rvb.1
        for <linux-input@vger.kernel.org>; Mon, 02 Mar 2009 19:47:02 -0800 (PST)
In-Reply-To: <20090228141046.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Whoops. Sorry about that. I'll send it to the correct maintainer.

On Sun, Mar 1, 2009 at 11:15 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Richard,
>
> On Fri, Feb 27, 2009 at 02:44:11PM +1300, Richard Walmsley wrote:
>> Adds force feedback support for USB DragonRise Inc. game controllers=
=2E
>> These devices are mass produced in China and distributed under sever=
al vendors.
>>
>
> Looks pretty good, however it shoudl go through Jiri Kosina (CCed).
>
>> +
>> +static int drff_init(struct hid_device *hid)
>> +{
>> + =A0 =A0 struct drff_device *drff;
>> + =A0 =A0 struct hid_report *report;
>> + =A0 =A0 struct hid_input *hidinput =3D list_entry(hid->inputs.next=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 struct hid_input, list);
>
> list_first_entry()?
>
>> + =A0 =A0 struct list_head *report_list =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &hid->report_enum[HID_OUTP=
UT_REPORT].report_list;
>> + =A0 =A0 struct list_head *report_ptr =3D report_list;
>> + =A0 =A0 struct input_dev *dev =3D hidinput->input;
>> + =A0 =A0 int error;
>> +
>> + =A0 =A0 if (list_empty(report_list)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&hid->dev, "no output reports foun=
d\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 report_ptr =3D report_ptr->next;
>> +
>> + =A0 =A0 report =3D list_entry(report_ptr, struct hid_report, list)=
;
>
> You might want to simply use list_first_entry() for this.
>
> --
> Dmitry
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
