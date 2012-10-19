From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Multiple clients reading from /dev/input/eventX
Date: Fri, 19 Oct 2012 15:32:11 -0700
Message-ID: <20121019223210.GA10915@core.coreip.homeip.net>
References: <e6193392fbe49d7236b39e3b17b8fa81.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50300 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625Ab2JSWcP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Oct 2012 18:32:15 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so742352pbb.19
        for <linux-input@vger.kernel.org>; Fri, 19 Oct 2012 15:32:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <e6193392fbe49d7236b39e3b17b8fa81.squirrel@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: linux-input@vger.kernel.org

Hi SImon,

On Fri, Oct 19, 2012 at 11:49:29AM -0400, simon@mungewell.org wrote:
> Hi all,
> I'm trying to track down a problem with SDL missing events from a gaming
> wheel. It looks like it's not seeing a 'section' of events and this
> results in an axis from the wheel/joystick being stuck on.
> 
> If I simultaneously use evtest to monitor the same /dev/input/eventX I see
> all the events in evtest, but not in SDL.
> 
> I suspect that some scheduling (or other business) is causing SDL not to
> check the file handle, and as a result the input system is
> dropping/resyncing the interface.
> 
> Can anyone here confirm the behaviour under the situation that one client
> is busy? What is the maximum time it can be 'away' or what is the size of
> the inline buffer?

Every user of event device has a buffer that can hold up at least 64
input events and is completely independent from other users. Newer
kernels generate EV_SYN/SYN_DROPPED event to indicate that user was too
slow reading data and there was buffer overrun.

Hope this helps.

-- 
Dmitry
