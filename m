From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] input: make mainstone-wm97xx.c depend on
	MACH_MAINSTONE instead of ARCH_PXA
Date: Tue, 17 Jun 2008 10:59:28 +0100
Message-ID: <20080617095928.GD6114@rakim.wolfsonmicro.main>
References: <48564133.3070609@gmail.com> <20080616120756.GA7302@rakim.wolfsonmicro.main> <48570E1E.3070301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:45781 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751443AbYFQJ7a (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Jun 2008 05:59:30 -0400
Content-Disposition: inline
In-Reply-To: <48570E1E.3070301@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>

On Tue, Jun 17, 2008 at 09:06:38AM +0800, Eric Miao wrote:

> Mike Rapoport said it could be re-used for EM-X270, so I'd suggest this
> better to be PXA generic, and pass platform data as you advised.

Yeah, that's the ideal.  Unfortunately passing platform data through
AC97 is a bit of a can of worms :(
