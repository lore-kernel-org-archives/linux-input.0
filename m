From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [RFC/PATCH] Revert "Input: wacom - add 0xE5 (MT device) support"
Date: Fri, 15 Jun 2012 12:08:56 -0700
Message-ID: <CAF8JNh+-5z7xDJrTTTE1GP5E-MD1AnWPJiC43aTbjNLGv8pbwA@mail.gmail.com>
References: <1335402856-11256-1-git-send-email-pinglinux@gmail.com>
	<20120614212335.GA4210@burratino>
	<CAF8JNh+dzJdoYC5AD+4HnOKmjumMR5acLCBFsi=ZAYtGZCja+w@mail.gmail.com>
	<20120615002705.GA7140@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:40652 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757323Ab2FOTI6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Jun 2012 15:08:58 -0400
Received: by lahd3 with SMTP id d3so2307098lah.19
        for <linux-input@vger.kernel.org>; Fri, 15 Jun 2012 12:08:57 -0700 (PDT)
In-Reply-To: <20120615002705.GA7140@burratino>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: dmitry.torokhov@gmail.com, =?ISO-8859-1?Q?Bj=F8rn_Mork?= <bjorn@mork.no>, linux-input@vger.kernel.org, Jason Gerecke <killertofu@gmail.com>, Chris Bagwell <chris@cnpbagwell.com>

On Thu, Jun 14, 2012 at 5:27 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Ping Cheng wrote:
>
>> I feel very bad about the issue. More testing should have been done
>> among us during the development. Since the patch was touched by more
>> than one people at linuxwacom.sf.net project, we most likely did not
>> test TPC2FG devices after last person's change.
>
> It's not really about testing. =A0A patch adding MTSCREEN support sim=
ply

Here is an update on my testing (for hardware, I have to test to be
sure). The result shows driver in upstream and 3.2.20 both work with
TPC2FG.

I downloaded, built and installed 3.5.-rc2 and 3.2.20 from kernel.org
without changing anything in the source. 3.5.-rc2 works all right. But
I can not boot 3.2.20 on my system (the error has nothing to do with
wacom driver). I didn't waste my time to fix 3.2.20 since we only care
about Wacom driver now. I copied wacom driver from 3.2.20 to 3.5.-rc2
source and built there. Replaced wacom.ko for 3.5.-rc2 with the driver
built from 3.2.20 code. It also works.

Then, I built the driver from input-wacom-0.13.0 for 3.5.-rc2.
Everything built fine, no warnings. But when I load the driver, it did
not find the device. I need more time to figure out the root cause. We
most likely need to introduce a new base version for later kernels.
2.6.38 is too old.

Since this issue doesn't affect upstream, let's bring the discussion
to linuxwacom.sf.net.

Thank you for the heads up and suggestions. We'll sure be careful in th=
e future.

Ping

> should not touch the non-MTSCREEN cases at all. =A0It can make perfec=
t
> sense to have some preparatory changes that affect other devices, as
> earlier patches in the same series.
>
> And I don't think it's your fault --- others on the linux-input@ list
> could have caught it.
>
> [...]
>> All in all, I am very sorry about the problem. But reverting back
>> isn't as easy as it sounds since we have many patches built on it no=
w.
>> Using your patch requires us the same amount of time to test on othe=
r
>> devices, which does not help us move forward.
>>
>> So, I propose we make a patch that fixes the issue upstream.
>
> Yeah, that works for me. =A0But please be more careful in the future.
>
> Thanks,
> Jonathan
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
