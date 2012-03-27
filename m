From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: tegra-kbc: Fix: Allocate pdata before using it
Date: Mon, 26 Mar 2012 23:47:25 -0700
Message-ID: <20120327064725.GA1361@core.coreip.homeip.net>
References: <28d8716b43c5078b238638ba60a4b170807074b9.1332827588.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:60319 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756740Ab2C0Grc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Mar 2012 02:47:32 -0400
Received: by pbcun15 with SMTP id un15so7006524pbc.19
        for <linux-input@vger.kernel.org>; Mon, 26 Mar 2012 23:47:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <28d8716b43c5078b238638ba60a4b170807074b9.1332827588.git.viresh.kumar@st.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Viresh Kumar <viresh.kumar@st.com>
Cc: swarren@nvidia.com, olof@lixom.net, linux-input@vger.kernel.org, srasal@nvidia.com

On Tue, Mar 27, 2012 at 11:24:49AM +0530, Viresh Kumar wrote:
> Following commit broke DT support for tegra-kbc by removing pdata allocation
> completely.

Must be my fat fingers, sorry about this.

> 
> commit 023cea0ecfa2df034096c3f4afa796a0b2d1188a
> Author: Shridhar Rasal <srasal@nvidia.com>
> Date:   Fri Feb 3 00:27:30 2012 -0800
> 
>     Input: tegra-kbc - allow skipping setting up some of GPIO pins
> 
> This patch restores it.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
>  drivers/input/keyboard/tegra-kbc.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
> index 96ee31e..5827fbe 100644
> --- a/drivers/input/keyboard/tegra-kbc.c
> +++ b/drivers/input/keyboard/tegra-kbc.c
> @@ -630,6 +630,7 @@ tegra_kbc_dt_parse_pdata(struct platform_device *pdev)
>  	if (!np)
>  		return NULL;
>  
> +	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
>  	if (!pdata)
>  		return NULL;
>  
> -- 
> 1.7.10.rc2.10.gb47606
> 

-- 
Dmitry
