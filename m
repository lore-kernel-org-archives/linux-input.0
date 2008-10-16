From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: question on LEDs on keyboards
Date: Thu, 16 Oct 2008 02:06:37 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0810160205530.26779@jikos.suse.cz>
References: <200810141521.00225.oliver@neukum.org> <alpine.LNX.1.10.0810141530220.26779@jikos.suse.cz> <200810142014.00517.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:50727 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752828AbYJPAGj (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Oct 2008 20:06:39 -0400
In-Reply-To: <200810142014.00517.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-input@vger.kernel.org

On Tue, 14 Oct 2008, Oliver Neukum wrote:

> > > I found an error in the hid autosuspend patches. Keyboards can have more 
> > > than one LED. Is there a way to query the HID layer about active LEDs?
> > you can either get the information from the underlying input device, or 
> > you can use hidinput_find_field() to find the fields of EV_LED type, and 
> > obtain the value from the offset that this function gives you.
> What is the prefered way of doing that? There seems to be no hid_get_field().

Yes, there is no such function yet. If you need it in autosuspend patch 
and implement it, I'll happily merge it.

Thanks,

-- 
Jiri Kosina
SUSE Labs
