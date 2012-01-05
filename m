From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC][PATCH] Input: Add infrastrucutre for monotonic event time
 stamps.
Date: Thu, 5 Jan 2012 15:28:53 -0800
Message-ID: <20120105232853.GA1193@core.coreip.homeip.net>
References: <1325804465-20612-1-git-send-email-john.stultz@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40488 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753316Ab2AEX3B (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 Jan 2012 18:29:01 -0500
Received: by iaeh11 with SMTP id h11so1632150iae.19
        for <linux-input@vger.kernel.org>; Thu, 05 Jan 2012 15:29:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1325804465-20612-1-git-send-email-john.stultz@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: John Stultz <john.stultz@linaro.org>
Cc: linux-input@vger.kernel.org, Daniel Kurtz <djkurtz@google.com>, Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>

Hi John,

On Thu, Jan 05, 2012 at 03:01:05PM -0800, John Stultz wrote:
>  
> +	case EVIOCMONTIME:
> +		if (copy_from_user(&i, p, sizeof(unsigned int)))
> +			return -EFAULT;
> +		client->use_monotonic = i;
> +		return 0;

Maybe we should let users pass not boolean but CLOCK_* value (and reject
ones that we do not support) ? This way if someone wants to use some
other clock type in the future we won't need new ioctl.

Thanks.

-- 
Dmitry
