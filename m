From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Researching An Experimental Touchscreen Driver
Date: Sat, 27 Nov 2010 21:55:08 -0800
Message-ID: <20101128055507.GA14499@core.coreip.homeip.net>
References: <1290614820.3294.37.camel@bathysphere>
 <20101127235133.GB29981@core.coreip.homeip.net>
 <1290911010.1932.9.camel@bathysphere>
 <20101128030729.GA4795@core.coreip.homeip.net>
 <1290917571.1932.15.camel@bathysphere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46274 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947Ab0K1FzP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 28 Nov 2010 00:55:15 -0500
Received: by iwn5 with SMTP id 5so549270iwn.19
        for <linux-input@vger.kernel.org>; Sat, 27 Nov 2010 21:55:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1290917571.1932.15.camel@bathysphere>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeremy Moles <jeremy@emperorlinux.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

On Sat, Nov 27, 2010 at 11:12:51PM -0500, Jeremy Moles wrote:
> 
> WHOA! Now we're cooking! My probe succeeds and now my
> event/input_mapping/input_mapped functions all get called!
> 
> When driver developers are writing HID glue drivers like this, how is it
> you generally determine the contents of your drv_data structure? Via
> hardware specs or is there some way to poke at the device via USB and
> have it tell you? Perhaps this question is a bit TOO out of line, as I'm
> sure that information is available in the standard USB HID
> information...
> 

If you are talking about data structures that are accessed via
hig_get_drvdata() and hid_set_drvdata() then it is entirely up to driver
writer to define them. Basically whatever state you need to be able to
handle the device.

-- 
Dmitry
