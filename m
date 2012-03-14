From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH V1] input: keyboard: gpio: Support for interrupt only key
Date: Wed, 14 Mar 2012 09:00:11 -0700
Message-ID: <20120314160011.GA12987@core.coreip.homeip.net>
References: <1331715123-15099-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:37895 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757925Ab2CNQAV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Mar 2012 12:00:21 -0400
Content-Disposition: inline
In-Reply-To: <1331715123-15099-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: grant.likely@secretlab.ca, linus.walleij@stericsson.com, david@protonic.nl, tklauser@distanz.ch, alexander.stein@informatik.tu-chemnitz.de, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Laxman,

On Wed, Mar 14, 2012 at 02:22:03PM +0530, Laxman Dewangan wrote:
> Some of key in system generates interrupt only when it
> pressed like power-on key or onkey. These keys do not
> actually mapped as gpio in system.
> Supporting the key pressed event on such keys which are
> not actually gpio keys but generates interrupt only.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> ---
> When I pushed the new driver for interrupt key, the suggestion came
> to include this functionality in the gpio-key driver. I added require
> changed in gpio-keys.c to support interrupt key only.
> 

This looks much much better than a whole new driver. Let me look it over
in more detail and get back to you.

Thanks!

-- 
Dmitry
