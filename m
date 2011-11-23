From: Sean Young <sean@mess.org>
Subject: Re: [PATCH v2] HID: Add support for pressure sensitive buttons
Date: Wed, 23 Nov 2011 10:39:02 +0000
Message-ID: <20111123103902.GA18828@pip.mess.org>
References: <1321393219-19394-1-git-send-email-sean@mess.org>
 <20111121095818.GA3568@pip.mess.org>
 <20111121133428.99064g5drrymryww@www.81.fi>
 <20111122114725.GA13107@pip.mess.org>
 <alpine.LNX.2.00.1111221817070.28728@pobox.suse.cz>
 <20111122175543.GA27773@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from pip.mess.org ([212.110.186.137]:34049 "EHLO pip.mess.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750884Ab1KWKjE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Nov 2011 05:39:04 -0500
Content-Disposition: inline
In-Reply-To: <20111122175543.GA27773@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Jussi Kivilinna <jussi.kivilinna@mbnet.fi>, linux-input@vger.kernel.org, simon@mungewell.org

On Tue, Nov 22, 2011 at 09:55:44AM -0800, Dmitry Torokhov wrote:
> On Tue, Nov 22, 2011 at 06:17:49PM +0100, Jiri Kosina wrote:
> > I'd like to at least get Dmitry's ack for the ff-memless change.
> 
> Actually I do not like it since it comingles unrelated parts: it is my
> understanding that pressure-sensitive buttons should be able to work
> ebven if user choses to disable force feedback support.

That's true. I do wonder why there is a separate config option for 
force feedback. It doesn't have a particularly large memory footprint.

> I also do not believe that the new attributes should reside with input
> devices instead of HID device itself since they conrol aspects of the
> work of real hardware, not input core abstraction.

Ok, I hadn't thought about it that way. Since these devices can up to 
four ports, we'll have controller_mode_port_{1,2,3,4} sysfs files, but I 
`guess there is no way around that.

Thank you for your review comments. I'll prepare a new patch.


Sean
