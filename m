From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: proposal on runtime power management in hid
Date: Fri, 31 Oct 2008 00:17:38 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0810310015250.31273@jikos.suse.cz>
References: <200810301704.01005.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:49562 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755410AbYJ3XRj (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 30 Oct 2008 19:17:39 -0400
In-Reply-To: <200810301704.01005.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Brownell <david-b@pacbell.net>, Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@sisk.pl>, Jiri Slaby <jslaby@suse.cz>, linux-pm@vger.kernel.org

On Thu, 30 Oct 2008, Oliver Neukum wrote:

> I am looking at runtime power management for usb hid devices. There's a 
> problem with hidraw. As we have no idea, what goes on between a device 
> and users of hidraw, it seems to me that such a device should not be 
> subject to runtime power management without the user's explicit 
> agreement. But that would be only a kludge. Therefore this is my first 
> draft of an API to cleanly allow this.

Hi Oliver,

isn't this just a little bit way too complex?

I think the simple and working solution would be never suspedning devices 
that have interface open through hidraw, unless user explicitly allows 
this through respective power/autosuspend setting in sysfs (which will by 
default be set to 'off' for HID devices anyway, right?).

Thanks for looking into this.

-- 
Jiri Kosina
SUSE Labs
