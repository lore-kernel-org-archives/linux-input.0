From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: serio - re-add thaw (and add freeze)
Date: Wed, 3 Feb 2010 11:11:12 -0800
Message-ID: <20100203191112.GC30600@core.coreip.homeip.net>
References: <4B69C7AA.7000904@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f189.google.com ([209.85.222.189]:41027 "EHLO
	mail-pz0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756896Ab0BCTL1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Feb 2010 14:11:27 -0500
Content-Disposition: inline
In-Reply-To: <4B69C7AA.7000904@tuffmail.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: linux-input@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>

On Wed, Feb 03, 2010 at 06:59:54PM +0000, Alan Jenkins wrote:
> 633aae2 "Input: i8042 - switch to using dev_pm_ops"
> removed handling for PMSG_THAW, causing obscure breakage.
> 
> It can break if you press keys during hibernation,
> which causes subsequent keypresses to be lost -
> so you can't cancel s2disk by pressing backspace -
> and then just before system poweroff you get
> "psmouse.c: Failed to deactivate mouse".
> 
> So let's add the thaw handler back.
> 
> Also set the freeze handler.  It looks like PMSG_FREEZE
> didn't do anything in the past, but I think that must
> have been an oversight.

We do not need to do anything special at freeze time that is why there
wasn't freeze handler. And so thaw should be pretty much noop as well.

What supports canceling s2disk by backspace? I need more data to figure
out what is going on. At the moment input should be fully-functional
until poweroff.

-- 
Dmitry
