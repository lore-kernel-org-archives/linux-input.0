From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [stable] [PATCH] Revert "HID: Invert HWHEEL mappings for some
 Logitech mice"
Date: Fri, 24 Oct 2008 11:45:22 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0810241144320.27479@jikos.suse.cz>
References: <Pine.LNX.4.64.0806181802480.23194@twin.jikos.cz> <1224219974-4216-1-git-send-email-dbn.lists@gmail.com> <alpine.LNX.1.10.0810171125090.28536@jikos.suse.cz> <20081023203849.GB17600@kroah.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:49785 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750808AbYJXJpY (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Oct 2008 05:45:24 -0400
In-Reply-To: <20081023203849.GB17600@kroah.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Dan Nicholson <dbn.lists@gmail.com>, stable@kernel.org, Ander Conselvan de Oliveira <ander@c3sl.ufpr.br>, linux-input@vger.kernel.org

On Thu, 23 Oct 2008, Greg KH wrote:

> > > This reverts commit 740f370dc61dc478d891d7d47660bb3ae39ddb4f.
> > > It turned out to be correct in the first place: a positive value should
> > > be sent when the wheel is moved to the right, and a negative value when
> > > moved to the left. This is the behavior expected by the Xorg evdev
> > > driver. I must have had a remapping somewhere else in my system when
> > > originally testing this. Testing on another system shows that the
> > > unpatched kernel is correct.
> Jiri, should we apply this to the 2.6.27-stable tree now?  I don't see
> this change in Linus's tree yet, but I figured as the quirk stuff was
> massivly changed, I might have missed it.

Hi Greg,

is is sitting in my queue to be pushed to Linus, it didn't happen yet, I 
am still sorting a last few things out. I expect to push it today or 
during the weekend.

Thanks,

-- 
Jiri Kosina
SUSE Labs
