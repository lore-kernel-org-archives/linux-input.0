From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v4 2/7] Input: pixcir_i2c_ts: Initialize interrupt mode
 and power mode
Date: Tue, 6 May 2014 11:31:45 +0300
Message-ID: <53689DF1.4070008@ti.com>
References: <1399280678-23925-1-git-send-email-rogerq@ti.com> <1399280678-23925-3-git-send-email-rogerq@ti.com> <20140506051922.GA2608@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140506051922.GA2608@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: rydberg@euromail.se, balbi@ti.com, dmurphy@ti.com, mugunthanvnm@ti.com, nsekhar@ti.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Dmitry,

On 05/06/2014 08:19 AM, Dmitry Torokhov wrote:
> Hi Roger,
> 
> On Mon, May 05, 2014 at 12:04:33PM +0300, Roger Quadros wrote:
>> @@ -192,8 +364,8 @@ static int pixcir_i2c_ts_remove(struct i2c_client *client)
>>  
>>  	device_init_wakeup(&client->dev, 0);
>>  
>> -	tsdata->exiting = true;
>> -	mb();
>> +	if (!tsdata->exiting)
>> +		pixcir_stop(tsdata);
>>  
> 
> I think if we change tsdata->exiting to tsdata->running we won't have to
> do it here. Does the version of the patch below work for you?
> 

The call to pixcir_stop() was not required in the original version as well. It seems
that the root of the problem for remove() and suspend() that I was trying to solve
was in the pixcir_stop() function. i.e. the order of mb() and synchronize_irq();

But I like your version more since "running" reflects the behaviour more accurately
than "exiting".

cheers,
-roger
