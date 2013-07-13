From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] Input: sysrq - DT binding for key sequences
Date: Sat, 13 Jul 2013 13:41:40 -0700
Message-ID: <20130713204140.GA11511@core.coreip.homeip.net>
References: <1373622962-16534-1-git-send-email-mathieu.poirier@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:32894 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753943Ab3GMUlo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 13 Jul 2013 16:41:44 -0400
Received: by mail-pa0-f51.google.com with SMTP id lf11so10066345pab.10
        for <linux-input@vger.kernel.org>; Sat, 13 Jul 2013 13:41:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1373622962-16534-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: mathieu.poirier@linaro.org
Cc: grant.likely@linaro.org, devicetree-discuss@lists.ozlabs.org, john.stultz@linaro.org, linux-input@vger.kernel.org, kernel-team@android.com

Hi Matthieu,

On Fri, Jul 12, 2013 at 03:56:02AM -0600, mathieu.poirier@linaro.org wrote:
> +
> +	np = of_find_node_by_path("/chosen");
> +	if (!np)
> +		goto out;
> +
> +	np = of_find_node_by_name(np, "linux,sysrq-reset-seq");
> +	if (!np) {
> +		pr_debug("No sysrq node found");
> +		goto out;
> +	}

Can if be folded into:

	np = of_find_node_by_path("/chosen/linux,sysrq-reset-seq")

?

Thanks.

-- 
Dmitry
