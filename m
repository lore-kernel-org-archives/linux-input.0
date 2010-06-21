From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: Wacom based devices and the mt kernel protocol.
Date: Sun, 20 Jun 2010 17:31:20 -0700
Message-ID: <AANLkTimCsVwppeTKXErpA6_1vwPHuQeqJHcdzLKd2EEp@mail.gmail.com>
References: <AANLkTinq_3P-QrTqsEdtyMbBtc9EXhahclER_4s5_Kx2@mail.gmail.com>
	<AANLkTikExwM_LBUw_-z2eimO96Dxs_fNfAM4jlftXyHM@mail.gmail.com>
	<4C1E6A8C.4020904@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:33548 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756007Ab0FUAbV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Jun 2010 20:31:21 -0400
In-Reply-To: <4C1E6A8C.4020904@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: Mohamed Ikbel Boulabiar <boulabiar@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Chase Douglas <chase.douglas@canonical.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

On Sun, Jun 20, 2010 at 12:22 PM, Rafi Rubin <rafi@seas.upenn.edu> wrot=
e:
>>> N-Trig based devices and Stantum ones are the most compliant,
>>
>> That's fair since they don't need to track the fingers.
>
> N-Trig doesn't have hardware tracking, Stantum does.

Sorry for my ignorance. I don't have much time to keep track of what
other devices are doing. Keeping all of my own balls rolling is more
than enough work for me :).

>>> so Wacom situation needs to be clarified specially considering they=
 are HID
>>> devices (meaning similar to the others devices which respect the
>>> protocol).
>>
>> Well, it is not a pure HID issue. =A0It is more of how we want to
>> support MT on Linux issue.
>
> Side note for Ikbel, its not clear the wacom devices actually stay HI=
D compliant
> when the full protocol is active, and the basic modes are really basi=
c (and not
> very useful). As my understanding of the way HID and usb stuff commun=
icate in
> general, I've been growing less convinced its a protocol issue, more =
like an
> initialization problem.

Thank you Rafi for explaining this issue.  Wacom tablets have a
relatively long history, longer than the time that digitizers were
supported on Linux. The default HID mouse protocol was introduced due
to the history, which was required by Microsoft.... We can not change
history, can we :)?

Wacom kept their devices consistent protocol-wise over the years.
That's why even the modern digitizers default to the basic HID
protocol.

> Still I'm not quite sure.

I think you've got the point.

>>> This impact very much the decision of a Linux user wanting to buy w=
acom mt device.
>>
>> I think end users have already got the Linux support from Wacom. =A0=
Can
>> you share the specific issues that are preventing Linux end users fr=
om
>> buying a Wacom MT devices? If I didn't misunderstand your point here=
,
>> you are talking about Linux users, not Linux developers/hackers,
>> right?
>
> I think normal users wanting to use linux for MT are generally frustr=
ated and
> confused at the moment.

Why do the end users get frustrated and confused? Can you share some
examples from an end user's (not developer's) perspective with me?

> Certainly the protocol between the wacom kernel driver
> and the wacom user space driver is way below the level that most are =
following.

By "most", do you mean most MT device drivers, or most end users, or
most developers? I am eager to bring the Wacom driver to the specific
level.

> As developers, I think we have a strong interest in seeing wacom migr=
ate to a
> shared protocol. =A0But our interests are in pushing the functionalit=
y beyond
> what's currently available, and we just want to see everyone get equa=
l access to
> features as we create them. =A0I think to convince Ping (if he weren'=
t already),
> and the others working on the Wacom code, we'd have to show off some =
of what
> he's going to gain by switching, and at the moment, as a community, I=
 don't
> think we are quite ready, maybe soon.

I do see the positive sign here. And, BTW, it is a she that you are
talking to :).  Don't worry, you are still taking to the same person.
So, it really doesn't matter to me. But, I don't want you to get the
fact from someone else and to be "puzzled" :).

> So, Ping, consider that I and others will have cool things to show yo=
u in the
> near future, and if you start migrating you will get some cool new fu=
nctionality
> when the two waves of progress collide. =A0Also, I think Henrik's B p=
rotocol has
> some cool advantages which you've demonstrated considerable interest =
in. =A0So I
> gather you do intend to switch when its convenient?

Why not? Do you think I am that stupid :)? To be honest, I've been
waiting for the day for a while.

>>> Ping can you clarifie the situation of wacom based devices ?
>>
>> What else do you need me to clarify? I am all ears and I am ready to
>> clarify any thing that puzzles you.
>
> Will Wacom be moving to more than 2 finger support in the near future=
? =A0Do you
> already have some products on the market?

No, we do not have 2+ finger devices on the market and I can not tell
what the future would be. We'll see what it is when time comes.  Any
more questions :)?

Ping
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
