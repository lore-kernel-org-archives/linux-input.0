From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: mxs-lradc: remove redundant assignment to pointer
 input
Date: Fri, 27 Oct 2017 15:48:10 -0700
Message-ID: <20171027224810.qd7pjnmhjlnqblkk@dtor-ws>
References: <20171027155230.12887-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:43955 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752781AbdJ0WsP (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 27 Oct 2017 18:48:15 -0400
Content-Disposition: inline
In-Reply-To: <20171027155230.12887-1-colin.king@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Oct 27, 2017 at 04:52:30PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The pointer 'input' is being initialized with ts->ts_input and this
> value is not being read as it is updated a few lines later with the
> return value from the call to devm_input_allocate_device. Remove the
> redundant initialization assignment.  Cleans up clang warning:
> 
> drivers/input/touchscreen/mxs-lradc-ts.c:587:20: warning: Value Xi
> stored to 'input' during its initialization is never read
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied, thank you.

> ---
>  drivers/input/touchscreen/mxs-lradc-ts.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/mxs-lradc-ts.c b/drivers/input/touchscreen/mxs-lradc-ts.c
> index 3707e927f770..c850b517854e 100644
> --- a/drivers/input/touchscreen/mxs-lradc-ts.c
> +++ b/drivers/input/touchscreen/mxs-lradc-ts.c
> @@ -584,7 +584,7 @@ static void mxs_lradc_ts_hw_init(struct mxs_lradc_ts *ts)
>  
>  static int mxs_lradc_ts_register(struct mxs_lradc_ts *ts)
>  {
> -	struct input_dev *input = ts->ts_input;
> +	struct input_dev *input;
>  	struct device *dev = ts->dev;
>  
>  	input = devm_input_allocate_device(dev);
> -- 
> 2.14.1
> 

-- 
Dmitry
