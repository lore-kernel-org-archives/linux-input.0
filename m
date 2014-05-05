From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v3 2/7] Input: pixcir_i2c_ts: Initialize interrupt mode
 and power mode
Date: Mon, 5 May 2014 11:42:52 +0300
Message-ID: <53674F0C.5040101@ti.com>
References: <1398861392-8959-1-git-send-email-rogerq@ti.com> <1398861392-8959-3-git-send-email-rogerq@ti.com> <20140430162950.GA13624@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140430162950.GA13624@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: rydberg@euromail.se, balbi@ti.com, dmurphy@ti.com, mugunthanvnm@ti.com, nsekhar@ti.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

On 04/30/2014 07:29 PM, Dmitry Torokhov wrote:
> Hi Roger,
> 
> On Wed, Apr 30, 2014 at 03:36:27PM +0300, Roger Quadros wrote:
>> +static int pixcir_stop(struct pixcir_i2c_ts_data *ts)
>> +{
>> +	struct device *dev = &ts->client->dev;
>> +	int ret;
>> +
>> +	/* exit ISR if running, no more report parsing */
>> +	ts->exiting = true;
>> +	mb();	/* update status before we synchronize irq */
>> +
>> +	/* disable ISR from running again */
>> +	disable_irq(ts->client->irq);
>> +
>> +	/* wait till running ISR complete */
>> +	synchronize_irq(ts->client->irq);
>> +
>> +	/* disable interrupt generation */
>> +	ret = pixcir_int_enable(ts, 0);
>> +	if (ret)
>> +		dev_err(dev, "Failed to disable interrupt generation\n");
>> +
>> +	/* restore IRQ */
>> +	enable_irq(ts->client->irq);
>> +
>> +	return ret;
> 
> Should not this be:
> 
> 	pixcir_int_enable(ts, 0);
> 	ts->exiting = true;
> 	mb();
> 	synchronize_irq(ts->client->irq);
> 
> Why do we also need to disable/enable irq?

Yes, you are right. It seems the problem with v2 was that order of mb() and synchronize_irq() were
reversed and thus causing the suspend/resume problem. I tried with your suggestion and it works.
I'll send a revised series.

> 
> By the way, disable_irq() implies synchronize_irq().

OK.

cheers,
-roger
