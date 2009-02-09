From: Bastien Nocera <hadess@hadess.net>
Subject: Re: Logitech MX5000 extra keys
Date: Mon, 09 Feb 2009 11:31:55 +0000
Message-ID: <1234179115.8950.3991.camel@cookie.hadess.net>
References: <1233948279.8950.75.camel@cookie.hadess.net>
	 <alpine.LRH.1.10.0902070209160.22097@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:37972 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751534AbZBILcN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 9 Feb 2009 06:32:13 -0500
In-Reply-To: <alpine.LRH.1.10.0902070209160.22097@twin.jikos.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

On Sat, 2009-02-07 at 02:12 +0100, Jiri Kosina wrote:
> On Fri, 6 Feb 2009, Bastien Nocera wrote:
> 
> > Some keys aren't reported at all through the input layer, but there is 
> > code in the mx5000-tools[2] to make those keys work through hiddev.
> [ ... ]
> > I was wondering what the best course of action would be to make this
> > code work out-of-the-box. Would it be better to write a HAL addon, and
> > do all this work in user-space, or would it be more useful to have
> > directly in the kernel?
> > Obviously, if the latter, I'd appreciate a bit of guidance on where I
> > should add the code.
> 
> Hi Bastien,
> 
> the HAL people are trying to put as much possible of the mappings into the 
> userspace HAL code, see [1].

Problem is that it's not just a mapping problem, as the keys don't get
out of the kernel at all. The code in hid-lg.c looks more like what's
required. Not sure whether the magic is the same to enable the extra
keys on this keyboard.

> If you prefer doing the mappings correctly already in-kernel for this 
> particular keyboard, please see Logitech-specific HID driver in 
> drivers/hid/hid-lg.c; we already handle various kinds of Logitech devices 
> there, and adding a new one is pretty straightforward (maybe the code can 
> even be shared with a different model).

I'll have to get my kernel groove back on and test this.

Cheers

