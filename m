From: Jaikumar Ganesh <jaikumarg@android.com>
Subject: Re: [PATCH] HID: magicmouse: Fix race in input mapping.
Date: Tue, 20 Sep 2011 15:57:35 -0700
Message-ID: <CAA8bQNin=0hZTaL=sU-fh_G_n6nDXgVOfaVRKy8Hog0i_C2pqw@mail.gmail.com>
References: <1316211154-9436-1-git-send-email-jaikumarg@android.com> <CANq1E4THfMs-iomjgBowLZGNihVe7kRSMXG1RYM=jfXBn2oAsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:44377 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225Ab1ITW56 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Sep 2011 18:57:58 -0400
Received: from hpaq14.eem.corp.google.com (hpaq14.eem.corp.google.com [172.25.149.14])
	by smtp-out.google.com with ESMTP id p8KMvv6T025063
	for <linux-input@vger.kernel.org>; Tue, 20 Sep 2011 15:57:57 -0700
Received: from yxm34 (yxm34.prod.google.com [10.190.4.34])
	by hpaq14.eem.corp.google.com with ESMTP id p8KMvkTG025275
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Tue, 20 Sep 2011 15:57:55 -0700
Received: by yxm34 with SMTP id 34so2016615yxm.39
        for <linux-input@vger.kernel.org>; Tue, 20 Sep 2011 15:57:55 -0700 (PDT)
In-Reply-To: <CANq1E4THfMs-iomjgBowLZGNihVe7kRSMXG1RYM=jfXBn2oAsA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

Hi David:

On Tue, Sep 20, 2011 at 3:43 PM, David Herrmann
<dh.herrmann@googlemail.com> wrote:
> Hi Jaikumar
>
> On Sat, Sep 17, 2011 at 12:12 AM, Jaikumar Ganesh <jaikumarg@android.=
com> wrote:
>> magicmouse_select_input was being called after device
>
> This should be "*setup_input" not "*select_input".
>
>> registration. Hence, any thread scanning "/dev" for new
>> devices will see the input bits change on an open file
>> descriptor. Fix this by calling select_input inside
>> input_mapping.
>
> Isn't input_mapped more appropriate here? Otherwise
> hidinput_configure_usage could probably overwrite your abs values.
>
>> Based on discussions with Michael Poole <mdpoole@troilus.org>
>>
>> Change-Id: I289a37a850977c2cbbc9eb76fbf6c9a28d1833c5
>> Signed-off-by: Jaikumar Ganesh <jaikumarg@android.com>
>> ---
>> =A0drivers/hid/hid-magicmouse.c | =A0 13 +++++++------
>> =A01 files changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmou=
se.c
>> index 56d0539..1175452 100644
>> --- a/drivers/hid/hid-magicmouse.c
>> +++ b/drivers/hid/hid-magicmouse.c
>> @@ -98,6 +98,7 @@ struct magicmouse_sc {
>> =A0 =A0 =A0 =A0int ntouches;
>> =A0 =A0 =A0 =A0int scroll_accel;
>> =A0 =A0 =A0 =A0unsigned long scroll_jiffies;
>> + =A0 =A0 =A0 bool setup_input;
>>
>> =A0 =A0 =A0 =A0struct {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0short x;
>> @@ -437,6 +438,11 @@ static int magicmouse_input_mapping(struct hid_=
device *hdev,
>> =A0 =A0 =A0 =A0if (!msc->input)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0msc->input =3D hi->input;
>>
>> + =A0 =A0 =A0 if (!msc->setup_input) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 magicmouse_setup_input(msc->input, hde=
v);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 msc->setup_input =3D true;
>> + =A0 =A0 =A0 }
>> +
>> =A0 =A0 =A0 =A0/* Magic Trackpad does not give relative data after s=
witching to MT */
>> =A0 =A0 =A0 =A0if (hi->input->id.product =3D=3D USB_DEVICE_ID_APPLE_=
MAGICTRACKPAD &&
>> =A0 =A0 =A0 =A0 =A0 =A0field->flags & HID_MAIN_ITEM_RELATIVE)
>> @@ -465,6 +471,7 @@ static int magicmouse_probe(struct hid_device *h=
dev,
>> =A0 =A0 =A0 =A0hid_set_drvdata(hdev, msc);
>>
>> =A0 =A0 =A0 =A0msc->single_touch_id =3D NO_TOUCHES;
>> + =A0 =A0 =A0 msc->setup_input =3D false;
>>
>> =A0 =A0 =A0 =A0ret =3D hid_parse(hdev);
>> =A0 =A0 =A0 =A0if (ret) {
>> @@ -478,12 +485,6 @@ static int magicmouse_probe(struct hid_device *=
hdev,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_free;
>> =A0 =A0 =A0 =A0}
>>
>> - =A0 =A0 =A0 /* We do this after hid-input is done parsing reports =
so that
>> - =A0 =A0 =A0 =A0* hid-input uses the most natural button and axis I=
Ds.
>> - =A0 =A0 =A0 =A0*/
>> - =A0 =A0 =A0 if (msc->input)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 magicmouse_setup_input(msc->input, hde=
v);
>> -
>> =A0 =A0 =A0 =A0if (id->product =3D=3D USB_DEVICE_ID_APPLE_MAGICMOUSE=
)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0report =3D hid_register_report(hdev, =
HID_INPUT_REPORT,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MOUSE_REPORT_ID);
>> --
>> 1.7.3.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-inpu=
t" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
> I think this is the same problem as:
> http://thread.gmane.org/gmane.linux.kernel.input/21660/focus=3D21669
>
> Several drivers need to set additional flags on the input device. I'd
> recommend an "input_register" callback that is called after
> hidinput_configure_usage() is called but before the input device is
> registered. But it is only called once and not for every hid-descr
> field. Then we could skip the "msc->setup_input" boolean flag.
> However, until then this fix seems fine, although I'd use input_mappe=
d
> instead of input_mapping.

This was one of my suggestions too in this thread"
"http://thread.gmane.org/gmane.linux.kernel.input/21604/"

This needs to be discussed on a more general basis since it will
affect many drivers.

>
> Regards
> David
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
