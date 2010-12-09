From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2]input - wacom_w8001: Add one finger touch support
Date: Wed, 8 Dec 2010 22:44:39 -0800
Message-ID: <20101209064439.GB6233@core.coreip.homeip.net>
References: <1291857829-13804-1-git-send-email-pinglinux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:44940 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754555Ab0LIGoq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Dec 2010 01:44:46 -0500
Received: by ywl5 with SMTP id 5so1180974ywl.19
        for <linux-input@vger.kernel.org>; Wed, 08 Dec 2010 22:44:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1291857829-13804-1-git-send-email-pinglinux@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

On Wed, Dec 08, 2010 at 05:23:49PM -0800, Ping Cheng wrote:
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> ---
>  drivers/input/touchscreen/wacom_w8001.c |   74 +++++++++++++++++++++++++++++--
>  1 files changed, 70 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touchscreen/wacom_w8001.c
> index 90b92e8..68087d8 100644
> --- a/drivers/input/touchscreen/wacom_w8001.c
> +++ b/drivers/input/touchscreen/wacom_w8001.c
> @@ -3,6 +3,7 @@
>   *
>   * Copyright (c) 2008 Jaya Kumar
>   * Copyright (c) 2010 Red Hat, Inc.
> + * Copyright (c) 2010 Ping Cheng, Wacom. <pingc@wacom.com>
>   *
>   * This file is subject to the terms and conditions of the GNU General Public
>   * License. See the file COPYING in the main directory of this archive for
> @@ -86,6 +87,12 @@ struct w8001 {
>  	char phys[32];
>  	int type;
>  	unsigned int pktlen;
> +	bool pen_in_prox;
> +	bool has_touch;
> +	int max_touch_x;
> +	int max_touch_y;
> +	int max_pen_x;
> +	int max_pen_y;

This does not apply to my tree. What tree was it made against?

-- 
Dmitry
