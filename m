From: Lauri Kasanen <cand@gmx.com>
Subject: Re: MOUSE_PS2_VMMOUSE and input/mice
Date: Sat, 16 Jan 2016 21:10:11 +0200
Message-ID: <20160116211011.6aeff246.cand@gmx.com>
References: <20160115123928.d06e1fed.cand@gmx.com>
	<5698D343.3000606@vmware.com>
	<20160115132312.654ad5aa.cand@gmx.com>
	<56991418.1070701@vmware.com>
	<20160115175040.GA5664@dtor-ws>
	<20160116105735.5c659e05.cand@gmx.com>
	<20160116183008.GB9203@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:60336 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752425AbcAPTKU (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 16 Jan 2016 14:10:20 -0500
In-Reply-To: <20160116183008.GB9203@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Thomas Hellstrom <thellstrom@vmware.com>, linux-input@vger.kernel.org

On Sat, 16 Jan 2016 10:30:08 -0800
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> > > Although we will make vmmouse work with /dev/input/mice, could you
> > > please tell TinyCore that 90s are calling and they want their mouse
> > > technology back? And tell them to switch to switch to evdev X driver.
> > 
> > TinyCore sends their regards, and tells they will consider evdev when
> > Xorg + evdev + paraphelia can total less than 650kb.
> 
> I do not think you are doing your users any favors by limiting them to
> PS/2 emulation. For desktops, unless they only use basic mice mousedev
> emulation does not work well for neither touchpads, nor tablets, nor
> touchscreens.  And for appliances you do not need mouse at all. Maybe if
> you targeting kiosks with limited UI it will work for a bit. I wonder
> how long Xorg will be keeping lights on for mouse_drv.
> 
> I am tempted to deprecate mousedev and maybe joydev as well. They were
> supposed to fill the gap between then current applications and kernel,
> but that was 10+ years ago.

Hi,

It's a choice we leave up to the users. The majority uses normal
desktops with normal mice, touch screens and tablets tend to be a
rarity in our userbase. So we can serve the majority without the bloat
of Xorg, but those who need it can install it.

That's why I was asking for a runtime way - the default should work,
but so should VMWare's nicer mouse integration when Xorg is installed.
That concern was resolved with the statement the older support is not
being considered for removal. The original issue will be solved by
disabling VMMOUSE in our kernel.

- Lauri
