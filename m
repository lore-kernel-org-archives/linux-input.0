From: Bastien Nocera <hadess@hadess.net>
Subject: Re: Keycode for "main hardware button" on slate?
Date: Tue, 15 Mar 2011 18:12:02 +0000
Message-ID: <1300212723.2088.16.camel@novo.hadess.net>
References: <1299520075.18332.146.camel@novo.hadess.net>
	 <20110310080043.GA9985@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:51030 "EHLO
	relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758100Ab1COSMI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Mar 2011 14:12:08 -0400
In-Reply-To: <20110310080043.GA9985@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Thu, 2011-03-10 at 00:00 -0800, Dmitry Torokhov wrote:
> On Mon, Mar 07, 2011 at 05:47:54PM +0000, Bastien Nocera wrote:
> > Heya,
> > 
> > I've installed Fedora 15 onto a WeTab slate, and it has 2 "hardware"
> > buttons. One is power (already used to come in and out of suspend), and
> > another one that I'd like to use to get the interface running on it to
> > go back to its "home" screen.
> > 
> > Any ideas what KEY_* I should use for this functionality?
> > 
> 
> Hmm, I am not sure. This will probably device specific, but I guess you
> could use KEY_COMPUTER or KEY_HOMEPAGE for this. Not ideal, but should
> do.

The problem is that I'd like that particular key to be used on devices,
which means 1) adding a XKeySym for that key 2) adding it to the default
keymaps, and 3) adding code in gnome-shell to handle that key.

KEY_COMPUTER is used to get to the "Computer" part of the file manager,
and KEY_HOMEPAGE to the home page in a web browser.

I think I'll go with Antonio's KEY_FRONT suggestion instead.

Cheers

