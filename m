From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH] Input: atmel_mxt_ts: Add of node type to the i2c table
Date: Thu, 11 Sep 2014 10:38:06 +0200
Message-ID: <54115F6E.3010007@collabora.co.uk>
References: <1410249158-18192-1-git-send-email-sjoerd.simons@collabora.co.uk>	 <540ED495.20609@collabora.co.uk> <20140910092832.GM30307@lee--X1> <1410422429.2857.16.camel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1410422429.2857.16.camel@collabora.co.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Lee Jones <lee.jones@linaro.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Nick Dyer <nick.dyer@itdev.co.uk>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hello Lee,

On 09/11/2014 10:00 AM, Sjoerd Simons wrote:
>> > >  
>> > > -static const struct of_device_id mxt_of_match[] = {
>> > > -	{ .compatible = "atmel,maxtouch", },
>> > > -	{},
>> > > -};
>> > > -MODULE_DEVICE_TABLE(of, mxt_of_match);
>> > > -
>> > >  static const struct i2c_device_id mxt_id[] = {
>> > >  	{ "qt602240_ts", 0 },
>> > >  	{ "atmel_mxt_ts", 0 },
>> > >  	{ "atmel_mxt_tp", 0 },
>> > > +	{ "maxtouch", 0 },
>> > >  	{ "mXT224", 0 },
>> > >  	{ }
>> > >  };
>> > > @@ -2286,7 +2281,6 @@ static struct i2c_driver mxt_driver = {
>> > >  	.driver = {
>> > >  		.name	= "atmel_mxt_ts",
>> > >  		.owner	= THIS_MODULE,
>> > > -		.of_match_table = of_match_ptr(mxt_of_match),
>> > >  		.pm	= &mxt_pm_ops,
>> > >  	},
>> > >  	.probe		= mxt_probe,
>> > > 
>> > 
>> > I see that Lee is working to allow the I2C subsystem to not need an I2C ID
>> > table to match [0]. I'll let Lee to comment what the future plans are and if
>> > his series are going to solve your issue since I'm not that familiar with the
>> > I2C core.
>> 
>> It's wrong to expect DT to probe these devices without a compatible
>> string.  It does so at the moment, but this is a bi-product and not
>> the correct method.
> 
> Ok, which means removing the mxt_of_match table in this patch is wrong..
> I'll fix that for for a V2.
> 
> However that makes adding the "maxtouch" string to the i2c device table
> somewhat cumbersome as it only gets added in this case to ensure
> module-autoloading can happen as the modalias presented to userspace is
> going still going to be i2c:maxtouch.
> 
> Tbh, the bigger problem this is pointing out is that for I2C devices
> with only an OF compability tring module auto-loading is broken...
> 

To expand on what Sjoerd already said and just to be sure everyone is on the
same page.

The problem is that right now the driver reports the following modalias:

# cat /sys/class/i2c-adapter/i2c-8/8-004b/modalias
i2c:maxtouch

but if you look at the module information, that is not a valid alias:

# modinfo atmel_mxt_ts | grep alias
alias:          i2c:mXT224
alias:          i2c:atmel_mxt_tp
alias:          i2c:atmel_mxt_ts
alias:          i2c:qt602240_ts
alias:          of:N*T*Catmel,maxtouch*

which means that udev/kmod can't load the module automatically based on the
alias information.

The aliases are filled by both MODULE_DEVICE_TABLE(i2c, mxt_id) and
MODULE_DEVICE_TABLE(of, mxt_of_match) so after Sjoerd's patch:

# cat /sys/class/i2c-adapter/i2c-8/8-004b/modalias
i2c:maxtouch

# modinfo atmel_mxt_ts | grep alias
alias:          i2c:mXT224
alias:          i2c:maxtouch
alias:          i2c:atmel_mxt_tp
alias:          i2c:atmel_mxt_ts
alias:          i2c:qt602240_ts

which matches the reported uevent so the module will be auto-loaded.

This is because the I2C subsystem hardcodes i2c:<client->name>, if you look at
drivers/i2c/i2c-core.c:

/* uevent helps with hotplug: modprobe -q $(MODALIAS) */
static int i2c_device_uevent(struct device *dev, struct kobj_uevent_env *env)
{
...
        if (add_uevent_var(env, "MODALIAS=%s%s",
                           I2C_MODULE_PREFIX, client->name))
...
}

I've looked at Lee's series and AFAICT that remains the same so I second
Sjoerd that module auto-loading will continue to be broken.

Best regards,
Javier
