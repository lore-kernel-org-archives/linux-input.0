From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: tca8418 - Add support for shared interrupt
Date: Thu, 8 Nov 2012 08:45:55 -0800
Message-ID: <20121108164555.GB8877@core.coreip.homeip.net>
References: <1352132052-19771-1-git-send-email-alban.bedel@avionic-design.de>
 <20121105185806.GA18149@core.coreip.homeip.net>
 <20121106173430.2d959c10@avionic-0020.adnet.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:41538 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323Ab2KHQp7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Nov 2012 11:45:59 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so2107854pad.19
        for <linux-input@vger.kernel.org>; Thu, 08 Nov 2012 08:45:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20121106173430.2d959c10@avionic-0020.adnet.avionic-design.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alban Bedel <alban.bedel@avionic-design.de>
Cc: linux-input@vger.kernel.org

On Tue, Nov 06, 2012 at 05:34:30PM +0100, Alban Bedel wrote:
> On Mon, 5 Nov 2012 10:58:06 -0800
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > I do not think that using ONESHOT IRQ handlers in shared interrupt
> > configuration is a good idea as that interrupt will stay masked until
> > the keypad is done processing it, which may take some time.
> 
> I don't really see what the problem is, shared ONESHOT handlers are
> supported by the IRQ framework. The IRQ line of this device is an open
> drain and so can be shared, and is shared on the hardware I'm using!
> 
> I agree that the interrupt masking time might rise a little if many
> devices share the same line, but that's the normal drawback of shared
> interrupts.

OK, fair enough.

-- 
Dmitry
