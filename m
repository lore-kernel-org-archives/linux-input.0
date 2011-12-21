From: Daniel Kurtz <djkurtz@google.com>
Subject: Re: [RFC][PATCH] Input: Use monotonic time for event time stamps.
Date: Wed, 21 Dec 2011 11:23:02 +0800
Message-ID: <CAGS+omAoSRzcQf0BGYJW8fC_cxx+b+9Hs5ggqLbQCBjSVL9=4w@mail.gmail.com>
References: <1324429303.30527.92.camel@work-vm> <4EF1395E.405@cn.fujitsu.com>
 <CAGS+omABqM84X=uoY1bGnAD-9DSR6qjrod8Teksm3qeiG2YGew@mail.gmail.com> <1324434574.30527.102.camel@work-vm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57441 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067Ab1LUDXX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Dec 2011 22:23:23 -0500
Received: by iaeh11 with SMTP id h11so11195642iae.19
        for <linux-input@vger.kernel.org>; Tue, 20 Dec 2011 19:23:23 -0800 (PST)
In-Reply-To: <1324434574.30527.102.camel@work-vm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: john stultz <johnstul@us.ibm.com>
Cc: gaowanlong@cn.fujitsu.com, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>

On Wed, Dec 21, 2011 at 10:29 AM, john stultz <johnstul@us.ibm.com> wro=
te:
> On Wed, 2011-12-21 at 10:11 +0800, Daniel Kurtz wrote:
>> Maybe you will have more luck this time. =A0You can read the previou=
s
>> thread on this exact topic, here:
>> https://lkml.org/lkml/2011/10/3/37
>>
>> The previous attempt got bogged down when people wanted more data on
>> use cases and how this patch would promote world peace. =A0I strongl=
y
>> support the concept, but we found other ways to address our major
>> concern at the time, so didn't invest more effort to get that patch
>> accepted.
>
> Also, are you able to discuss the alternative way you addressed the
> issue?

By ignoring big / backwards time jumps in time in userspace, and just
ignoring smaller, forward adjustments.  Admittedly inelegant, but got
us past a crisis.

>
> thanks
> -john
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
