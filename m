From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH] Input: don't push static constants on stack for %*ph
Date: Thu, 17 Dec 2015 17:16:35 +0000
Message-ID: <5672EDF3.50001@itdev.co.uk>
References: <1378291309-13869-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1449755217.30729.99.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from zencphosting06.zen.co.uk ([82.71.204.9]:45856 "EHLO
	zencphosting06.zen.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563AbbLQSiQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Dec 2015 13:38:16 -0500
In-Reply-To: <1449755217.30729.99.camel@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> On Wed, 2013-09-04 at 13:41 +0300, Andy Shevchenko wrote:
>> There is no need to pass constants via stack. The width may be
>> explicitly
>> specified in the format.
> 
> Dmitry, any comments on this?

Hi Andy-

Just to weigh in on the atmel_mxt_ts part - it's made moot by:
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/input/touchscreen/atmel_mxt_ts.c?id=5f3f9bc2b1f3a09e732df

regards

Nick

> 
>>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>>  drivers/input/mouse/hgpk.c               | 7 +++----
>>  drivers/input/touchscreen/atmel_mxt_ts.c | 4 ++--
>>  2 files changed, 5 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/input/mouse/hgpk.c b/drivers/input/mouse/hgpk.c
>> index 62be888..27909a1 100644
>> --- a/drivers/input/mouse/hgpk.c
>> +++ b/drivers/input/mouse/hgpk.c
>> @@ -333,9 +333,8 @@ static bool hgpk_is_byte_valid(struct psmouse
>> *psmouse, unsigned char *packet)
>>  	}
>>  
>>  	if (!valid)
>> -		psmouse_dbg(psmouse,
>> -			    "bad data, mode %d (%d) %*ph\n",
>> -			    priv->mode, pktcnt, 6, psmouse->packet);
>> +		psmouse_dbg(psmouse, "bad data, mode %d (%d)
>> %6ph\n",
>> +			    priv->mode, pktcnt, psmouse->packet);
>>  
>>  	return valid;
>>  }
>> @@ -1027,7 +1026,7 @@ static enum hgpk_model_t hgpk_get_model(struct
>> psmouse *psmouse)
>>  		return -EIO;
>>  	}
>>  
>> -	psmouse_dbg(psmouse, "ID: %*ph\n", 3, param);
>> +	psmouse_dbg(psmouse, "ID: %3ph\n", param);
>>  
>>  	/* HGPK signature: 0x67, 0x00, 0x<model> */
>>  	if (param[0] != 0x67 || param[1] != 0x00)
>> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c
>> b/drivers/input/touchscreen/atmel_mxt_ts.c
>> index 59aa240..dd44ebf 100644
>> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
>> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
>> @@ -331,8 +331,8 @@ static bool mxt_object_writable(unsigned int
>> type)
>>  static void mxt_dump_message(struct device *dev,
>>  			     struct mxt_message *message)
>>  {
>> -	dev_dbg(dev, "reportid: %u\tmessage: %*ph\n",
>> -		message->reportid, 7, message->message);
>> +	dev_dbg(dev, "reportid: %u\tmessage: %7ph\n",
>> +		message->reportid, message->message);
>>  }
>>  
>>  static int mxt_check_bootloader(struct i2c_client *client,
> 

