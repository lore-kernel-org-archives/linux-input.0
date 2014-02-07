From: Tommy Will <tommywill2011@gmail.com>
Subject: Re: PROBLEM: [Dell LATITUDE E7440] ALPS touchpad events are not
 routed into /dev/input/mice and /dev/input/mouseX
Date: Fri, 7 Feb 2014 16:18:00 +0800
Message-ID: <CA+F6ckO02oxrgx3-9Fhu3XQFX_8WrUFL5_LTjA8-mUpZMy7QaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:41686 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801AbaBGISC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Feb 2014 03:18:02 -0500
Received: by mail-lb0-f175.google.com with SMTP id p9so2339691lbv.6
        for <linux-input@vger.kernel.org>; Fri, 07 Feb 2014 00:18:00 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: qehgt0@gmail.com
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Vasily,

Thanks for your mail & information. We would start the investigation
and give you feedback later.
Please wait.

> The issues occurs on every kernel after
> 1302bac33d9e88cd43e482191a806998f3ed43cc commit. Before the commit, this touchpad device was detected as PS/2 mouse and "cat /dev/input/mice" shows data when the touchpad is used.
> After the commit, there are no events from the touchpad in /dev/input/mice or /dev/input/mouseX files anymore.
>
> According to drivers/input/mouse/alps.c source file, all devices with signatures "ec[0] == 0x88 && ec[1] == 0x08" are treated as "Rushmore touchpads". This touchpad has E7 signature of "73-03-0A" and EC signature of "88-08-22", and it looks like that V5 protocol (not
> "Rushmore") should be used here. If V5 protocol is forced to use for this device then everything works fine.
>
> The patch is trivial, but I'm not sure how to properly separate "Rushmore" and "V5" devices. Are there any datasheets or experts to help me with it?
>

I checked the E7 & EC information and think it should be a Rushmore device.
Could you please let me know after you use V5 protocol, if touchpad
still be recognized as "AlpsPS/2 ALPS DualPoint TouchPad" or returns
to "PS/2 Generic Mouse" ?

Thanks
-- 
Best Regards,
Tommy
