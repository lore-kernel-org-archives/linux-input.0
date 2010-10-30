From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 4/5] input: wacom: Add support for the Bamboo Touch
 trackpad (rev4)
Date: Sat, 30 Oct 2010 04:52:45 -0700
Message-ID: <AANLkTinYiPeygD7Gt6+mCjx2ZV84LB=zCsk3Tey5NDng@mail.gmail.com>
References: <1283607783-29388-1-git-send-email-rydberg@euromail.se>
	<1283607783-29388-5-git-send-email-rydberg@euromail.se>
	<AANLkTikpAfeSgCsaBWPcW7EncbW7UtLVjH=bpmmbVU-7@mail.gmail.com>
	<4CB5F8B3.6010504@euromail.se>
	<AANLkTikcEjnWghuJGAe-JiUu2n0vfmE3vh7SzUpqK2tP@mail.gmail.com>
	<AANLkTi=ucH8YF1OF-OMcuiruASuhOE5McuGfQzJ5Yy+2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49533 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244Ab0J3Lwr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 30 Oct 2010 07:52:47 -0400
Received: by wwe15 with SMTP id 15so4434240wwe.1
        for <linux-input@vger.kernel.org>; Sat, 30 Oct 2010 04:52:46 -0700 (PDT)
In-Reply-To: <AANLkTi=ucH8YF1OF-OMcuiruASuhOE5McuGfQzJ5Yy+2@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>, Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>, Rafi Rubin <rafi@seas.upenn.edu>

On Fri, Oct 29, 2010 at 5:55 PM, Chris Bagwell <chris@cnpbagwell.com> w=
rote:
> On Fri, Oct 29, 2010 at 3:45 PM, Ping Cheng <pinglinux@gmail.com> wro=
te:
>> On Wed, Oct 13, 2010 at 11:21 AM, Henrik Rydberg <rydberg@euromail.s=
e> wrote:
>>>
>>>>> +static int wacom_bpt_irq(struct wacom_wac *wacom, size_t len)
>>>
>>>>> +{
>>>>> + =A0 =A0 =A0 static int trkid;
>>>>> + =A0 =A0 =A0 struct input_dev *input =3D wacom->input;
>>>>> + =A0 =A0 =A0 unsigned char *data =3D wacom->data;
>>>>> + =A0 =A0 =A0 int sp =3D 0, sx =3D 0, sy =3D 0, count =3D 0;
>>>>> + =A0 =A0 =A0 int i;
>>>>> +
>>>>> + =A0 =A0 =A0 if (len !=3D WACOM_PKGLEN_BBTOUCH)
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>>>>> +
>>>>> + =A0 =A0 =A0 for (i =3D 0; i < 2; i++) {
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int p =3D data[9 * i + 2];
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_mt_slot(input, i);
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (p) {
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int x =3D get_unali=
gned_be16(&data[9 * i + 3]) & 0x7ff;
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int y =3D get_unali=
gned_be16(&data[9 * i + 5]) & 0x7ff;
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(in=
put, ABS_MT_PRESSURE, p);
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(in=
put, ABS_MT_POSITION_X, x);
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(in=
put, ABS_MT_POSITION_Y, y);
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (wacom->id[i] < =
0)
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wac=
om->id[i] =3D trkid++ & MAX_TRACKING_ID;
>>>>
>>>> Why do we need an arbitrary MAX_TRACKING_ID when the device can te=
ll
>>>> us how many IDs we can have and it tracks the individual fingers f=
or
>>>> us? In this case, there are only two ID/fingers and the ID can be
>>>> retrieved from the raw data. I must be missing something in the
>>>> defintion of MAX_TRACKING_ID.
>>>
>>> In the language of ABS_MT, there is a distinction between slot and =
id. The slot
>>> is the handle used to communicate a unique touch. The id is the ide=
ntifier of
>>> that touch. The device tells us how many slots we have. The range o=
f ids is in
>>> principle infinite. In practice, it is set to a large number.
>>
>> Sorry to bring this topic back again. I was under the impression tha=
t
>> I was the only one who didn't get the spec clear. The discussion at
>> yesterday's UDS session made me feel I am not alone (good or bad :).
>> Let me try it again to see if I can get it right this time.
>>
>> From the "Multi-touch (MT) Protocol" under Documentation/input, we s=
ee
>> the following:
>>
>> "The slot protocol requires the use of the ABS_MT_TRACKING_ID, eithe=
r
>> provided by the hardware or computed from the raw data".
>>
>> That means if the hardware provides the tracking ID, we use it.
>> Otherwise we lose that specific information reported from the
>> hardware.
>>
>> For the Bamboo case, the tracking ID happens to be the same as the
>> slot ID we use. But, there are devices, as far as I know, report up =
to
>> 10 fingers/touches. So, there would be 10 slots to report the data.
>> But, the tracking ID we get from the devices is 0 to 255. So, slot 5
>> could have a tracking ID of 123 now and 9 when tuch 123 is up and
>> touch 5 is down.
>>
>>> To answer a possible follow-up question: from the tracking id, you =
can tell if a
>>> contact is present, if it is new, and if it is older than another c=
ontact.
>>
>> The new and old attribute can be tracked by a time stamp in the
>> userland. Kernel driver doesn't need to worry about it. Maybe I am
>> missing an use case in the kernel?
>>
>> Ping
>>
>
> Let me ask the same basic question using some examples.
>
> First, let me say I see no issues with MT spec... its just you may
> have a usecase in mind for tracking ID always being unique that not
> everyone has fully grasped.

I agree with you (how come I always agree with you :). I am not asking
for a spec change. I am only discussing a code change. And I want to
make sure my code change will not affect any exsiting userland
programs, especially Henrik's programs.

> As I'm updating xf86-input-wacom, I see ABS_MT_SLOT as mostly same
> meaning as BTN_TOOL_PEN/ERASER/MOUSE. =A0It gives context of all MT
> events to follow for a specific touch.

Right.

> I next see ABS_MT_TRACKING_ID a little like BTN_TOUCH sent along with
> that tool's data. =A0It tells you when touch/tool is in proximity and
> thus that the x/y/pressure values have meaning. =A0Here -1 is out of
> proximity and positive value is in proximity and also a little extra
> (how old a touch compared to others, etc).

Agree.

> Now, for HW that enforces slot =3D=3D touch #, if we made
> ABS_MT_TRACKING_ID while in proximity/touching the same value as
> ABS_MT_SLOT then user app could simplify and totally ignore
> ABS_MT_SLOT event (I think).

Bamboo is a special case which does not make a ddifference for SLOT
and TRACKING IDs. My concern is for those devices that do report
TRACKING IDs differently from the touch #. I want to make the code
consistent accross all devices that support TRACKING IDs.

> So I guess the question is does unique ID solve some specific user
> space problem that couldn't be solved with user space timestamps take=
n
> when ABS_MT_TRACKING_ID first becomes non-negative?

Some user land developers told me so. And they want to get the
TRACKING_IDs if hardware provides them.

> Mostly, I expect the answer is "stop being lazy and just look at both
> events so you'll work with all hardware types and without timestamps"=
=2E

Do you mean the answer from me or from you :)?

No, I won't answer that to you or anyone. Not all user land programs
need all the information we report. So, It would be up to the app
developers to decide how to track the data. We, as device driver
developer, only need to report the data as close as hardware provides
and that meets the spec.

Making a patch might be easier to show what meant. I'll do that soon.
I want to make sure my change does not affect Henrik's exsiting
userland programs.

Hope this clears some confusion.

Ping
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
