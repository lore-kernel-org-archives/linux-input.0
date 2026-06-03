Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF97395DBF;
	Wed,  3 Jun 2026 13:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780492329; cv=none; b=PncLrF8Gt7M3F8bWzfH01ZmpH1xgOLacOUPkWUjWfnJrl1azT3gk9uy6KV2o7SxOpHWa3AFC4F7vXH6DRMHWq/Ozis9vlXKMeDrq8H8q5GZsS57K2/AsKvOnMu19nFfS6Pic9YBJTYTLF3hLYszoOqWp0uhk1dCnx8wRtJAPK4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780492329; c=relaxed/simple;
	bh=zGbTXtImyovHRSDR1Ho+sO5xbEl/W8rYqhUOLlFXSdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VS79n7DVoRvcfX86z6bUB+7T8TZmQoPd/eSJ+xTwdXAHX+1dM5W58NR/tIN4n/c4xUc4AUWwXfbOLO9uR97EknFpoJOLE5+kGZUBwmsdX+4XMDwha5Gj2vc75pTxfe/aF7GVppNJqRcGQB9GwKO+o89N3TYyEkfF1nHmjL4m63w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orDcu8Qs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orDcu8Qs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A61531F00893;
	Wed,  3 Jun 2026 13:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780492328;
	bh=/AJ+Ng/F9cKvqOU0o6ibcHTFrm5QGDsss/BJaa2P3qc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=orDcu8QsnNwKYqKu954HGUGy/2++TDWmvAU1SOishiDLcYYgHE0i6Ywvw+fkuR14B
	 nRIlzMYPJPdP3ih+Wxb812dYS4H3kPWUip6T+VxZqVO3jEeXKKMgQJJXU1/JPmy0FI
	 vEfWlc3tnTTyA7UY1qUkBrIBZNachLOHenEoLglIR0fXKeQPGjtFZLDFP5Lpe0Qes4
	 X5Yw/3nvtNBu85F8uPz87mZ/+Z/HlcWocUyPkuFt6ISg7cKTxm4NAEG0Uzq+ffcxhm
	 nZSeI4v+16+2URUo4AUCUsH9EthafVe7rQJZzvfsYAqNpTmSZHsq/SdZNRtcyB8Ba/
	 zxenJPULjZDRQ==
Message-ID: <45b88710-7c67-414d-8ebc-2abafa80a760@kernel.org>
Date: Wed, 3 Jun 2026 15:12:04 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] HID: i2c-hid: Move common ACPI _DSM helper into
 core
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: =?UTF-8?B?6LCi6Ie06YKmIChYSUUgWmhpYmFuZyk=?= <Yeking@red54.com>,
 linux-input@vger.kernel.org, dmitry.torokhov@gmail.com,
 dianders@chromium.org, jikos@kernel.org, linux-kernel@vger.kernel.org,
 superm1@kernel.org, Pin-yen Lin <treapking@chromium.org>,
 Xu Rao <raoxu@uniontech.com>, Kwok Kin Ming <kenkinming2002@gmail.com>,
 Dan Carpenter <error27@gmail.com>
References: <ahnqMMhD8jn51ch7@google.com>
 <20260601181510.38705-1-Yeking@Red54.com>
 <tencent_71AA07C8BAF64FE0F9B0FDFC072BB08B3605@qq.com>
 <ah_2JXN7AAos4kjM@beelink> <7ff8529d-6b20-4088-aa10-77b304da49b4@kernel.org>
 <aiAW9sSLVqmT6l87@beelink>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <aiAW9sSLVqmT6l87@beelink>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 3-Jun-26 1:59 PM, Benjamin Tissoires wrote:
> On Jun 03 2026, Hans de Goede wrote:
>> Hi Benjamin,
>>
>> On 3-Jun-26 11:43 AM, Benjamin Tissoires wrote:
>>> On Jun 01 2026, 谢致邦 (XIE Zhibang) wrote:
>>>> Move the _DSM call that gets the HID descriptor address from
>>>> i2c-hid-acpi.c to a shared helper in i2c-hid-core.c so both
>>>> i2c-hid-acpi.c and i2c-hid-of.c can use it.
>>>>
>>>> Signed-off-by: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
>>>> ---
>>>>  drivers/hid/i2c-hid/i2c-hid-acpi.c | 32 ++++-----------------------
>>>>  drivers/hid/i2c-hid/i2c-hid-core.c | 35 ++++++++++++++++++++++++++++++
>>>
>>> I'm not a big fan of removing 25% of the i2c-hid-acpi.c code and inject
>>> it in i2c-hid-core.c.
>>
>> It is only 35 new lines in i2c-hid-core.c, so it is not that big / much code.
> 
> My concern is not so much about these 35 lines of code, but the fact
> that i2c-hid-acpi.c is now down to only 3 functions:
> - i2c_hid_acpi_probe()
> - i2c_hid_acpi_shutdown_tail()
> - i2c_hid_acpi_restore_sequence()
> 
> So then, what's the point of keeping it as a separate driver? (more
> rethorical question than anything).
> 
>>
>>> There's something I can't really understand in the problem:
>>> - we are talking about non arm architecture, which should not have OF in
>>> 	them
>>> - the current compatible hid-over-i2c loads the OF version?
>>> - how can you make the device working without the couple of ACPI
>>> 	functions that are in the i2c-hid-acpi.c driver for powering up and
>>> 	down the device?
>>>
>>> If the platform is indeed ACPI + x86(_64), then shouldn't we tackle the
>>> problem in the i2c-hid-acpi driver, or add a secondary leaf driver for
>>> this particular platform/device? Kind of what we have with
>>> i2c-hid-of-elan.c
>>
>> As part of the work to use ACPI on ARM systems, it is possible now a days
>> to inject DT snippets into ACPI tables.
>>
>> The problem on these Loongson laptops is that they have created this
>> very ugly mixed-mode where they put a PRP0001 ACPI HID on the ACPI
>> node for the touchscreen, which means it contains an embedded DT
>> snippet and in that snipped out "compatible=hid-over-i2c" but NOT
>> also "i2c-hid-descr-addr=x". To get the i2c-hid descriptor address
>> the implemented the ACPI _DSM on the same ACPI device/fwnode.
>>
>> The ACPI core sees HID=PRP0001 so it creates an of-compatible 
>> modalias / match and not an ACPI one, so the i2c-hid-of driver will
>> bind.
> 
> But if this fix is for just one platform, why not keeping the design
> clean and have a dmi_match instead in a separate driver, like the
> i2c-hid-of-elan does for Elan touchpads/touchscreens?
> i2c-hid-acpi-loongson.c for instance.

Ok, so let me see if I've got this right:

1. We create a i2c-hid-acpi-loongson.c with a DMI
MODULE_DEVICE_TABLE() for auto-module-loading

2. This will have a struct of_device_id table with
the "hid-over-i2c" compatible. But *no* / without a
MODULE_DEVICE_TABLE() for this so that it will not
autoload on regular DT platforms with regular
"hid-over-i2c" compatible touchscreens.

3. We will rely on i2c-hid-of.c error-ing out
due to the missing "hid-descr-addr" and we are ok
with the dev_err() this logs.

4. The new i2c-hid-acpi-loongson.c will in essence
be a copy of i2c-hid-acpi.c without the acpi_match
and with the DMI id + of match as described above.

Yes I think that should work, do you want to just copy
i2c_hid_acpi_get_descriptor() or do you want
i2c-hid-acpi to export this and have i2c-hid-acpi-longsoon
depend on i2c-hid-acpi for this ?

>> Note these "fixed" (as in we cannot fix them) ACPI tables use
>> the generic i2c-over-hid OF/DT compatible _not_ something
>> more specific so we can also not do a more specific driver like
>> i2c-hid-of-elan.c.
> 
> Do they use anything else than the compatible DT entry? regulators and
> others? If not, then the device is pure ACPI, and should not be handled
> by i2c-hid-of.c at all, no?

No they don't use anything other then the compatible. This is
really just a very bad / messy decision by whomever created
the ACPI tables for these 2 laptops. But they are out there, so
we somehow have to deal with them.

<snip>

> so far :)

True, see above.

Regards,

Hans



