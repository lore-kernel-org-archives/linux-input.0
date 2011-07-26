From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Subject: Re: [PATCH] drivers:input:set driver data to NULL for pcap_keys
Date: Tue, 26 Jul 2011 13:36:00 +0800
Message-ID: <4E2E5240.4060309@cn.fujitsu.com>
References: <1311176068-9934-1-git-send-email-wanlong.gao@gmail.com> <20110725083048.GD22937@core.coreip.homeip.net> <4E2D33E3.9090408@cn.fujitsu.com> <20110725152106.GB23356@suse.de> <1311608069.3262.8.camel@Allen> <20110725181916.GB6876@core.coreip.homeip.net> <20110725182928.GB1175@sirena.org.uk> <20110725183746.GD6876@core.coreip.homeip.net> <4E2E1897.9020808@cn.fujitsu.com> <20110726043949.GA27720@suse.de>
Reply-To: gaowanlong@cn.fujitsu.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:63025 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750860Ab1GZFhA (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Jul 2011 01:37:00 -0400
In-Reply-To: <20110726043949.GA27720@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Wanlong Gao <wanlong.gao@gmail.com>, linux-input@vger.kernel.org

On 07/26/2011 12:39 PM, Greg KH wrote:

>> +
>> +	if (drv->remove) {
>> +		dev_dbg(_dev, "remove\n");
>> +		status = drv->remove(dev);
>> +	} else {
>> +		status = 0;
>> +	}
>
> Again, why would remove ever be NULL?
>
> This whole thing isn't needed at all.
>
> greg k-h
Yeah, I see.

But Greg, why does i2c-core do this?
like:drivers/i2c/i2c-core.c:
static int i2c_device_remove(struct device *dev)
{
	struct i2c_client	*client = i2c_verify_client(dev);
	struct i2c_driver	*driver;
	int			status;

	if (!client || !dev->driver)
		return 0;

	driver = to_i2c_driver(dev->driver);
	if (driver->remove) {
		dev_dbg(dev, "remove\n");
		status = driver->remove(client);
	} else {
		dev->driver = NULL;
		status = 0;
	}
	if (status == 0) {
		client->driver = NULL;
		i2c_set_clientdata(client, NULL);
	}
	return status;
}

And now, I'm in a fog, can you clear me/us ?

-- 
Thanks
Best Regards
Wanlong Gao
