From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [PATCH v2] input: add synaptics_i2c driver
Date: Thu, 11 Jun 2009 13:35:21 +0300
Message-ID: <4A30DDE9.1050103@compulab.co.il>
References: <4A13F941.7040301@compulab.co.il> <200906020458.56763.dmitry.torokhov@gmail.com> <4A262D5F.1070803@compulab.co.il> <20090611071428.GC8035@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cathcart.site5.com ([74.54.107.137]:54833 "EHLO
	cathcart.site5.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762542AbZFKKfX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Jun 2009 06:35:23 -0400
In-Reply-To: <20090611071428.GC8035@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jean Delvare <khali@linux-fr.org>, grinberg <grinberg@compulab.co.il>, linux-input <linux-input@vger.kernel.org>

Hi Dmitry,

Dmitry Torokhov wrote:
> Hi Mike,
> 
> On Wed, Jun 03, 2009 at 10:59:27AM +0300, Mike Rapoport wrote:
>> This driver supports Synaptics I2C touchpad controller on eXeda
>> mobile device.
>>
>>
> 
> Looks much better, one concern still though:
>  
>> +
>> +/* Work Handler */
>> +static void synaptics_i2c_work_handler(struct work_struct *work)
>> +{
>> +	int data = 1;
>> +	struct synaptics_i2c *touch =
>> +			container_of(work, struct synaptics_i2c, dwork.work);
>> +	unsigned long delay;
>> +
>> +	synaptics_i2c_check_params(touch);
>> +
>> +	do {
>> +		data = synaptics_i2c_get_input(touch);
>> +		delay = synaptics_i2c_fix_delay(touch, data);
>> +	} while (data);
>> +
> 
> This will spin in the work handler for the duration of the touch
> hogging keventd on this CPU and delaying all other scheduled works. I
> don't think we can do that.
> 
> Please try the patchg below and if it still works I will fold it all
> together and queue for upstream. Thanks!
> 

Works Ok. Thanks for cleaning up the style :)

-- 
Sincerely yours,
Mike.

