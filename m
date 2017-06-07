From: Greg KH <greg@kroah.com>
Subject: Re: Two regressions on BYT/T ASUS T100TA 4.12-rc: #2 Keyboard no
 longer works
Date: Wed, 7 Jun 2017 18:07:44 +0200
Message-ID: <20170607160744.GA8435@kroah.com>
References: <20170607162730.48dfc370@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59243 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750831AbdFGQHt (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 7 Jun 2017 12:07:49 -0400
Content-Disposition: inline
In-Reply-To: <20170607162730.48dfc370@lxorguk.ukuu.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, torvalds@linux-foundation.org

On Wed, Jun 07, 2017 at 04:27:30PM +0100, Alan Cox wrote:
> Booting 4.12-rc gives you a machine where neither the keyboard or the
> mouse of the base-station work.
> 
> Other USB devices work - including plugging in an external USB keyboard
> and mouse.
> 
> Removing the basestation and replugging it has no effect.
> 
> The base station is seen in lsusb.

What is the "basestation"?  A USB hub?  Something else?

When you remove/add it, do you get kernel log messages about USB stuff
happening?

thanks,

greg k-h
