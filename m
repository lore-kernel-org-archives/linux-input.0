From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Logitech MX5000 extra keys
Date: Sat, 7 Feb 2009 02:12:56 +0100 (CET)
Message-ID: <alpine.LRH.1.10.0902070209160.22097@twin.jikos.cz>
References: <1233948279.8950.75.camel@cookie.hadess.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from twin.jikos.cz ([213.151.79.26]:41040 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751880AbZBGBNB (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 6 Feb 2009 20:13:01 -0500
In-Reply-To: <1233948279.8950.75.camel@cookie.hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org

On Fri, 6 Feb 2009, Bastien Nocera wrote:

> Some keys aren't reported at all through the input layer, but there is 
> code in the mx5000-tools[2] to make those keys work through hiddev.
[ ... ]
> I was wondering what the best course of action would be to make this
> code work out-of-the-box. Would it be better to write a HAL addon, and
> do all this work in user-space, or would it be more useful to have
> directly in the kernel?
> Obviously, if the latter, I'd appreciate a bit of guidance on where I
> should add the code.

Hi Bastien,

the HAL people are trying to put as much possible of the mappings into the 
userspace HAL code, see [1].

If you prefer doing the mappings correctly already in-kernel for this 
particular keyboard, please see Logitech-specific HID driver in 
drivers/hid/hid-lg.c; we already handle various kinds of Logitech devices 
there, and adding a new one is pretty straightforward (maybe the code can 
even be shared with a different model).

[1] http://people.freedesktop.org/~hughsient/quirk/quirk-keymap-index.html

-- 
Jiri Kosina
SUSE Labs

