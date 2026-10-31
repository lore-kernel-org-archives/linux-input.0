Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793458834;
	b=GPiaQzMOrfZAwvzD36SguMPMiIYkKj4q5o6YCjsbXk7bsgvCQXhlTuYQQQO8GW6CaEVn
	 STSBcBUqZS3Lw8ad3E5AJ7l8hEewhaTWtlymBV5GE1f0jmnIB6qVDJ/FAIX5/M8DF009v
	 lfK2vOke01t40T+5F4ncXPEog00YehoxLkdtb1GfLYnzCRZArxifwzl3sL2lD0oQ4BeXR
	 u/J01yI2PkAFI7RjIY5TDIOEYElTI95cz+RQgUH7UJh9XyvLoLSzA5TnaXNIG5n9nYB3r
	 8l98/6cvnwvZTXXa5LTe1PoqV5msYKXHZwz5hbFFwM/+A0rZ/JgqtsRSpDNsFFHU8/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793458834;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=DZ2qKisAfd6kBS7Hb4eXyimER2yim80WvZ1kMTNmmOw=;
	b=hmmB/fzKhr96uIUtG/u/Nmx41BqcW5fqAnPicaTguTZ8S5n2fmx+E7uDQRenmqnhQt26
	 OTMuOdXOoj8krlpobb6ClENhB7jtnGQlm+x2W9VgRsz/QIQ5ioSf732Lcvr0oE8oaJCd8
	 gMDD89GkuYsKcEBXn0cFACSA4ZpoUbJFaVdtPiU6b4hg7HQjPOJh66hUzjW6sdyLtevV6
	 kv2ZJus06gky5OUlcZoFORfvDlO7TRPALPLMHFz7hEE9cwsuwXgPrSyh5DR2/8CHdLMA/
	 k5bL8tcKdsWSuLR4CUCumhUSMWJR6ciZln8MWPWnMq4bdgSkBVUKaQLQl8feDf1Hb1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=QOQUSlmD;
	arc=none smtp.remote-ip=35.89.44.35
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01CC606A322
	for <linux-input@vger.kernel.org>; Sat, 31 Oct 2026 15:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C01CC606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=QOQUSlmD
Received: from eig-obgw-6004b.ext.cloudfilter.net ([10.0.30.210])
	by cmsmtp with ESMTPS
	id N62Dx5t10usRSNAZMxdxCy; Sat, 31 Oct 2026 15:00:32 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id NAZLx8Osae0duNAZLxho25; Sat, 31 Oct 2026 15:00:31 +0000
X-Authority-Analysis: v=2.4 cv=KINaDEFo c=1 sm=1 tr=0 ts=6ae6028f
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M0FbrtG7MMAA:10 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=ubgQwD8-HD7IqQ9JEJoA:9 a=QEXdDO2ut3YA:10
 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=DZ2qKisAfd6kBS7Hb4eXyimER2yim80WvZ1kMTNmmOw=; b=QOQUSlmDaHGq
	aDl8l6Ng5kL3zJtnaH4xfCpkg0LoVep7eYZo7YC9vvSyEg5QbdjEJ3xj4yRUm9R7JsHgEdDBv+kNs
	fGwGmlwOBrPCK1K3tTYVx+E8NeyzKTgBRoiyyyWpXOHmrbCBcMyWUKxd7jIwduVI0kvC1yQaDfkiz
	/YIVgFA59q2FYIM2R6wYJOE85SwR9ZWNo2/yoK63cCCrtGRxtM2HhBs9MOXZ96iDG5ceiPZ5KJnGL
	7t4DCbBr41DhLVKHZRLKKtSDj+u9G2+g0ifi35Vuo/hLLzwdNVysJBDo+vXv3yQGRM3NDWBYOC6Oz
	I/zrcn36/z3b1qVlVbJ1ng==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:52366)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xNAZL-00000001Rtl-0sj1;
	Sat, 31 Oct 2026 20:30:31 +0530
Message-ID: <388aa474-3606-4c7f-b073-224d5e0880fd@roeck-us.net>
Date: Sat, 31 Oct 2026 08:00:29 -0700
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hwmon: (acer-aspire14-ec) Add driver for Acer Aspire
 14 52MT and 52M fan
To: sashiko-reviews@lists.linux.dev, Ethan Jimmy <duhxu0@gmail.com>,
 linux-hwmon@vger.kernel.org
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
References: <0dee51d4-c153-457a-a3aa-ebf1177df045@roeck-us.net>
 <20261030210037.921646-1-duhxu0@gmail.com> <sashiko-outbox-191513@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <sashiko-outbox-191513@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xNAZL-00000001Rtl-0sj1
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:52366
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 2
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFyKdP/vupChYZQ77uQzWclZyFu5evttPBlS9oye5Nq5IHzXbJYsJaZSyONiVY1d8M5uB0zZVkzw0EhQKnm8oUs3xu69ECexqM1089YBqconWFzKKdHO
 45LOurPZvYqsNI41oPZrirb1iae4dg+UsrMbWVILsmvfONLnQx5IODGfxn6KmM0EfVHI1pehX/uca0gLaWFHNlJUJyd1WgKwHy6BVrNZSsNnCva4LQcoeBKV

Ethan,

On 10/30/26 14:09, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] hwmon: (acer-aspire14-ec) module_init() fails when driver is built-in
> --
> 
> commit 7f4ea74f303f12662cc63822a17eaf3d1e0e84bf
> Author: Ethan Jimmy <duhxu0@gmail.com>
> 
> hwmon: (acer-aspire14-ec) Add driver for Acer Aspire 14 52MT and 52M fan
> 
> This commit adds a hwmon driver for the Acer Aspire 14 AI (A14-52M and
> A14-52MT) fan sensor, which is exposed via an I2C HID embedded controller.
> 
>> diff --git a/drivers/hwmon/acer-aspire14-ec.c b/drivers/hwmon/acer-aspire14-ec.c
>> new file mode 100644
>> index 0000000000000..939b048165c5a
>> --- /dev/null
>> +++ b/drivers/hwmon/acer-aspire14-ec.c
> 
> [ ... ]
> 
>> +static int __init acer_aspire14_init(void)
>> +{
>> +	if (!dmi_check_system(acer_aspire14_dmi_table))
>> +		return -ENODEV;
>> +
>> +	return hid_register_driver(&acer_aspire14_driver);
>> +}
>> +
>> +static void __exit acer_aspire14_exit(void)
>> +{
>> +	hid_unregister_driver(&acer_aspire14_driver);
>> +}
>> +
>> +module_init(acer_aspire14_init);
>> +module_exit(acer_aspire14_exit);
> 
> [Severity: High]
> Does acer_aspire14_init() fail when CONFIG_SENSORS_ACER_ASPIRE14_EC=y and
> CONFIG_HID=y are built into the kernel?
> 
> In drivers/Makefile, drivers/hwmon/ is linked before drivers/hid/:
> 
>    obj-$(CONFIG_HWMON)		+= hwmon/
>    ...
>    obj-$(CONFIG_HID_SUPPORT)	+= hid/
> 
> Because both acer_aspire14_init() and hid_init() in drivers/hid/hid-core.c
> use module_init() (which expands to device_initcall() when built-in),
> acer_aspire14_init() runs before hid_init() registers hid_bus_type.
> 
> On matching DMI systems, the registration call chain:
> 
>    acer_aspire14_init()
>      hid_register_driver(&acer_aspire14_driver)
>        __hid_register_driver()
>          driver_register()
> 
> reaches driver_register() in drivers/base/driver.c before the HID bus is
> initialized:
> 
> 	if (!bus_is_registered(drv->bus)) {
> 		pr_err("Driver '%s' was unable to register with bus_type '%s' because the bus was not initialized.\n",
> 			   drv->name, drv->bus->name);
> 		return -EINVAL;
> 	}
> 
> Should this use late_initcall(acer_aspire14_init) like the other HID drivers
> in drivers/hwmon/ (such as corsair-psu.c, corsair-cpro.c, and nzxt-kraken2.c)
> so that driver registration happens after hid_init()?
> 

That seems to be a real problem. Please fix, or explain why it is a false positive.

Thanks,
Guenter

