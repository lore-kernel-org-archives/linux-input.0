From: Trilok Soni <tsoni@codeaurora.org>
Subject: Re: [PATCH v3] Input: add ST1232 touchscreen controller driver.
Date: Wed, 15 Dec 2010 14:09:51 +0530
Message-ID: <4D087ED7.2000101@codeaurora.org>
References: <1292400728-15521-1-git-send-email-chinyeow.sim.xt@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:12667 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963Ab0LOIj4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Dec 2010 03:39:56 -0500
In-Reply-To: <1292400728-15521-1-git-send-email-chinyeow.sim.xt@renesas.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: chinyeow.sim.xt@renesas.com
Cc: dmitry.torokhov@gmail.com, rydberg@euromail.se, linux-input@vger.kernel.org

Hi Tony,

On 12/15/2010 1:42 PM, chinyeow.sim.xt@renesas.com wrote:
> From: Tony SIM <chinyeow.sim.xt@renesas.com>
> 
> This patch set introduces for Sitronix ST1232 touchscreen controller
> driver. This is an integrated capacitive touchscreen with LCD module
> which can detect two fingers's touch X/Y coordinate.
> 
> Signed-off-by: Tony SIM <chinyeow.sim.xt@renesas.com>

Thanks for submitting 3rd version. We are getting closer to acceptance :)

> +struct st1232_ts_data {
> +	struct i2c_client *client;
> +	struct input_dev *input_dev;
> +	struct delayed_work work;

work is not used anymore. Please remove.

> +	struct st1232_ts_finger finger[MAX_FINGERS];
> +};
> +

---Trilok Soni

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
