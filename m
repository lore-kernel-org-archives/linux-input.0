From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] touchscreen/nuc900: fix wrong setup_timer parameter
Date: Fri, 16 Jul 2010 00:07:50 -0700
Message-ID: <20100716070750.GB3712@core.coreip.homeip.net>
References: <4C3FC736.4010805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:61879 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935690Ab0GPHH7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Jul 2010 03:07:59 -0400
Content-Disposition: inline
In-Reply-To: <4C3FC736.4010805@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wan ZongShun <mcuos.com@gmail.com>
Cc: linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Fri, Jul 16, 2010 at 10:43:02AM +0800, Wan ZongShun wrote:
> Hi Dmitry,
> 
> This patch fixes wrong setup_timer parameter,when pen up event coming
> all codes quoting the w90p910_ts work failed.
> 

Applied, thanks Wan.

-- 
Dmitry
