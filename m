From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH] input: make mainstone-wm97xx.c depend on MACH_MAINSTONE
 instead of ARCH_PXA
Date: Tue, 17 Jun 2008 09:06:38 +0800
Message-ID: <48570E1E.3070301@gmail.com>
References: <48564133.3070609@gmail.com> <20080616120756.GA7302@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.186]:7230 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035AbYFQBGs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Jun 2008 21:06:48 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1690079tic.23
        for <linux-input@vger.kernel.org>; Mon, 16 Jun 2008 18:06:46 -0700 (PDT)
In-Reply-To: <20080616120756.GA7302@rakim.wolfsonmicro.main>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-input <linux-input@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>

Mark Brown wrote:
> On Mon, Jun 16, 2008 at 06:32:19PM +0800, Eric Miao wrote:
>> If this is totally mainstone specific.
> 
>> Signed-off-by: Eric Miao <eric.miao@marvell.com>
> 
> It is and it isn't.  It's very thin and stands a reasonable chance of
> working with generic PXA systems - ideally at some point we will have 
> the ability to pass platform data to AC97 devices which would let it run
> elsewhere.  The driver was until very recently called pxa-wm97xx but
> renamed recently due to the fact that we can't assume it'll work on
> other things due to having the GPIO hookup hardcoded.
> 
> I'd rather let it be visible but I'm not *too* bothered either way.

Mike Rapoport said it could be re-used for EM-X270, so I'd suggest this
better to be PXA generic, and pass platform data as you advised.
