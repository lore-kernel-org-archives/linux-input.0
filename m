From: Alexander Lam <lambchop468@gmail.com>
Subject: Re: Bug: Short reset of ps/2 mouse causes Synaptics touchpad
	misdetection
Date: Sat, 10 Apr 2010 16:00:43 -0400
Message-ID: <o2wdfb03c971004101300j4c6fd2fdh66b842fecdb14921@mail.gmail.com>
References: <s2ydfb03c971004040858p6872d1f4p3fc0f8dac1fbd2e6@mail.gmail.com>
	<1270402517.3614.7.camel@lovely>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f217.google.com ([209.85.217.217]:56232 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284Ab0DJUBF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 10 Apr 2010 16:01:05 -0400
Received: by gxk9 with SMTP id 9so2609048gxk.8
        for <linux-input@vger.kernel.org>; Sat, 10 Apr 2010 13:01:03 -0700 (PDT)
In-Reply-To: <1270402517.3614.7.camel@lovely>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

On Sun, Apr 4, 2010 at 1:35 PM, Christoph Fritz
<chf.fritz@googlemail.com> wrote:
>>
>> Bug: Short reset of ps/2 mouse causes Synaptics touchpad misdetection
>>
>
> commit 4a299bf591bc5bef3bde8316e603b9eaec5a7696
> commit 9230ccb1071d2d7e4ecb6314e67203b9f7f08140
> commit 3e6e15a862a0bc20128497bbdc54254cdec21835
>
> does it work with all these applied?
>
>
>
>
>

I've been trying to reproduce the bug with a stock unpatched kernel,
then testing with
those commits to compare, but I've been unable to reproduce the
original behavior.

This laptop is very wierd. Sometimes complete removal of power makes
stuff like this
go away, so I guess it was transient.

In other news, I also have been running 2.6.34-rc3 and I haven't seen
any of these issues,
so I guess you could consider this issue solved.

I'll close the bug.


Thanks,
Alexander Lam
