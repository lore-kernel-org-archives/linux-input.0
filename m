From: Josh Cartwright <joshc@codeaurora.org>
Subject: Re: [PATCH v4 4/9] Input: pmic8xxx-keypad - Migrate to DT
Date: Thu, 27 Feb 2014 21:41:38 -0600
Message-ID: <20140228034138.GD7308@joshc.qualcomm.com>
References: <1393552520-9068-1-git-send-email-sboyd@codeaurora.org>
 <1393552520-9068-5-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1393552520-9068-5-git-send-email-sboyd@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Looks good, with the exception of one thing...

On Thu, Feb 27, 2014 at 05:55:15PM -0800, Stephen Boyd wrote:
> The driver is only supported on DT enabled platforms. Convert the
> driver to DT so that it can probe properly.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/input/keyboard/pmic8xxx-keypad.c | 150 ++++++++++++++++++-------------
> @@ -471,50 +514,27 @@ static void pmic8xxx_kp_close(struct input_dev *dev)
>   */
>  static int pmic8xxx_kp_probe(struct platform_device *pdev)
>  {
[..]
> -	keymap_data = pdata->keymap_data;
> -	if (!keymap_data) {
> -		dev_err(&pdev->dev, "no keymap data supplied\n");
> -		return -EINVAL;
> -	}
> +	repeat = !of_property_read_bool(pdev->dev.of_node,
> +					"linux,input-no-autorepeat");
> +	wakeup = !of_property_read_bool(pdev->dev.of_node,
> +					"linux,keypad-wakeup");

I don't think you mean to invert this.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
