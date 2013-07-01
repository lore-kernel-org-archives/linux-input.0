From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH RESEND v2 2/2] Input: touchscreen: ads7846: add device
 tree bindings
Date: Mon, 01 Jul 2013 08:52:28 +0200
Message-ID: <51D1272C.2020905@gmail.com>
References: <1372626555-29479-1-git-send-email-zonque@gmail.com> <1372626555-29479-2-git-send-email-zonque@gmail.com> <20130701013537.GB10755@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f49.google.com ([209.85.214.49]:60259 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752690Ab3GAGvy (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 1 Jul 2013 02:51:54 -0400
Received: by mail-bk0-f49.google.com with SMTP id mz10so1497590bkb.22
        for <linux-input@vger.kernel.org>; Sun, 30 Jun 2013 23:51:53 -0700 (PDT)
In-Reply-To: <20130701013537.GB10755@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, broonie@kernel.org, grant.likely@linaro.org, agust@denx.de, chf@fritzc.com

Hi Dmirty,

On 01.07.2013 03:35, Dmitry Torokhov wrote:
> On Sun, Jun 30, 2013 at 11:09:15PM +0200, Daniel Mack wrote:
>> +static struct ads7846_platform_data *ads7846_probe_dt(struct device *dev)
>> +{
>> +	struct ads7846_platform_data *pdata = NULL;
>> +	const struct of_device_id *match;
>> +	u32 val;
>> +
>> +	match = of_match_device(ads7846_dt_ids, dev);
>> +	if (!match)
>> +		return NULL;
>> +
>> +	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
>> +	if (!pdata)
>> +		return NULL;
>> +
>> +	pdata->model = (unsigned int) match->data;
> 
> The pointer is long so this conversion does generate compile warnings.
> 
>> +
>> +	if (of_property_read_u32(dev->of_node, "ti,vref-delay-usecs", &val) == 0)
>> +		pdata->vref_delay_usecs = val;
> 
> Why don't we use u16 properties to match the platform data?
> 
> How about the version of the patch below?

Yes, that should work as well, and it looks cleaner. Feel free to commit
your version :) As I said - I don't have access to the hardware anymore,
so I can't give it a real test right now.


Thanks,
Daniel


