Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C512F656E;
	Thu, 29 Jan 2026 18:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769712042; cv=none; b=GTseaBxesApAEKjQDPgOctQrg73KmEybrpaS6J52eriWZHd/qpLd0YzDjIjk/cN24hIATzW4VIqOUsudQn4vbODQIwmjUfMKOiD0y67M1/F3amZzTjCO3w1kEAvBXapriBsIll5SMl45vledqW6iNJPnNyti8x4rYG/fFwYh7ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769712042; c=relaxed/simple;
	bh=bTvM2/HxO9mIy6o0cn+cX0T4A+OJCgLgLFcjHz1i35E=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To; b=E/3uNozOP2aFuMYMHNa8Alm0/8xmav3T9AiBcv4+OzLn5396VoyT6CLjiF/sEvMW0nUHtfNCivyeUGXWhv0+x9NahzGMhbzcfoH9DCk8rLmsrjBT9jW01so1JN0zFPzKZNnH7IReicZ8URXUq8l68BR5kBP5p+0bC53SVMgZ/zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHQJ2T2G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHQJ2T2G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E313C4CEF7;
	Thu, 29 Jan 2026 18:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769712041;
	bh=bTvM2/HxO9mIy6o0cn+cX0T4A+OJCgLgLFcjHz1i35E=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=cHQJ2T2GKztJVOtZE9bXB0pDdpdinSybGz4Jtkxo0l5lKVxUncZ0b05u1IRxaN3PN
	 22/LPF1vNwYDCmuosOTB1cmmDT3GENmiekCzWcxNDqvxmPJhHn6kZe8PJ81pQJvP8J
	 ZQw4SgA3nNeyjpAuAV17uNuLwdhJ7+KKvuqWJMq+FbPdmPTBgcu1J2v430uPnwgSF/
	 d7MxXshs0oUUIuzueHtSyU3tCWo/wOOsvcHROg6cIYXzEZIsWjppS30hTDHGRBYSx2
	 eam1XHIvN1Q9Bmurtb0APyjfmIpP/HvO2tdzVwCpAayeSSlxWg9vGx9RbuEwNpbtW3
	 6HRJkj51HsKUg==
Content-Type: multipart/mixed; boundary="------------iRWXmoynDoIFPTairYNxY6yd"
Message-ID: <0840e4ec-0b61-4e0d-9d67-d0eb2ab2d6a1@kernel.org>
Date: Thu, 29 Jan 2026 19:40:39 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Input: goodix - fix inverted Y coordinate on SUPI S10
From: Hans de Goede <hansg@kernel.org>
To: Yajat Kumar <yajatapps3@gmail.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 "open list:GOODIX TOUCHSCREEN" <linux-input@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20251230221639.582406-1-yajatapps3@gmail.com>
 <fa17c5bb-9ab9-46f7-86fb-c06e09617279@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <fa17c5bb-9ab9-46f7-86fb-c06e09617279@kernel.org>

This is a multi-part message in MIME format.
--------------iRWXmoynDoIFPTairYNxY6yd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Yajat,

On 11-Jan-26 22:30, Hans de Goede wrote:
> Hi Yajat,
> 
> On 30-Dec-25 23:16, Yajat Kumar wrote:
>> The touchscreen on the SUPI S10 reports inverted Y coordinates, causing
>> touch input to be mirrored vertically relative to the display.
>>
>> Add a DMI-based quirk to invert the Y coordinate on this device so that
>> touch input matches the display orientation.
>>
>> Tested on SUPI S10 tablet with Goodix touchscreen controller.
>>
>> Signed-off-by: Yajat Kumar <yajatapps3@gmail.com>
> 
> Thank you for your patch. This kind of quirks really belong
> in drivers/platform/x86/touchscreen_dmi.c instead of in individual
> touchscreen drivers.
> 
> The inverted_x_screen[] DMI quirk is a left-over from before we
> moved these quirks to touchscreen_dmi.c and unfortunately we cannot
> move this because we've not been able to find someone to test this.
> 
> I've attached a patch which should fix the issue using
> touchscreen_dmi.c . Note you may need to change the GDIX1001 in
> the patch to GDIX1002, see "ls /sys/bus/i2c/devices" to see which
> ACPI HID your touchscreen is using.
> 
> Can you please test the attached patch ?

Can you please confirm if the attached patch works, or at
a minimum check if the touchscreen is listed as i2c-GDIX1001:*
or i2c-GDIX1002:* under /sys/bus/i2c/devices ?

Regards,

Hans




>> ---
>>  drivers/input/touchscreen/goodix.c | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>
>> diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
>> index f8798d11ec03..d675a85a9312 100644
>> --- a/drivers/input/touchscreen/goodix.c
>> +++ b/drivers/input/touchscreen/goodix.c
>> @@ -160,6 +160,22 @@ static const struct dmi_system_id inverted_x_screen[] = {
>>  	{}
>>  };
>>  
>> +/*
>> + * Those tablets have their y coordinate inverted
>> + */
>> +static const struct dmi_system_id inverted_y_screen[] = {
>> +#if defined(CONFIG_DMI) && defined(CONFIG_X86)
>> +	{
>> +		.ident = "SUPI S10",
>> +		.matches = {
>> +			DMI_MATCH(DMI_SYS_VENDOR, "SUPI"),
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "S10")
>> +		},
>> +	},
>> +#endif
>> +	{}
>> +};
>> +
>>  /**
>>   * goodix_i2c_read - read data from a register of the i2c slave device.
>>   *
>> @@ -1212,6 +1228,12 @@ static int goodix_configure_dev(struct goodix_ts_data *ts)
>>  			"Applying 'inverted x screen' quirk\n");
>>  	}
>>  
>> +	if (dmi_check_system(inverted_y_screen)) {
>> +		ts->prop.invert_y = true;
>> +		dev_dbg(&ts->client->dev,
>> +			"Applying 'inverted y screen' quirk\n");
>> +	}
>> +
>>  	error = input_mt_init_slots(ts->input_dev, ts->max_touch_num,
>>  				    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
>>  	if (error) {

--------------iRWXmoynDoIFPTairYNxY6yd
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-platform-x86-touchscreen_dmi-Add-quirk-for-y-inverte.patch"
Content-Disposition: attachment;
 filename*0="0001-platform-x86-touchscreen_dmi-Add-quirk-for-y-inverte.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA0M2FhZTBhNTQ1MTAzMTk0MzgzNjUxNmZmNTQxYzlhYjEyMzJlNmI5IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIYW5zIGRlIEdvZWRlIDxqb2hhbm5lcy5nb2VkZUBv
c3MucXVhbGNvbW0uY29tPgpEYXRlOiBTdW4sIDExIEphbiAyMDI2IDIyOjI1OjU4ICswMTAw
ClN1YmplY3Q6IFtQQVRDSF0gcGxhdGZvcm0veDg2OiB0b3VjaHNjcmVlbl9kbWk6IEFkZCBx
dWlyayBmb3IgeS1pbnZlcnRlZAogR29vZGl4IHRvdWNoc2NyZWVuIG9uIFNVUEkgUzEwCgpU
aGUgdG91Y2hzY3JlZW4gb24gdGhlIFNVUEkgUzEwIHRhYmxldCByZXBvcnRzIGludmVydGVk
IFkgY29vcmRpbmF0ZXMsCmNhdXNpbmcgdG91Y2ggaW5wdXQgdG8gYmUgbWlycm9yZWQgdmVy
dGljYWxseSByZWxhdGl2ZSB0byB0aGUgZGlzcGxheS4KCkFkZCBhIHF1aXJrIHRvIHNldCB0
aGUgInRvdWNoc2NyZWVuLWludmVydGVkLXkiIGJvb2xlYW4gZGV2aWNlLXByb3BlcnR5Cm9u
IHRoZSB0b3VjaHNjcmVlbiBkZXZpY2UsIHNvIHRoYXQgdGhlIGdvb2RpeF90cyBkcml2ZXIg
d2lsbCBmaXh1cAp0aGUgY29vcmRpbmF0ZXMuCgpSZXBvcnRlZC1ieTogWWFqYXQgS3VtYXIg
PHlhamF0YXBwczNAZ21haWwuY29tPgpDbG9zZXM6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2xpbnV4LWlucHV0LzIwMjUxMjMwMjIxNjM5LjU4MjQwNi0xLXlhamF0YXBwczNAZ21haWwu
Y29tLwpTaWduZWQtb2ZmLWJ5OiBIYW5zIGRlIEdvZWRlIDxqb2hhbm5lcy5nb2VkZUBvc3Mu
cXVhbGNvbW0uY29tPgotLS0KIGRyaXZlcnMvcGxhdGZvcm0veDg2L3RvdWNoc2NyZWVuX2Rt
aS5jIHwgMTggKysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0
aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L3RvdWNoc2NyZWVu
X2RtaS5jIGIvZHJpdmVycy9wbGF0Zm9ybS94ODYvdG91Y2hzY3JlZW5fZG1pLmMKaW5kZXgg
YmRjMTljZDhkM2VkLi5kODNjMzg3ODIxZWEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcGxhdGZv
cm0veDg2L3RvdWNoc2NyZWVuX2RtaS5jCisrKyBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L3Rv
dWNoc2NyZWVuX2RtaS5jCkBAIC00MTAsNiArNDEwLDE2IEBAIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgdHNfZG1pX2RhdGEgZ2RpeDEwMDJfdXBzaWRlX2Rvd25fZGF0YSA9IHsKIAkucHJvcGVy
dGllcwk9IGdkaXgxMDAxX3Vwc2lkZV9kb3duX3Byb3BzLAogfTsKIAorc3RhdGljIGNvbnN0
IHN0cnVjdCBwcm9wZXJ0eV9lbnRyeSBnZGl4MTAwMV95X2ludmVydGVkX3Byb3BzW10gPSB7
CisJUFJPUEVSVFlfRU5UUllfQk9PTCgidG91Y2hzY3JlZW4taW52ZXJ0ZWQteSIpLAorCXsg
fQorfTsKKworc3RhdGljIGNvbnN0IHN0cnVjdCB0c19kbWlfZGF0YSBnZGl4MTAwMV95X2lu
dmVydGVkX2RhdGEgPSB7CisJLmFjcGlfbmFtZQk9ICJHRElYMTAwMSIsCisJLnByb3BlcnRp
ZXMJPSBnZGl4MTAwMV95X2ludmVydGVkX3Byb3BzLAorfTsKKwogc3RhdGljIGNvbnN0IHN0
cnVjdCBwcm9wZXJ0eV9lbnRyeSBncF9lbGVjdHJvbmljX3Q3MDFfcHJvcHNbXSA9IHsKIAlQ
Uk9QRVJUWV9FTlRSWV9VMzIoInRvdWNoc2NyZWVuLXNpemUteCIsIDk2MCksCiAJUFJPUEVS
VFlfRU5UUllfVTMyKCJ0b3VjaHNjcmVlbi1zaXplLXkiLCA2NDApLApAQCAtMTY1OCw2ICsx
NjY4LDE0IEBAIGNvbnN0IHN0cnVjdCBkbWlfc3lzdGVtX2lkIHRvdWNoc2NyZWVuX2RtaV90
YWJsZVtdID0gewogCQkJRE1JX01BVENIKERNSV9QUk9EVUNUX1NLVSwgIlBOMjAxNzA0MTM0
ODgiKSwKIAkJfSwKIAl9LAorCXsKKwkJLyogU1VQSSBTMTAgKi8KKwkJLmRyaXZlcl9kYXRh
ID0gKHZvaWQgKikmZ2RpeDEwMDFfeV9pbnZlcnRlZF9kYXRhLAorCQkubWF0Y2hlcyA9IHsK
KwkJCURNSV9NQVRDSChETUlfU1lTX1ZFTkRPUiwgIlNVUEkiKSwKKwkJCURNSV9NQVRDSChE
TUlfUFJPRFVDVF9OQU1FLCAiUzEwIiksCisJCX0sCisJfSwKIAl7CiAJCS8qIFRlY2hiaXRl
IEFyYyAxMS42ICovCiAJCS5kcml2ZXJfZGF0YSA9ICh2b2lkICopJnRlY2hiaXRlX2FyY18x
MV82X2RhdGEsCi0tIAoyLjUyLjAKCg==

--------------iRWXmoynDoIFPTairYNxY6yd--
