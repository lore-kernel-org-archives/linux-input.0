From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [Patch v1 7/7] DA9055 Onkey driver
Date: Fri, 14 Sep 2012 18:48:09 +0530
Message-ID: <50532E91.3020200@nvidia.com>
References: <1347629677.18587.21.camel@dhruva>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:2991 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753915Ab2INNoa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 14 Sep 2012 09:44:30 -0400
In-Reply-To: <1347629677.18587.21.camel@dhruva>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ashish Jangam <ashish.jangam@kpitcummins.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Samuel Ortiz <sameo@linux.intel.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, David Dajun Chen <dchen@diasemi.com>

On Friday 14 September 2012 07:04 PM, Ashish Jangam wrote:
> +static irqreturn_t da9055_onkey_irq(int irq, void *data)
> +{
> +	struct input_dev *input_dev = data;
> +
> +	input_report_key(input_dev, KEY_POWER, 1);
When do you send the release key event?


Overall driver looks like you can use the gpio-key driver with passing 
irq number, without passing gpio.


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
