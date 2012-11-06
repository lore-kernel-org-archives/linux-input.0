From: Alban Bedel <alban.bedel@avionic-design.de>
Subject: Re: [PATCH] Input: tca8418 - Add support for shared interrupt
Date: Tue, 6 Nov 2012 17:34:30 +0100
Message-ID: <20121106173430.2d959c10@avionic-0020.adnet.avionic-design.de>
References: <1352132052-19771-1-git-send-email-alban.bedel@avionic-design.de>
	<20121105185806.GA18149@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:63722 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372Ab2KFQee (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Nov 2012 11:34:34 -0500
In-Reply-To: <20121105185806.GA18149@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Mon, 5 Nov 2012 10:58:06 -0800
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> I do not think that using ONESHOT IRQ handlers in shared interrupt
> configuration is a good idea as that interrupt will stay masked until
> the keypad is done processing it, which may take some time.

I don't really see what the problem is, shared ONESHOT handlers are
supported by the IRQ framework. The IRQ line of this device is an open
drain and so can be shared, and is shared on the hardware I'm using!

I agree that the interrupt masking time might rise a little if many
devices share the same line, but that's the normal drawback of shared
interrupts.

Alban
