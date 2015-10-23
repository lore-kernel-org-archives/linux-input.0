From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Y2038] [PATCH V2] hp_sdc: fixed y2038 problem
Date: Fri, 23 Oct 2015 11:25:29 +0200
Message-ID: <3901659.bcGNtuE6xV@wuerfel>
References: <5041745.xAgMz1TQSE@wuerfel> <1445590406-30448-1-git-send-email-pingbo.wen@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:59625 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752537AbbJWJZf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 23 Oct 2015 05:25:35 -0400
In-Reply-To: <1445590406-30448-1-git-send-email-pingbo.wen@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: y2038@lists.linaro.org
Cc: WEN Pingbo <pingbo.wen@linaro.org>, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Friday 23 October 2015 16:53:26 WEN Pingbo wrote:
> 1. Converting timeval to ktime_t, and there is no need to handle sec and
> usec separately
> 
> 2. hp_sdc.rtv is only used for time diff, monotonic time is better here
> 
> Signed-off-by: WEN Pingbo <pingbo.wen@linaro.org>
> ---

This version is still correct and looks better than the first version, but
I'd still like you to improve some details:

- read some other changelogs and follow the common style. In particular,
  in the subject line say /what/ you do ("e.g. use ktime_get instead of
  do_gettimeofday",  or "avoid using struct timespec") instead of /why/,
  but then explain in the changelog text what is wrong with the current
  version and why it gets changed like this.

- Below the '---', add a short list of things you have changed since
  the previous versions. This part will not get copied into the git
  history.

> -		do_gettimeofday(&tv);
> -		if (tv.tv_sec > hp_sdc.rtv.tv_sec)
> -			tv.tv_usec += USEC_PER_SEC;
> -
> -		if (tv.tv_usec - hp_sdc.rtv.tv_usec > HP_SDC_MAX_REG_DELAY) {
> +		if (time_diff.tv64 > HP_SDC_MAX_REG_DELAY) {
>  			hp_sdc_transaction *curr;
>  			uint8_t tmp;
>  
> -			printk(KERN_WARNING PREFIX "read timeout (%ius)!\n",
> -			       (int)(tv.tv_usec - hp_sdc.rtv.tv_usec));
> +			printk(KERN_WARNING PREFIX "read timeout (%llins)!\n",
> +			       time_diff.tv64);
>  			curr->idx += hp_sdc.rqty;
>  			hp_sdc.rqty = 0;
>  			tmp = curr->seq[curr->actidx];

A tiny style comment here: please use ktime_to_ns() to extract the
nanoseconds out of the ktime_t type rather than accessing the tv64
member directly.

	Arnd
