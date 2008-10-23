From: Greg KH <greg@kroah.com>
Subject: Re: [stable] [PATCH] Revert "HID: Invert HWHEEL mappings for some
	Logitech mice"
Date: Thu, 23 Oct 2008 13:38:49 -0700
Message-ID: <20081023203849.GB17600@kroah.com>
References: <Pine.LNX.4.64.0806181802480.23194@twin.jikos.cz> <1224219974-4216-1-git-send-email-dbn.lists@gmail.com> <alpine.LNX.1.10.0810171125090.28536@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:51414 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752619AbYJWUvS (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Oct 2008 16:51:18 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.10.0810171125090.28536@jikos.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dan Nicholson <dbn.lists@gmail.com>, stable@kernel.org, Ander Conselvan de Oliveira <ander@c3sl.ufpr.br>, linux-input@vger.kernel.org

On Fri, Oct 17, 2008 at 11:26:37AM +0200, Jiri Kosina wrote:
> On Thu, 16 Oct 2008, Dan Nicholson wrote:
> 
> > This reverts commit 740f370dc61dc478d891d7d47660bb3ae39ddb4f.
> > 
> > It turned out to be correct in the first place: a positive value should
> > be sent when the wheel is moved to the right, and a negative value when
> > moved to the left. This is the behavior expected by the Xorg evdev
> > driver. I must have had a remapping somewhere else in my system when
> > originally testing this. Testing on another system shows that the
> > unpatched kernel is correct.

Jiri, should we apply this to the 2.6.27-stable tree now?  I don't see
this change in Linus's tree yet, but I figured as the quirk stuff was
massivly changed, I might have missed it.

thanks,

greg k-h
