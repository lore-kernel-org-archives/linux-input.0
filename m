From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Add support for newer elantech touchpads
Date: Thu, 24 Apr 2014 23:39:25 -0700
Message-ID: <20140425063925.GE10433@core.coreip.homeip.net>
References: <CALxcDfxOXM5FqjN9UB4MLVKtAjEJt7DD=EgcrJ-Hb_D-3mkciA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:45109 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165AbaDYGj2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Apr 2014 02:39:28 -0400
Content-Disposition: inline
In-Reply-To: <CALxcDfxOXM5FqjN9UB4MLVKtAjEJt7DD=EgcrJ-Hb_D-3mkciA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jordan Rife <jrife0@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Tue, Apr 22, 2014 at 01:40:51PM -0500, Jordan Rife wrote:
> From: Jordan Rife <jrife0@gmail.com>
> 
> Newer elantech touchpads are not recognized by the current driver, since it
> fails to detect their firmware version number. This prevents more advanced
> touchpad features from being usable such as two-finger scrolling. This
> patch allows newer touchpads to be detected and be fully functional. Tested
> on Sony Vaio SVF13N17PXB.
> 
> Signed-off-by: Jordan Rife <jrife0@gmail.com>

Applied, thank you.

> ---
> diff -pruN linux-master.orig/drivers/input/mouse/elantech.c
> linux-master.modified/drivers/input/mouse/elantech.c
> --- linux-master.orig/drivers/input/mouse/elantech.c 2014-04-22
> 12:57:57.597186781 -0500
> +++ linux-master.modified/drivers/input/mouse/elantech.c 2014-04-22
> 12:59:57.257191243 -0500
> @@ -1353,6 +1353,7 @@ static int elantech_set_properties(struc
>   case 6:
>   case 7:
>   case 8:
> + case 9:
>   etd->hw_version = 4;
>   break;
>   default:

-- 
Dmitry
