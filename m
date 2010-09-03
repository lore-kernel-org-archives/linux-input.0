From: Trilok Soni <tsoni@codeaurora.org>
Subject: Re: [PATCH] input: add support for PowerOn(PonKey) button on the
 AB8500 MFD
Date: Fri, 03 Sep 2010 12:40:51 +0530
Message-ID: <4C809F7B.2020807@codeaurora.org>
References: <1283326551-13751-1-git-send-email-sundar.iyer@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:8720 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752823Ab0ICHLI (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 Sep 2010 03:11:08 -0400
In-Reply-To: <1283326551-13751-1-git-send-email-sundar.iyer@stericsson.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sundar Iyer <sundar.iyer@stericsson.com>
Cc: dmitry.torokhov@gmail.com, sameo@linux.intel.com, linux-input@vger.kernel.org, STEricsson_nomadik_linux@list.st.com

Hi Sundar,

> +
> +	info->idev->name = "AB8500 POn(PowerOn) Key";

nit-pick: having spaces in the name would create hard time parsing it. Though it all
depends on the userspace framework.

> +
> +static struct platform_driver ab8500_ponkey_driver = {
> +	.driver		= {
> +		.name	= "ab8500-poweron-key",
> +		.owner	= THIS_MODULE,
> +	},
> +	.probe		= ab8500_ponkey_probe,
> +	.remove		= __devexit_p(ab8500_ponkey_remove),

It is not must for this driver to go through, but what would be the behaviour of
pwr-key on suspend and resume? Do you want power key to wakeup the system from sleep?
OR don't want to make it as wakeup source?

---Trilok Soni

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
