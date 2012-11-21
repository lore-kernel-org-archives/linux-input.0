From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1] input: added driver support for the t5400 pressure
 sensor.
Date: Tue, 20 Nov 2012 23:06:25 -0800
Message-ID: <20121121070625.GE16772@core.coreip.homeip.net>
References: <1353445355-2517-1-git-send-email-stefan.nilsson@unixphere.com>
 <1353445355-2517-2-git-send-email-stefan.nilsson@unixphere.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:43361 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751653Ab2KUHGa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Nov 2012 02:06:30 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so4871828pbc.19
        for <linux-input@vger.kernel.org>; Tue, 20 Nov 2012 23:06:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1353445355-2517-2-git-send-email-stefan.nilsson@unixphere.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stefan Nilsson <stefan.nilsson@unixphere.com>
Cc: linux-input@vger.kernel.org, rob.herring@calxeda.com, arnd@arndb.de, matthias.schmidt@epcos.com, armin.schober@epcos.com, eric.andersson@unixphere.com

Hi Stefan,

On Tue, Nov 20, 2012 at 10:02:34PM +0100, Stefan Nilsson wrote:
> +
> +	idev->evbit[0] = BIT_MASK(EV_ABS);
> +	input_set_abs_params(idev, ABS_PRESSURE, T5400_ABS_MIN_PRES,
> +					T5400_ABS_MAX_PRES, 0, 0);
> +	input_set_abs_params(idev, ABS_MISC, T5400_ABS_MIN_TEMP,
> +					T5400_ABS_MAX_TEMP, 0, 0);
> +

This driver should be using IIO, not input subsystem.

Thanks.

-- 
Dmitry
