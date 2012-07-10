From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1] Input: hanwang - add support for Art Master II tablet
Date: Mon, 9 Jul 2012 23:42:33 -0700
Message-ID: <20120710064233.GA29927@core.coreip.homeip.net>
References: <1340979246-2941-1-git-send-email-weixing@hanwang.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:60295 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552Ab2GJGmj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Jul 2012 02:42:39 -0400
Received: by ghrr11 with SMTP id r11so10938425ghr.19
        for <linux-input@vger.kernel.org>; Mon, 09 Jul 2012 23:42:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1340979246-2941-1-git-send-email-weixing@hanwang.com.cn>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: weixing <weixing@hanwang.com.cn>
Cc: linux-input@vger.kernel.org, xing_wei777@126.com

Hi,

On Fri, Jun 29, 2012 at 10:14:06PM +0800, weixing wrote:
>  
>  	switch (data[0]) {
>  	case 0x02:	/* data packet */
>  		switch (data[1]) {
>  		case 0x80:	/* tool prox out */
> -			hanwang->current_id = 0;
> -			input_report_key(input_dev, hanwang->current_tool, 0);
> +			if (type != HANWANG_ART_MASTER_II) {
> +				hanwang->current_id = 0;
> +				input_report_key(input_dev,
> +					hanwang->current_tool, 0);
> +			}
> +			break;
> +		case 0x00:	/* artmaster ii pen leave */
> +			if (type == HANWANG_ART_MASTER_II) {
> +				hanwang->current_id = 0;
> +				input_report_key(input_dev,
> +					hanwang->current_tool, 0);
> +			}
>  			break;

OK, so this will ignore 0x02 0x80 reports on HANWANG_ART_MASTER_II and
0x02 0x00 reports on other tablets. I just want to make sure that was
the intention of the patch.

Thanks.

-- 
Dmitry
