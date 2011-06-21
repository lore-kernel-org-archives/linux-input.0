From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] locomo: drop special locomo_{read/write}l in favor of
 io{read/write}16
Date: Tue, 21 Jun 2011 03:41:49 -0700
Message-ID: <20110621104148.GB8468@core.coreip.homeip.net>
References: <201106201454.18070.hartleys@visionengravers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:63897 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753270Ab1FUKl5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jun 2011 06:41:57 -0400
Content-Disposition: inline
In-Reply-To: <201106201454.18070.hartleys@visionengravers.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, ARM Kernel <linux-arm-kernel@lists.infradead.org>, linux-input@vger.kernel.org, linux-fbdev@vger.kernel.org, rpurdie@rpsys.net, lethal@linux-sh.org, tglx@linutronix.de, buytenh@secretlab.ca, Russell King <linux@arm.linux.org.uk>

On Mon, Jun 20, 2011 at 02:54:17PM -0700, H Hartley Sweeten wrote:
> All the locomo registers are 16-bit ioremap'ed memory addresses.  
> 
> Make the locomo drivers use generic purpose io routines: ioread16
> and iowrite16 instead of directly accessing memory.
> 
> There are still a couple checkpatch warnings about lines exceeding
> 79 characters.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

Input parts look good to me.

Acked-by: Dmitry Torokhov <dtor@mail.ru>

-- 
Dmitry
