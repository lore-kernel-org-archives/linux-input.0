From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: bf54x-keys: Fix typo
Date: Fri, 6 Mar 2009 01:38:00 -0800
Message-ID: <20090306093642.GA24864@dtor-d630.eng.vmware.com>
References: <1236310491-24387-1-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.26]:35146 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355AbZCFJpe (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Mar 2009 04:45:34 -0500
Received: by qw-out-2122.google.com with SMTP id 5so486473qwi.37
        for <linux-input@vger.kernel.org>; Fri, 06 Mar 2009 01:45:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1236310491-24387-1-git-send-email-cooloney@kernel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bryan Wu <cooloney@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>

Hi Bryan,

On Fri, Mar 06, 2009 at 11:34:51AM +0800, Bryan Wu wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Bryan Wu <cooloney@kernel.org>
> ---
>  drivers/input/keyboard/bf54x-keys.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/input/keyboard/bf54x-keys.c b/drivers/input/keyboard/bf54x-keys.c
> index ee855c5..c6f4e16 100644
> --- a/drivers/input/keyboard/bf54x-keys.c
> +++ b/drivers/input/keyboard/bf54x-keys.c
> @@ -212,7 +212,7 @@ static int __devinit bfin_kpad_probe(struct platform_device *pdev)
>  	if (!pdata->debounce_time || pdata->debounce_time > MAX_MULT ||
>  	    !pdata->coldrive_time || pdata->coldrive_time > MAX_MULT) {
>  		printk(KERN_ERR DRV_NAME
> -			": Invalid Debounce/Columdrive Time from pdata\n");
> +			": Invalid Debounce/Columndrive Time from platform data\n");

Applied, but lowered severity form error to warning since the driver
is still functional even with bad timing values in platform data.

-- 
Dmitry
