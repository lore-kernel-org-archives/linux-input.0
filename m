From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v3 1/7] Input: pixcir_i2c_ts: Use devres managed resource
 allocations
Date: Mon, 5 May 2014 11:44:10 +0300
Message-ID: <53674F5A.3080006@ti.com>
References: <1398861392-8959-1-git-send-email-rogerq@ti.com> <1398861392-8959-2-git-send-email-rogerq@ti.com> <20140430163041.GB13624@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140430163041.GB13624@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: rydberg@euromail.se, balbi@ti.com, dmurphy@ti.com, mugunthanvnm@ti.com, nsekhar@ti.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 04/30/2014 07:30 PM, Dmitry Torokhov wrote:
> Hi Roger,
> 
> On Wed, Apr 30, 2014 at 03:36:26PM +0300, Roger Quadros wrote:
> 
>>  static int pixcir_i2c_ts_remove(struct i2c_client *client)
>> @@ -198,10 +194,8 @@ static int pixcir_i2c_ts_remove(struct i2c_client *client)
>>  
>>  	tsdata->exiting = true;
>>  	mb();
>> -	free_irq(client->irq, tsdata);
>>  
>>  	input_unregister_device(tsdata->input);
> 
> There is no need to call input_unregister_device for managed input
> devices.

OK. I'll remove that.

> 
>> -	kfree(tsdata);
>>  
>>  	return 0;
>>  }

cheers,
-roger
