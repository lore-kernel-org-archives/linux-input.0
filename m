From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: mc13783-pwrbutton - convert to use
 module_platform_driver()
Date: Sun, 11 Dec 2011 23:43:58 -0800
Message-ID: <20111212074358.GB4682@core.coreip.homeip.net>
References: <1323396846.3740.10.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57857 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953Ab1LLHoF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Dec 2011 02:44:05 -0500
Content-Disposition: inline
In-Reply-To: <1323396846.3740.10.camel@phoenix>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, linux-input@vger.kernel.org

On Fri, Dec 09, 2011 at 10:14:06AM +0800, Axel Lin wrote:
> This patch converts mc13783-pwrbutton to use the module_platform_driver()
> macro which makes the code smaller and a bit simpler.
> 
> Also staticise mc13783_pwrbutton_driver which is not used outside
> this driver so no need to make the symbol global.
> 

Applied, thank you Axel.

-- 
Dmitry
