From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: input: mt: Software finger tracking in the kernel?
Date: Sun, 21 Mar 2010 00:57:20 +0530
Message-ID: <5d5443651003201227w27314533w6be3cdd8fb9bf5aa@mail.gmail.com>
References: <4BA358DB.20708@enmesh.se>
	 <167e8a331003192151o593809bbhcda68e284185dd4a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f179.google.com ([209.85.221.179]:52449 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751457Ab0CTT1W convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 20 Mar 2010 15:27:22 -0400
In-Reply-To: <167e8a331003192151o593809bbhcda68e284185dd4a@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Henrik Rydberg <rydberg@enmesh.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Ping,

On Sat, Mar 20, 2010 at 10:21 AM, Ping Cheng <pinglinux@gmail.com> wrot=
e:
> On Fri, Mar 19, 2010 at 3:58 AM, Henrik Rydberg <rydberg@enmesh.se> w=
rote:
>> Hi Dmitry,
>>
>> there is an ongoing discussion about adding multitouch to X
>> (http://lists.x.org/archives/xorg-devel/2010-March/006206.html), whi=
ch is
>> beginning to take on more solid form.
>>
>> One of the suggestions emerging from that discussion is to add the s=
oftware
>> finger tracking to the kernel. Back in summer 2009 when I thought ab=
out this, I
>> disregarded it as being too experimental. I have since then reconsid=
ered,
>> starting to think it really is the right place.
>>
>> The MT protocol allows applications to take advantage of multi-conta=
ct hardware,
>> but leaves the problems of finger tracking and filtering to the user=
=2E Arguably,
>> no application can make good use of MT without these, so the problem=
 is pushed
>> forward, in this case to evdev or equivalent.
>>
>> The knowledge of signal-to-noise ratios and prior input states resid=
es in the
>> kernel. Because of this, the finger matching and filtering would nat=
urally
>> reside within the kernel.
>>
>> So, if there were to appear patches to include matching in the input=
 core, would
>> you consider them? :-)
>
> I support the idea to add a tracking ID and a filter to _MT_. =A0I'd
> also like to make the filtering method more "device driver developer"
> friendly, i.e., give the developer the option to turn the filter on o=
r
> off. =A0If you plan to use a constant for the filtering method, pleas=
e
> allow the developer to choose that constant too.
>
> Another attribute associated with _MT_ is the pressure/capacity.
> Report this value would offer more room for MT-aware application to
> add new features.

We have ABS_MT_PRESSURE added recently. I hope you are asking the same.


--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
