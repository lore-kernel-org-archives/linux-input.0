From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Input: wm97xx - use EBUSY instead of EINVAL
Date: Wed, 3 Jun 2009 11:01:21 +0100
Message-ID: <20090603100120.GA31919@rakim.wolfsonmicro.main>
References: <4A260DEB.2040306@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:45367 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751985AbZFCKBU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 3 Jun 2009 06:01:20 -0400
Content-Disposition: inline
In-Reply-To: <4A260DEB.2040306@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

On Wed, Jun 03, 2009 at 02:45:15PM +0900, Joonyoung Shim wrote:
> If request_irq() fails, we have to return -EBUSY instead of -EINVAL.

Could you provide a bit more explanation for this one, please?  -EBUSY
seems to give entirely the wrong impression to applications since in the
systems where this driver will be deployed a failure to acquire the IRQ
is most likely to be due to incorrect platform data and it is highly
unlikely to resolve itself.
