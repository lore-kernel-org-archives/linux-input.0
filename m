From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Input: wm97xx - use EBUSY instead of EINVAL
Date: Wed, 3 Jun 2009 15:40:24 +0100
Message-ID: <20090603144024.GJ11507@sirena.org.uk>
References: <4A260DEB.2040306@samsung.com> <20090603100120.GA31919@rakim.wolfsonmicro.main> <20090603141913.GA21197@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:37941 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757503AbZFCOkZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Jun 2009 10:40:25 -0400
Content-Disposition: inline
In-Reply-To: <20090603141913.GA21197@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>, linux-input@vger.kernel.org

On Wed, Jun 03, 2009 at 07:19:14AM -0700, Dmitry Torokhov wrote:

> The "most correct" thing would be to propagate the value returned by
> request_irq() I think but since nobidy actually uses result of
> wm97xx_init_pen_irq() I just would not bother at all.

Yeah, I was looking at that - the driver can run in polling mode so it's
fine as-is.  I could change the code to return void, I suppose.
