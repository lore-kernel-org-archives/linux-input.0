From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Make ADS7846 independent on regulator
Date: Fri, 30 Jul 2010 23:33:29 -0700
Message-ID: <20100731063329.GA23620@core.coreip.homeip.net>
References: <1280555108-27994-1-git-send-email-marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:36027 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755151Ab0GaGdf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 31 Jul 2010 02:33:35 -0400
Content-Disposition: inline
In-Reply-To: <1280555108-27994-1-git-send-email-marek.vasut@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, vapier@gentoo.org, pavel@ucw.cz, akpm@linux-foundation.org, khilman@deeprootsystems.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, eric.y.miao@gmail.com

Hi Marek,

On Sat, Jul 31, 2010 at 07:45:08AM +0200, Marek Vasut wrote:
> In case regulator was not found, ADS7846 failed to probe.
> 
> This fixes a problem on some Sharp Zaurus devices, where there is no regulator
> present and yet the touchscreen is used.
> 

Too many ifdefs to my taste... Can we have ads7846_regulator_enable()
and friends stubbed out in case !CONFIG_REGULATOR?

-- 
Dmitry
