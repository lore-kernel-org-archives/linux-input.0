From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] input: make mainstone-wm97xx.c depend on MACH_MAINSTONE instead of ARCH_PXA
Date: Sun, 22 Jun 2008 09:53:45 +0100
Message-ID: <20080622085344.GC30754@flint.arm.linux.org.uk>
References: <48564133.3070609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:39231 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185AbYFVIx7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 22 Jun 2008 04:53:59 -0400
Content-Disposition: inline
In-Reply-To: <48564133.3070609@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>

On Mon, Jun 16, 2008 at 06:32:19PM +0800, Eric Miao wrote:
> If this is totally mainstone specific.
> 
> Signed-off-by: Eric Miao <eric.miao@marvell.com>

Ok.  Should probably be a -rc thing.
