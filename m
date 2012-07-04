From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: tca6416-keypad: add IRQF_ONESHOT IRQ flag
Date: Wed, 4 Jul 2012 13:19:01 -0700
Message-ID: <20120704201901.GB13248@core.coreip.homeip.net>
References: <Pine.LNX.4.64.1207041217420.21042@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45595 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755715Ab2GDUTI (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Jul 2012 16:19:08 -0400
Received: by pbbrp8 with SMTP id rp8so11533175pbb.19
        for <linux-input@vger.kernel.org>; Wed, 04 Jul 2012 13:19:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1207041217420.21042@axis700.grange>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-input@vger.kernel.org

Hi Guennadi,

On Wed, Jul 04, 2012 at 12:19:13PM +0200, Guennadi Liakhovetski wrote:
> request_threaded_irq() without a hard IRQ handler can only be used, if the
> driver also requests to keep the interrupt masked by using the IRQF_ONESHOT
> IRQ flag.
> 

Thank you for the patch but I already applied one from Lars-Peter
Clausen.

Thanks.

-- 
Dmitry
