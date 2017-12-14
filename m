From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: Re: [Y2038] [PATCH v4 4/4] input: serio: Replace timeval by
 timespec64
Date: Thu, 14 Dec 2017 21:45:28 +0000
Message-ID: <1513287928.18523.283.camel@codethink.co.uk>
References: <20171207181306.5623-1-deepa.kernel@gmail.com>
         <20171207181306.5623-5-deepa.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from imap1.codethink.co.uk ([176.9.8.82]:34551 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753039AbdLNVpb (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 14 Dec 2017 16:45:31 -0500
In-Reply-To: <20171207181306.5623-5-deepa.kernel@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Deepa Dinamani <deepa.kernel@gmail.com>, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: y2038@lists.linaro.org, peter.hutterer@who-t.net, arnd@arndb.de

On Thu, 2017-12-07 at 10:13 -0800, Deepa Dinamani wrote:
> struct timeval is not y2038 safe.
> All references to timeval will be deleted from the
> kernel to make it y2038 safe.
> Replace its uses by y2038 safe struct timespec64.
> 
> The timestamps changed here only keep track of delta
> times. These timestamps are also internal to kernel.
> Hence, monotonic times are sufficient here.
> The unit of the delta times is also changed in certain
> cases to nanoseconds rather than microseconds. This is
> in line with timespec64 which keeps time in nanoseconds.
[...]
> --- a/drivers/input/serio/hil_mlc.c
> +++ b/drivers/input/serio/hil_mlc.c
[...]
> @@ -466,7 +466,7 @@ static const struct hilse_node hil_mlc_se[HILSEN_END] = {
>  	FUNC(hilse_init_lcv, 0,	HILSEN_NEXT,	HILSEN_SLEEP,	0)
>  
>  	/* 1  HILSEN_RESTART */
> -	FUNC(hilse_inc_lcv, 10,	HILSEN_NEXT,	HILSEN_START,  0)
> +	FUNC(hilse_inc_lcv, 10000,	HILSEN_NEXT,	HILSEN_START,  0)
[...]

The second macro argument here ends up as the second argument to
hilse_inc_lcv() which appears to limit the number of retries, not a
time limit.  So I don't think the value here (or wherever else
hilse_inc_lcv is referenced) should be changed.

The EXPECT, EXPECT_LAST etc. macros take a timeout ('to' parameter)
which is then assigned to hil_mlc::intimeout, so it seems that those
*should* be scaled up, but this patch doesn't do that.  It also doesn't
change the type of hil_mlc::intimeout (suseconds_t implying units of
microseconds) or the comment on hilse_node::arg.

Alternately, it might be safer to keep all the timeouts in units of
microseconds.

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
