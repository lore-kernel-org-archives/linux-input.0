From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 13/20] mfd/tc3589x: add suspend/resume support
Date: Thu, 9 Dec 2010 18:03:57 +0100
Message-ID: <20101209170356.GY8884@sortiz-mobl>
References: <1291388753-14662-1-git-send-email-sundar.iyer@stericsson.com>
 <1291388753-14662-14-git-send-email-sundar.iyer@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:51067 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753944Ab0LIREB (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 9 Dec 2010 12:04:01 -0500
Content-Disposition: inline
In-Reply-To: <1291388753-14662-14-git-send-email-sundar.iyer@stericsson.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sundar Iyer <sundar.iyer@stericsson.com>
Cc: linux-arm-kernel@lists.infradead.org, dmitry.torokhov@gmail.com, ben-linux@fluff.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Sundar,

On Fri, Dec 03, 2010 at 08:35:46PM +0530, Sundar Iyer wrote:

Acked-by: Samuel Ortiz <sameo@linux.intel.com>

One remark though:
> +
> +static const struct dev_pm_ops tc3589x_dev_pm_ops = {
> +	.suspend = tc3589x_suspend,
> +	.resume  = tc3589x_resume,
> +};
> +#endif
SIMPLE_DEV_PM_OPS or UNIVERSAL_DEV_PM_OPS may be useful and save one ifdef
here.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
