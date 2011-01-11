From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [RFC v3 3/5] hid-multitouch: support for PixCir-based panels
Date: Tue, 11 Jan 2011 16:10:28 +0100
Message-ID: <AANLkTikZs5eiN7LWP_LK9imGbdvUdw6mPqd_b__Qg3La@mail.gmail.com>
References: <1294425762-29730-1-git-send-email-benjamin.tissoires@enac.fr>
	<1294425762-29730-4-git-send-email-benjamin.tissoires@enac.fr>
	<20110107194918.GB29913@polaris.bitmath.org>
	<AANLkTin8tHO5x2SBugSaEQ6mJ-7upS2YX9OANK1phmdM@mail.gmail.com>
	<20110111130055.GB1961@polaris.bitmath.org>
	<AANLkTikqApgrHEh90dvw+8zUne1HA3FmDQYGeEnqZ2W6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41991 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753786Ab1AKPK3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Jan 2011 10:10:29 -0500
In-Reply-To: <AANLkTikqApgrHEh90dvw+8zUne1HA3FmDQYGeEnqZ2W6@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@bitmath.org>
Cc: Stephane Chatty <chatty@enac.fr>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jan 11, 2011 at 2:53 PM, Benjamin Tissoires
<benjamin.tissoires@enac.fr> wrote:
> On Tue, Jan 11, 2011 at 2:00 PM, Henrik Rydberg <rydberg@bitmath.org>=
 wrote:
>>> >> [...]
>>
>>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (value)
>>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->nu=
m_expected =3D value - 1;
>>> >
>>> > The - 1 should be dropped here.
>>>
>>> Here is the really tricky one:
>>>
>>> if I drop -1,
>>>
>>> the test below will be:
>>> =A0if (field->index =3D=3D td->last_field_index
>>> =A0 =A0 =A0 && td->num_received >=3D td->num_expected)
>>>
>>> but during the init of the device, the kernel receive 1 event thoug=
h
>>> the driver is not ready.
>>
>> So the current code really needs to also check whether the driver is
>> ready to events. Adding a state for it would be appropriate. As it
>> stands, an unrelated syntatic oddity is covering up this fact.
>>
>>>
>>> During this time, num_expected is at 0, and when we receive the
>>> last_field_index: segfault!
>>>
>>> To sum up, no, we can't.
>>
>> Yes we can. :-)
>
> I'll look into it but I promise nothing.
>

Hehe, I found the bug:

My tests aginst last field in slot and last field in report were not
guarded by (hid->claimed & HID_CLAIMED_INPUT).
Now it works without the -1.

Cheers,
Benjamin


>>> >> + =A0 =A0 if (field->index =3D=3D td->last_field_index
>>> >> + =A0 =A0 =A0 =A0 =A0 =A0 && td->num_received > td->num_expected=
)
>>> >
>>> > A ">=3D" here.
>>
>> still applies then.
>>
>> Thanks,
>> Henrik
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-inpu=
t" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
