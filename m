From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH] input: ALPS - Add signature for HP Pavilion dm3 laptops
Date: Tue, 20 Apr 2010 06:01:14 -0700
Message-ID: <l2s40ec3ea41004200601jd2772157ye1210e3d4764b199@mail.gmail.com>
References: <1269712311-8041-1-git-send-email-chase.douglas@canonical.com>
	 <20100327191102.GA14548@core.coreip.homeip.net>
	 <t2u40ec3ea41004191336u64db7e79t455920a56bcd856c@mail.gmail.com>
	 <20100420072903.GA32108@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:39394 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754393Ab0DTNIU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Apr 2010 09:08:20 -0400
Received: by pva18 with SMTP id 18so3842330pva.19
        for <linux-input@vger.kernel.org>; Tue, 20 Apr 2010 06:08:19 -0700 (PDT)
In-Reply-To: <20100420072903.GA32108@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Tue, Apr 20, 2010 at 12:29 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Mon, Apr 19, 2010 at 01:36:33PM -0700, Chase Douglas wrote:
>> After more testing, some users found that they no longer could use the
>> vertical edge scroll of their touchpad. I assumed everything was
>> working correctly because I had read a response to another user on
>> this list that if you add a new ID, things work, and you don't see any
>> protocol error messages in dmesg, then things should be correct. The
>> testers reported no errors, so I assumed the problem was in the X
>> synaptics driver. However, after receiving some event reports from a
>> tester, it may be that the normal ps2 driver is still sending events,
>> while the alps/synaptics kernel driver is not sending any. Do you have
>> any insight on what might be going on?
>>
>
> That means that our standard magic knock did not work. It seems that
> newer version of ALPS are using a different "magic knock" sequence for
> them.

How can we find out what the new knock sequence is?

-- Chase
