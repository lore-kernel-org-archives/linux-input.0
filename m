From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5] input: Add MELFAS mms114 touchscreen driver
Date: Thu, 24 May 2012 00:53:52 -0700
Message-ID: <20120524075352.GB10562@core.coreip.homeip.net>
References: <1337841467-20717-1-git-send-email-jy0922.shim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:40144 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819Ab2EXHx5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 May 2012 03:53:57 -0400
Received: by dady13 with SMTP id y13so10948312dad.19
        for <linux-input@vger.kernel.org>; Thu, 24 May 2012 00:53:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1337841467-20717-1-git-send-email-jy0922.shim@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: linux-input@vger.kernel.org, rydberg@euromail.se, kyungmin.park@samsung.com

Hi Joonyoung,

On Thu, May 24, 2012 at 03:37:47PM +0900, Joonyoung Shim wrote:
> +
> +static int mms114_start(struct mms114_data *data)
> +{
> +	int error;
> +
> +	mutex_lock(&data->mutex);
> +	if (data->enabled)
> +		goto out;

This seems too complicated. You already take input_dev->mutex in
suspend/resume and open/close are called with this mutex held so you do
not need yet another mutex here.

Same goes for data->enabled - you can go by the fact that number of
users != 0.

It also looks like you want to bring enabling/disabling IRQ into
start/stop and probably cfg_pin as well.

Thanks.

-- 
Dmitry
