From: Mohamed Ikbel Boulabiar <boulabiar@gmail.com>
Subject: Re: Wacom based devices and the mt kernel protocol.
Date: Mon, 21 Jun 2010 11:09:52 +0200
Message-ID: <AANLkTikZVIaRmf7jSLsEO39ssh6d-_Zk-D68DvucghTB@mail.gmail.com>
References: <AANLkTinq_3P-QrTqsEdtyMbBtc9EXhahclER_4s5_Kx2@mail.gmail.com>
	<AANLkTikExwM_LBUw_-z2eimO96Dxs_fNfAM4jlftXyHM@mail.gmail.com>
	<4C1E6A8C.4020904@seas.upenn.edu> <AANLkTimCsVwppeTKXErpA6_1vwPHuQeqJHcdzLKd2EEp@mail.gmail.com>
	<4C1EBE06.7020605@seas.upenn.edu> <AANLkTikR0PXLqYuK8jDd_pWvcmVlRLnQFLVElHH8e71a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:60324 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757045Ab0FUJKO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Jun 2010 05:10:14 -0400
In-Reply-To: <AANLkTikR0PXLqYuK8jDd_pWvcmVlRLnQFLVElHH8e71a@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Rafi Rubin <rafi@seas.upenn.edu>, Henrik Rydberg <rydberg@euromail.se>, Chase Douglas <chase.douglas@canonical.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>

On Mon, Jun 21, 2010 at 7:30 AM, Ping Cheng <pinglinux@gmail.com> wrote=
:
> On Sun, Jun 20, 2010 at 6:19 PM, Rafi Rubin <rafi@seas.upenn.edu> wro=
te:
>>>
>>>>>> This impact very much the decision of a Linux user wanting to bu=
y wacom mt device.
>>>>>
>>>>> I think end users have already got the Linux support from Wacom. =
=A0Can
>>>>> you share the specific issues that are preventing Linux end users=
 from
>>>>> buying a Wacom MT devices? If I didn't misunderstand your point h=
ere,
>>>>> you are talking about Linux users, not Linux developers/hackers,
>>>>> right?
>>>>
>>>> I think normal users wanting to use linux for MT are generally fru=
strated and
>>>> confused at the moment.
>>>
>>> Why do the end users get frustrated and confused? Can you share som=
e
>>> examples from an end user's (not developer's) perspective with me?

it would be no difference between users and developers behaviors, it
is just a matter of time, developers get frustrated some time before
normal users would be :)




>> Sorry, I've been too focused on the n-trig users. =A0They have been =
frustrated,
>> and I've seen from the forums that some have been playing with custo=
mized
>> versions of both the kernel and wacom x driver to get your two finge=
r gestures.
>>
>> I'm also projecting my own frustrations, seeing the X mt interface s=
till not
>> quite set, and very little in the way of applications that use mt at=
 all.
>> We're still quite a ways away from seeing the full potential of a mo=
re hands on desktop.
>
> As far as I understand, =A0this issue is not device driver or MT supp=
ort
> specific. It is universal =A0on Linux.

Maybe because not all of drivers are up-to-date to new changes happenin=
g.
The new protocol is a way to standardize the way all mt devices are han=
dled.



>>>> Certainly the protocol between the wacom kernel driver
>>>> and the wacom user space driver is way below the level that most a=
re following.
>>>
>>> By "most", do you mean most MT device drivers, or most end users, o=
r
>>> most developers? I am eager to bring the Wacom driver to the specif=
ic
>>> level.
>>
>> End users, they don't tend to care about the internal protocols as l=
ong as their
>> programs do what they want.
>
> Then, I still don't get what you meant by "way below the level that
> most are following". I'd really like to understand it so I can work o=
n
> it.

if 5 or 6 mt devices are supported in the new protocol and wacom is
not, this means a split in the support way. You've just told us the
point of how bad having different ways things are supported.




To summarize the discussion with you Ping, you will support the new
protocol as far as it will show a good reason for a switch yep ? But
what if this can make other devices look as they are better supported
in the near future with upcoming changes (even if wacom are better
technically) ?
This remembers me the days when ntrig was not supported in Linux (and
with no intention to be supported), then after the non-corporate
driver comes, they tried to publish their own.
http://www.ipetitions.com/petition/ntrig-on-linux/
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
