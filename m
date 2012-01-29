From: Maurus Cuelenaere <mcuelenaere@gmail.com>
Subject: Re: [RFC] Microsoft Touch Mouse driver [was: Re: your mail]
Date: Sun, 29 Jan 2012 22:19:35 +0100
Message-ID: <4F25B7E7.9010002@gmail.com>
References: <BROWNM3h3vLgAusVxON00000cfa@brown.emailprod.vodafone.se> <20120125132612.GA3890@polaris.bitmath.org> <4F200D14.80702@gmail.com> <20120125150035.GA4222@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:38114 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752971Ab2A2VTi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 29 Jan 2012 16:19:38 -0500
Received: by wics10 with SMTP id s10so2898011wic.19
        for <linux-input@vger.kernel.org>; Sun, 29 Jan 2012 13:19:37 -0800 (PST)
In-Reply-To: <20120125150035.GA4222@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org

Op 25-01-12 16:00, Henrik Rydberg schreef:
>> In my first tests, I was doing readouts in userspace using hidraw,
>> which performed quite well.
>>
>> Bandwidth could be an issue, but I'd like to use the current APIs as
>> much as possible so I don't need to go modifying mtdev, X, ...
> Unless you do clustering, filtering and what not in-kernel, something
> will have to change for sure.
>
>>> One possible option could be to use the
>>> slots, but only send ABS_MT_TOUCH_MAJOR or ABS_MT_PRESSURE, nothing
>>> else. The device would (rightfully) not be recognized as MT since the
>>> position is missing, all data would be available for processing in
>>> userspace, and bandwidth would be minimized since there could only be
>>> so many changes coming in per millisecond.
>> So how does userspace then finds out where these pressure points are
>> located?
>> Or do you mean to just dump all data to user space (15 * 13 *
>> sizeof(ABS_MT_PRESSURE value) + overhead)?
> Having each pressure point represented by one slot id was the idea.
> Userspace would have to know how the points are mapped, of
> course. Still not overly happy about the general fit, though. Dmitry?

Ping.

Or do you want me to resend the original mails? It didn't seem to get 
through on the mailing list.

-- 
Maurus Cuelenaere

