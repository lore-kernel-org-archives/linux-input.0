From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] Input: xpad - return proper error in error path
Date: Thu, 11 Nov 2010 22:06:36 -0800
Message-ID: <20101112060636.GA5093@core.coreip.homeip.net>
References: <1289530116.20782.2.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:41013 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821Ab0KLGGo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Nov 2010 01:06:44 -0500
Content-Disposition: inline
In-Reply-To: <1289530116.20782.2.camel@mola>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Marko Friedemann <mfr@bmx-chemnitz.de>, Christoph Fritz <chf.fritz@googlemail.com>, linux-input@vger.kernel.org

On Fri, Nov 12, 2010 at 10:48:36AM +0800, Axel Lin wrote:
> In current implementation, xpad_probe return 0 when
> usb_alloc_urb failed for xpad->bulk_out and kzalloc failed for xpad->bdata.
> 
> This patch removes the initialization for error variable,
> assign the error code at the place the error happens instead.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Applied all 3, thanks Axel.

-- 
Dmitry
