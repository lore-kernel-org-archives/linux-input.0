From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC v2 PATCH 4/7] input: pmic8058_pwrkey: Add support for power
 key
Date: Tue, 1 Feb 2011 09:49:11 -0800
Message-ID: <20110201174911.GA518@core.coreip.homeip.net>
References: <1296568063-12010-1-git-send-email-aghayal@codeaurora.org>
 <1296568063-12010-5-git-send-email-aghayal@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:38456 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755882Ab1BARth (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Feb 2011 12:49:37 -0500
Content-Disposition: inline
In-Reply-To: <1296568063-12010-5-git-send-email-aghayal@codeaurora.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anirudh Ghayal <aghayal@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, rtc-linux@googlegroups.com, linux-arm-msm@vger.kernel.org, Trilok Soni <tsoni@codeaurora.org>

On Tue, Feb 01, 2011 at 07:17:40PM +0530, Anirudh Ghayal wrote:
> From: Trilok Soni <tsoni@codeaurora.org>
> 
> Add support for PMIC8058 power key driven over dedicated
> KYPD_PWR_N pin. It allows the user to specify the amount
> of time by which the power key reporting can be delayed.
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Trilok Soni <tsoni@codeaurora.org>
> ---
> Changes from v1:
> Addressed review comments from Dmitry.
> Added KEY_SCREENLOCK instead of KEY_END.

...
> +	input_report_key(pwrkey->pwr, KEY_SCROLLLOCK, 1);
...
> +	input_report_key(pwrkey->pwr, KEY_SCREENLOCK, 0);
...
> +	input_set_capability(pwr, EV_KEY, KEY_SCROLLLOCK);


You are confused about the event you are sending.

Thanks.

-- 
Dmitry
