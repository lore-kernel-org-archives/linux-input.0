From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Fun with sony motion controllers: navigation controller
Date: Mon, 16 Mar 2015 13:55:39 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1503161354310.25438@pobox.suse.cz>
References: <20150314191917.GA3680@amd>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:52159 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754060AbbCPMzm (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Mar 2015 08:55:42 -0400
In-Reply-To: <20150314191917.GA3680@amd>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: vojtech@suse.cz, mike-@cinci.rr.com, jslaby@suse.cz, dave@thedillows.org, colin.leitner@gmail.com, frank.praznik@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

On Sat, 14 Mar 2015, Pavel Machek wrote:

> Hi!
> 
> After oopsing kernel with ps/3 peripherals, I decided to play some
> more.
> 
> First "sony motion controller" (part of ps/3 move without the
> led). Good news is that it no longer oopses. After pressing the PS
> button, it seems to work, but it produces endless stream of events in
> evtest:
> 
> Event: time 1426360519.967818, type 3 (EV_ABS), code 0 (ABS_X), value 131
> Event: time 1426360519.967818, type 3 (EV_ABS), code 1 (ABS_Y), value 129
> Event: time 1426360519.967818, type 3 (EV_ABS), code 59 (ABS_MT_DISTANCE), value 513
> Event: time 1426360519.967818, type 3 (EV_ABS), code 60 (ABS_MT_TOOL_X), value 513
> 
> Should it really produce multitouch events?

Some sony devices are producing multitouch events. You unfortunately 
didn't send us the VID/PID of the device you are playing with.

Frank, I guess you'll handle this report once Pavel provides the necessary 
data? Thanks.

-- 
Jiri Kosina
SUSE Labs
