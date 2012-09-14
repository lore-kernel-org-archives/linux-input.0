From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [Patch v1 4/7] DA9055 GPIO driver
Date: Fri, 14 Sep 2012 18:36:48 +0530
Message-ID: <50532BE8.9040905@nvidia.com>
References: <1347629416.18587.15.camel@dhruva>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:2255 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754670Ab2INNdM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 14 Sep 2012 09:33:12 -0400
In-Reply-To: <1347629416.18587.15.camel@dhruva>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ashish Jangam <ashish.jangam@kpitcummins.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, David Dajun Chen <dchen@diasemi.com>

On Friday 14 September 2012 07:00 PM, Ashish Jangam wrote:
> This is the GPIO patch for the DA9055 PMIC. This patch has got
> dependency on the DA9055 MFD core.
>
> This patch is functionally tested on SMDK6410 board.
>
> Signed-off-by: David Dajun Chen<dchen@diasemi.com>
> Signed-off-by: Ashish Jangam<ashish.jangam@kpitcummins.com>
> ---
>

> +struct da9055_gpio {
> +	struct da9055 *da9055;
> +	struct gpio_chip gp;
I suggest to  make gp as first member so that offset of member will be 0 
in container_of macro and avoid one ops.


> +static struct gpio_chip reference_gp __devinitdata = {

This is device int data and you used after device initailisation. I 
think this can create issue.


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
