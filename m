From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH v2] Input: add regulator haptic driver
Date: Thu, 24 Oct 2013 12:30:09 +0200
Message-ID: <1382610609.1559.12.camel@linux-fkkt.site>
References: <000a01cec629$3cf34de0$b6d9e9a0$%kim@samsung.com>
	 <20131021155558.GA4255@core.coreip.homeip.net>
	 <025101ced083$35f2a270$a1d7e750$%kim@samsung.com>
	 <1382603886.1559.11.camel@linux-fkkt.site>
	 <028401ced09b$1f6564d0$5e302e70$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:52303 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753177Ab3JXKaM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Oct 2013 06:30:12 -0400
In-Reply-To: <028401ced09b$1f6564d0$5e302e70$%kim@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "hyunhee.kim" <hyunhee.kim@samsung.com>
Cc: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, broonie@opensource.wolfsonmicro.com, peter.ujfalusi@ti.com, wfp5p@virginia.edu, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, kyungmin.park@samsung.com, 'Aristeu Sergio Rozanski Filho' <aris@ruivo.org>

On Thu, 2013-10-24 at 18:26 +0900, hyunhee.kim wrote:
> Hi, 
> 
> Thanks for your review.
> I resent patch v3 after removing wrong wrapping.
> 
> I made one toggle function because enable/disable functions have redundant codes and another reviewer suggested it.
> Is it better to separate it into two functions?

Linus doesn't like parameters affecting behavior.

	Regards
		Oliver


