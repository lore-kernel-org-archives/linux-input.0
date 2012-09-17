From: Ashish Jangam <ashish.jangam@kpitcummins.com>
Subject: Re: [Patch v1 7/7] DA9055 Onkey driver
Date: Mon, 17 Sep 2012 18:00:09 +0530
Message-ID: <1347885009.3014.9.camel@dhruva>
References: <C3AE124F08223B42BC95AEB82F0F6CED32B990D6@KCHJEXMB02.kpit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:50711 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755969Ab2IQMVY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Sep 2012 08:21:24 -0400
In-Reply-To: <C3AE124F08223B42BC95AEB82F0F6CED32B990D6@KCHJEXMB02.kpit.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dewangan@nvidia.com
Cc: linux-input@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, dchen@diasemi.com, Liam Girdwood <lrg@slimlogic.co.uk>

On Mon, 2012-09-17 at 16:28 +0530, Ashish Jangam wrote:
> 
> -----Original Message-----
> From: Laxman Dewangan [mailto:ldewangan@nvidia.com] 
> Sent: Friday, September 14, 2012 6:48 PM
> To: Ashish Jangam
> Cc: Liam Girdwood; Samuel Ortiz; linux-input@vger.kernel.org; David Dajun Chen
> Subject: Re: [Patch v1 7/7] DA9055 Onkey driver
> 
> On Friday 14 September 2012 07:04 PM, Ashish Jangam wrote:
> > +static irqreturn_t da9055_onkey_irq(int irq, void *data)
> > +{
> > +	struct input_dev *input_dev = data;
> > +
> > +	input_report_key(input_dev, KEY_POWER, 1);
> When do you send the release key event?
Well DA9055 does not have any irq/register that provides onkey button
current state and cannot depend on event register since it gets cleared
by regmap. It seems I should use status register to send release key
event. I will implement this and re-submit the patch.
> 
> 
> Overall driver looks like you can use the gpio-key driver with passing 
> irq number, without passing gpio.
Yes, logic can be referred.
> 
> 
> -----------------------------------------------------------------------------------
> This email message is for the sole use of the intended recipient(s) and may contain
> confidential information.  Any unauthorized review, use, disclosure or distribution
> is prohibited.  If you are not the intended recipient, please contact the sender by
> reply email and destroy all copies of the original message.
> -----------------------------------------------------------------------------------
> 


