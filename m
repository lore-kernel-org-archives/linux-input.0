From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [PATCH] input: let's remove the now deprecated corgi_ts.c
Date: Thu, 05 Feb 2009 13:33:04 +0000
Message-ID: <1233840784.5350.8.camel@dax.rpnet.com>
References: <f17812d70902050226g1780ca58m4d271b55ba3d3166@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]:61383 "EHLO
	tim.rpsys.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751593AbZBEOGR (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 5 Feb 2009 09:06:17 -0500
In-Reply-To: <f17812d70902050226g1780ca58m4d271b55ba3d3166@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: linux-input@vger.kernel.org


On Thu, 2009-02-05 at 18:26 +0800, Eric Miao wrote:
> Let's move to the generic SPI based ADS7846 touchscreen driver.
> 
> Signed-off-by: Eric Miao <eric.miao@marvell.com>
> ---
> 
> Richard, any concern on this move?

Does the SPI based ADS7846 touchscreen driver have the facility to sync
the touchscreen readings with the video blanking period to reduce
interference now? That was the main feature that needed porting over.

Cheers,

Richard

