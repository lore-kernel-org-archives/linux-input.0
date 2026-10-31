Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.166
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793470113;
	b=HbI8Rb3hz1s7XE+euQI2eZggNgwl1wprVPVwxyxLtYvMv02UeXRbiN+uHfAJYDZzJQMS
	 8h+P7uN+artnGQB9BnzVyAgrs1hh2MXPiDIMLEYT3kwzQ15JGBNY+NQKU0v3QN1/jVGYZ
	 QibRtFnvxovdpwcZmEW3bqcXJElumyEytoC1VbplLPUcEvNnkjMCCg826u6mtn/QyjsY9
	 3bVMbR7oPRRjWAIxYQKyMIPfFUUx//OPfn825mLwVbF4BfycGC1Z/bStBtyHcPFg/g46Q
	 ZoN5ktlXbnXiQ4zTnwDPD1hsOHck9uzxtU15VFTL8tvIeUGfBYT7DTCpXiC/KUm/cqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793470113;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=XgZCG9R/Akmn0OUJuILA/AypALbRAk1//GmFGR97Xco=;
	b=Aw+HLW/KXXzOugJqTvwvIv0R2F6SbgK4zcJUIFsqGQned82E71oSdkzJdRatt+j3KzqB
	 n5QL3y/OrZPMEjO7DJs4u4bpl711YbFuQGMZeaoUiLEnbtOdqbKyzxeLdYI00PfBV7mA6
	 f/x2QkL1bO5hIY01G7kS3Sc0zfciS/fEbkSC3xUVMV37e+vWihmoB8nrrPCYFRapSCZIA
	 QRSIb+c5AXdnjlTwUY6SxnP/dCuMGaThJaKyXUpMzHBq9UhjYy9m2J8+IQL9zSrha5AzB
	 c539PnZ6vFYKpsarSF1JiKQi7670ZNA1zFbtY59l9gph8lltLoUArGOqC9fAe0M3E0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jlMU2n2c;
	arc=none smtp.remote-ip=91.218.175.166
Received: from mta0.migadu.com (out-166.mta0.migadu.com [91.218.175.166])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91817606A31C
	for <linux-input@vger.kernel.org>; Sat, 31 Oct 2026 18:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91817606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jlMU2n2c
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=cfafcgkRWi6LPhiG/hGliy6F6QzjtvjOdMcdctWhOqs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793470108; v=1; x=1794074908;
 b=jlMU2n2c71FRjQfuqcooS4ZJMeDQxH7Zsi5jVV712SOSTgp+vAI7miupyJ00uq/ZjFsML2Jj
 oZ8PsZxOxsVOsNUqEj4wyX0wjaO4Z8k8xe59rjgdPZKNYA1XLzaY0pCJEuHSCY4w3Jbbvl4gJJj
 f0o4+Vfk/Hc5vj/15rJxcVns=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9bd23348b99aefe4;
	Sat, 31 Oct 2026 18:08:28 +0000
X-Mizu-Trace-ID: 9bd23348b99aefe4
X-Migadu-Flow: FLOW_OUT
Message-ID: <ce55d8f6-ff34-4ef6-9ee5-59c411fad3fc@linux.dev>
Date: Sat, 31 Oct 2026 19:08:28 +0100
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
Subject: Re: [PATCH v12 01/17] HID: asus: size feature reports from the HID
 report descriptor
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
References: <20261031174130.208240-1-denis.benato@linux.dev>
 <20261031174130.208240-2-denis.benato@linux.dev>
 <sashiko-outbox-192088@kernel.org>
Content-Language: en-US
From: Denis Benato <denis.benato@linux.dev>
In-Reply-To: <sashiko-outbox-192088@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 10/31/26 19:04, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] HID: asus: wrong report ID in mcu_request_version() breaks MCU check
> --
>
> commit 95aa403a07769e0a4dbd2dee41abe2766cd2fe36
> Author: Denis Benato <denis.benato@linux.dev>
>
> HID: asus: size feature reports from the HID report descriptor
>
> This commit derives feature report transfer lengths from the HID report
> descriptor via asus_report_len() instead of using hardcoded sizes across
> asus_kbd_set_report(), asus_kbd_get_report(), mcu_request_version(), and
> asus_xgm_led_set().
>
>> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
>> index f6aa1be09ad53..327bb4ab1a0d6 100644
>> --- a/drivers/hid/hid-asus.c
>> +++ b/drivers/hid/hid-asus.c
> [ ... ]
>> @@ -900,10 +992,15 @@ static int mcu_parse_version_string(const u8 *response, size_t response_size)
>>  
>>  static int mcu_request_version(struct hid_device *hdev)
>>  {
>> -	u8 *response __free(kfree) = kzalloc(ROG_ALLY_REPORT_SIZE, GFP_KERNEL);
>> -	const u8 request[] = { 0x5a, 0x05, 0x03, 0x31, 0x00, 0x20 };
>> +	size_t hw_len = asus_report_len(hdev, FEATURE_REPORT_ID);
>> +	const u8 request[] = { FEATURE_KBD_REPORT_ID, 0x05, 0x03, 0x31, 0x00, 0x20 };
>>  	int ret;
>>  
>> +	if (!hw_len)
>> +		return -EINVAL;
>> +
>> +	u8 *response __free(kfree) = kzalloc(hw_len, GFP_KERNEL);
>> +
>>  	if (!response)
>>  		return -ENOMEM;
>>  
>> @@ -911,17 +1008,16 @@ static int mcu_request_version(struct hid_device *hdev)
>>  	if (ret < 0)
>>  		return ret;
>>  
>> -	ret = hid_hw_raw_request(hdev, FEATURE_REPORT_ID, response,
>> -				ROG_ALLY_REPORT_SIZE, HID_FEATURE_REPORT,
>> -				HID_REQ_GET_REPORT);
>> +	ret = hid_hw_raw_request(hdev, FEATURE_REPORT_ID, response, hw_len,
>> +				 HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
>>  	if (ret < 0)
>>  		return ret;
> [Severity: High]
> Does asus_report_len(hdev, FEATURE_REPORT_ID) return 0 here on ROG Ally and
> ROG Ally X devices?
>
> In drivers/hid/hid-asus.c, FEATURE_REPORT_ID (0x0d) is the I2C touchpad
> multitouch report ID used by asus_start_multitouch(), whereas the ROG Ally
> N-Key vendor HID interface declares feature report 0x5a
> (FEATURE_KBD_REPORT_ID) in its HID report descriptor (and as documented above
> mcu_parse_version_string(), the MCU response payload starts with "5a 05 03 31
> 00 1a 13").
>
> Previously, mcu_request_version() passed a hardcoded ROG_ALLY_REPORT_SIZE (64)
> to hid_hw_raw_request(), which succeeded because usbhid_get_raw_report() does
> not look up the report ID in hdev->report_enum[HID_FEATURE_REPORT].
>
> With this change, when probing USB_DEVICE_ID_ASUSTEK_ROG_NKEY_ALLY or
> USB_DEVICE_ID_ASUSTEK_ROG_NKEY_ALLY_X via:
>
>   asus_probe()
>     -> asus_kbd_register_leds()
>       -> validate_mcu_fw_version()
>         -> mcu_request_version()
>
> looking up FEATURE_REPORT_ID (0x0d) in hdev->report_enum[HID_FEATURE_REPORT]
> via asus_report_len() will not find a report and will return 0, causing
> mcu_request_version() to return -EINVAL. validate_mcu_fw_version() then
> silently aborts without checking the MCU version or configuring MCU powersave:
>
>   version = mcu_request_version(hdev);
>   if (version < 0)
>           return;
>
> Should mcu_request_version() look up FEATURE_KBD_REPORT_ID instead of
> FEATURE_REPORT_ID when sizing the buffer with asus_report_len()?
No, this was reported by my sashiko-bot too and attempting to follow the suggestion
has lead to driver failing and I had to use what's in there now.

