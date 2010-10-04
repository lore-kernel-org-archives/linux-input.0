From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] Input: hgpk - enable advanced mode through module
 parameter
Date: Mon, 4 Oct 2010 10:45:34 -0700
Message-ID: <20101004174533.GC8321@core.coreip.homeip.net>
References: <20101002204235.052959D401B@zog.reactivated.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:64997 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754189Ab0JDRpm (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Oct 2010 13:45:42 -0400
Received: by pzk34 with SMTP id 34so1400364pzk.19
        for <linux-input@vger.kernel.org>; Mon, 04 Oct 2010 10:45:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101002204235.052959D401B@zog.reactivated.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-input@vger.kernel.org, pgf@laptop.org

Hi Daniel,

On Sat, Oct 02, 2010 at 09:42:34PM +0100, Daniel Drake wrote:
> +
> +	/*
> +	 * The first packet after the finger goes down only establishes the
> +	 * baseline for relative movement.
> +	 * (ignore possibility of finger going down and button being pressed
> +	 * simultaneously.)
> +	 */
> +	if (!priv->isdown) {
> +		priv->abs_x = *x;
> +		priv->abs_y = *y;
> +		priv->isdown = true;
> +		return false;
> +	}
> +
> +	tmp = *x; *x -= priv->abs_x; priv->abs_x = tmp;
> +	tmp = *y; *y -= priv->abs_y; priv->abs_y = tmp;

Why do you use abs->rel conversion in driver and not rely on the
standard userspace component handling thouchpads in absolute mode?

Thanks.

-- 
Dmitry
