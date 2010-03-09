From: Michael Poole <mdpoole@troilus.org>
Subject: Re: [PATCH 1/1] hid-magicmouse: Emulate horizontal scrolling.
Date: Tue, 09 Mar 2010 06:40:26 -0500
Message-ID: <87mxyh205x.fsf@troilus.org>
References: <8763562u0n.fsf@troilus.org> <871vfu2tvh.fsf@troilus.org>
	<20100309075010.GE17288@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:60324 "HELO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752854Ab0CILk3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 9 Mar 2010 06:40:29 -0500
Received: by mail-qy0-f199.google.com with SMTP id 37so4964968qyk.20
        for <linux-input@vger.kernel.org>; Tue, 09 Mar 2010 03:40:29 -0800 (PST)
In-Reply-To: <20100309075010.GE17288@core.coreip.homeip.net> (Dmitry
	Torokhov's message of "Mon, 8 Mar 2010 23:50:11 -0800")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <tissoire@tls.cena.fr>, Stephane Chatty <chatty@enac.fr>

Dmitry Torokhov writes:

> On Mon, Mar 08, 2010 at 07:58:42PM -0500, Michael Poole wrote:
>> From 92872d16dfc6f2c037124644f30f807d30b6557c Mon Sep 17 00:00:00 2001
>> From: Michael Poole <mdpoole@troilus.org>
>> Date: Mon, 8 Mar 2010 19:10:13 -0500
>> Subject: [PATCH 1/1] hid-magicmouse: Emulate horizontal scrolling.
>> 
>> Also publish a parameter to control the emulated scroll
>> acceleration rates.
>> 
>
> FWIW I am still inconvinced that complex gesture emulation should be
> done in kernel drievr.
>
> Thanks.

I don't think that belongs in the kernel, either.  Scroll wheels don't
seem like complex gestures to me, although this is more marginal than
vertical scroll.

Michael
