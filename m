From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 02/12] Input: synaptics - do not invert y if 0
Date: Wed, 6 Jul 2011 07:15:07 +0800
Message-ID: <CAGS+omDdWSJqNkkcY7qmnjWDvmJUf8RaGehTpKRmNnyXKumy6A@mail.gmail.com>
References: <1309324042-22943-1-git-send-email-djkurtz@chromium.org>
 <1309324042-22943-3-git-send-email-djkurtz@chromium.org> <4E134D0C.7060500@canonical.com>
 <CAGS+omA0=wperMBA+kXVtJW1HJg=1CuW+HnS5kN_cDCBSphT=A@mail.gmail.com> <4E1398E1.60306@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:32508 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752093Ab1GEXPd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jul 2011 19:15:33 -0400
Received: from kpbe20.cbf.corp.google.com (kpbe20.cbf.corp.google.com [172.25.105.84])
	by smtp-out.google.com with ESMTP id p65NFV8I012925
	for <linux-input@vger.kernel.org>; Tue, 5 Jul 2011 16:15:31 -0700
Received: from ywo7 (ywo7.prod.google.com [10.192.15.7])
	by kpbe20.cbf.corp.google.com with ESMTP id p65NFTZB030524
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Tue, 5 Jul 2011 16:15:30 -0700
Received: by ywo7 with SMTP id 7so3645458ywo.39
        for <linux-input@vger.kernel.org>; Tue, 05 Jul 2011 16:15:29 -0700 (PDT)
In-Reply-To: <4E1398E1.60306@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: dmitry.torokhov@gmail.com, rydberg@euromail.se, rubini@cvml.unipv.it, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, derek.foreman@collabora.co.uk, daniel.stone@collabora.co.uk, olofj@chromium.org

On Wed, Jul 6, 2011 at 7:06 AM, Chase Douglas
<chase.douglas@canonical.com> wrote:
> On 07/05/2011 03:50 PM, Daniel Kurtz wrote:
>> On Wed, Jul 6, 2011 at 1:42 AM, Chase Douglas
>> <chase.douglas@canonical.com> wrote:
>>>
>>> On 06/28/2011 10:07 PM, djkurtz@chromium.org wrote:
>>>> From: Daniel Kurtz <djkurtz@chromium.org>
>>>>
>>>> Synaptics touchpads report increasing y from bottom to top.
>>>> This is inverted from normal userspace "top of screen is 0" coordi=
nates.
>>>> Thus, the kernel driver reports inverted y coordinates to userspac=
e.
>>>>
>>>> In some cases, however, y =3D 0 is sent by the touchpad.
>>>> In these cases, the kernel driver should not invert, and just repo=
rt 0.
>>>
>>> Under what cases is y sent as 0, and why do we want to report it as=
 0 to
>>> userspace?
>>
>> I know of two such cases for the image sensor:
>> =A0 (1) When all fingers, save the first finger are removed, an AGM
>> packet with (x=3D0, y=3D0, z=3D0) is sent.
>> =A0 (2) When all fingers are removed, an SGM packet with (x=3D0, y=3D=
0, z=3D0) is sent.
>>
>> After uploading this patch set, I played with the profile sensor
>> again, and I also saw it sometimes sends y=3D1 packets. =A0I don't k=
now
>> what those are.
>>
>> This is mostly useful for debugging the kernel driver.
>> When observing the raw position values, the special 0 (and 1?) cases
>> are more obvious when not inverted.
>> I think I am misleading in my commit message. =A0I don't believe the=
se
>> are actually ever passed through to userspace.
>
> If they are set, then they are passed through evdev, unless I'm missi=
ng
> something... Given the cases listed above, it seems like we should be
> special casing these scenarios. Maybe that means dropping the event o=
r
> handling finger count transitions or something else.
>
> I'm happy with the patch as a cleanup of y inversion, but I don't see
> the utility of passing y =3D 0 through. With all the debugging techni=
ques
> we have (printk, systemtap, perf, ftrace, etc.), I don't think we nee=
d
> this functionality, and it might lead a code reviewer to scratch thei=
r
> head wondering what the point was :).

I meant if you were to printk y, it is much more obvious to see y=3D0
than y=3D5321 or something like that.
I don't think this reaches userspace because y=3D0 packets are usually
filtered out since z and x are also 0.

I guess this is the point, actually, that wasn't clear to me in
Henrik's astute observation:
We should do the conversion when reporting to userspace.  Thus, only
do the conversion for packets that aren't already masked!

I will refactor to an inline function, but put the conversion back in
the input_report_abs() calls.

-Dan

>
> Thanks!
>
> -- Chase
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
