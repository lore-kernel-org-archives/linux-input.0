Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A3838F620
	for <linux-input@vger.kernel.org>; Mon,  2 Mar 2026 09:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772443205; cv=none; b=qZNkX3xSLVHY+1NCN7SH/1BURk+F7xVFm+Kp+OjP40rRbA/Yds8fSpAVxPUmtHyVhY+DdkEif/Ei/4HoeQOEK5GxcGdD1mTjsSurejmB5giS1H6nL5rTy+nDbp1yVvLvd916cpQIbRiTHdjASOYLFkeFRQJ+/5Uv4l/PVPw3Dws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772443205; c=relaxed/simple;
	bh=1wjljxdQgHZG5jEbJ5rMMGvrifs82k42XfZuW+8ulaA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=P2jXabGPCENXcgsAgWne87GK3nApWN7FXESxFvJcAMOjn+Uemh8vYm7tu2vOTacChXoErO1r/qyvkHwSP4D4u3pf+oeLmCguQ6g6i8p14g7Km34F4+SZb7NwLcR7yCryTlesBrEc3SrApYcWYEgxGRxrgymJ/WfUwM2YdEq7zHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H0HSre4I; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hr4iqgOt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H0HSre4I";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hr4iqgOt"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6226hC8I2504662
	for <linux-input@vger.kernel.org>; Mon, 2 Mar 2026 09:20:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BUMEmWW6k8+1LjgIepaaWVMeH2jkLf3X3sWVN7xqrr8=; b=H0HSre4I7A3ezHCn
	Q7XafmwasK7FH3Dbt+jlxcRRWFp1HNCx+bYmHFIbSOfoCGZTXPJfk3a6Ia2qrGdm
	rpapASOLrszuOAvtNpsN8p8FE7uAQ4YScVulrtkPW6L18nzynyEc8NNB/HEJ/mQG
	hlxxvBdNLVE9hSvGCXBm4i+S1X7bIpqt0P5RyURNDpzSkNUS1e7mT0MG4VWkL2Lp
	QTB69agvAmfZoyZoX2KPNSPy4ed9HpYEk/mxrcOn3PZkEf5sB6fl5YCOZb2qEekm
	ZGf6S1tryxEKJvAgU28uRw5mMw8nH48qG2mjfHAENr7QdINC6o0LrazQIXm06Pki
	3UxNSw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn5herjtp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Mon, 02 Mar 2026 09:20:02 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cb4e37a796so3095300885a.2
        for <linux-input@vger.kernel.org>; Mon, 02 Mar 2026 01:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772443202; x=1773048002; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BUMEmWW6k8+1LjgIepaaWVMeH2jkLf3X3sWVN7xqrr8=;
        b=hr4iqgOtIhED/oZEW5UxGRZhAFEqDRVyXJIWFllEPDssizIpMJvou/1eE6xvl6n+K9
         Z8VwCU0loVrkYLSEom5XTdNs8bIeQoCFHWkcUUURBEiKC5QEsGN4YJnY9lkc+NBp12yN
         SQkUzZjpBa0Xv1kOBHwRI2g3ZB2AH5QnnQvPq0VATb9zTEL4JMaBS/+9XLbgFHQQ99FZ
         e3aoVrAJ0R8V9v0tZIfw+BdSLoZvl+k3NksBOF57A0XkaTu9B1CtdiB9uBKYthCQpW47
         09bclWW3+XHOoUlEfUvcivMLIqpaEZhdl9mnFlEkVWMH8JjNqnjvWqyQQy0zNgifK1dR
         f50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772443202; x=1773048002;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BUMEmWW6k8+1LjgIepaaWVMeH2jkLf3X3sWVN7xqrr8=;
        b=CRGqLIFWgDE9leeGXWJdcu7AduDQyslSgSZY4WfM9ltY6FX4/xCvnWrT7pLiLzSgkS
         Enk+XN3+q+8wgCSNBnK3q9QiFwaiaKKfoPSl16Uuru6S48C7jjA5eANKJQG5sGz+LgAP
         wVkRN6s6EknTfXithqC2OxlI43Ro4vwOQ67x7jyWha3Vg8vxAeF//f8/CShsBCHta6JO
         JcI4PjfaognF5FlmBGY1aJr1HJGFqd7vsX1K3xU/qFxbeccwnO+WYgXRurpY0tQ8tEnh
         virIDUxwtPlyLnwxUOaaLELZtijX45N7j/xN6KcVxiRTLkLIZUPvn+EmP9WqENwTMkAO
         7SjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXp0/cnEG9kvPVYCyUuX+EUhn+qt9LolTwISSFiETooUvcZPxBLQ4iXqv4TeyCWZmpzw77jQd9GaDU+sg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgnbg5I6LKhNVdyOyHx2Mg8hNZ1mQNlK4EO+IYCtLJ8LzwE61D
	8OLyhFkcD4wsnYxC9OKq8jI/Ga6KjN8EcC23yvYJIprUMOXB5o7j5wQUeIL35AvU60xvha8VoJr
	Pb15usHB9Ay4Ys8xyjmzw54dSFAURvFNEcrTKwNrb3pRxBhaK9tK1Rf9Jsy+9sMtIGQ==
X-Gm-Gg: ATEYQzzhBWR3pH779teBKVSdlzhYft4TGtdYJy1oRrNVwqjhMxStm7XobbYQMuNhDK7
	5MlKbSai3KY4hY6NPorTDiy/HrIzqh8VCTKYffCW0u69i6DxbFwZoE3FrbhnyA5sq1MWD8A+H7t
	qcgsZ6b9BK0nUA5esGi6688uWjSosMv+kmBXsBoYnU6wQxUgfmQ30gMoGcIG3DUl92b+Nu8wi0N
	z0IPqfpobbPqZNz0prv8ZTp/uNpMeNFb3gmauyJzIMemZZZvLAAJ+Q4mGDX8xl59wMRpQ0o+c52
	7C865xgo/Qt7yKuUQwoifFbQl0D4smiuJXNKAQRXwKwFeaaZQnliDo3Fv+fFAAV0tk4g8mbMnyf
	KSa5BGv0NS5gvzhTOLRZ3xI9SvhmTrNINNuKewV99
X-Received: by 2002:a05:620a:4590:b0:8b2:e9d2:9c69 with SMTP id af79cd13be357-8cbc8d7b815mr1466044585a.22.1772443201877;
        Mon, 02 Mar 2026 01:20:01 -0800 (PST)
X-Received: by 2002:a05:620a:4590:b0:8b2:e9d2:9c69 with SMTP id af79cd13be357-8cbc8d7b815mr1466042585a.22.1772443201382;
        Mon, 02 Mar 2026 01:20:01 -0800 (PST)
Received: from [10.40.99.10] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66003d5ca55sm1818984a12.28.2026.03.02.01.20.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 01:20:00 -0800 (PST)
Message-ID: <06d2504d-2b66-4ae7-94ec-8c062a8c15dc@oss.qualcomm.com>
Date: Mon, 2 Mar 2026 10:19:59 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] HID: input: Add HID_BATTERY_QUIRK_DYNAMIC for Elan
 touchscreens
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, ggrundik@gmail.com
References: <20260228145258.76937-1-johannes.goede@oss.qualcomm.com>
 <20260228145258.76937-2-johannes.goede@oss.qualcomm.com>
 <aaTZIcPuY3qz5MJm@google.com>
Content-Language: en-US, nl
In-Reply-To: <aaTZIcPuY3qz5MJm@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=BI++bVQG c=1 sm=1 tr=0 ts=69a55642 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=rrvG0T/C2D967D07Ol03YQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=wpff9h21woqoOr_UaUIA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: 03AX4kFQbMuDxopQsKJ11n2qO87mBnTr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA3OSBTYWx0ZWRfX+h2b23YgXchr
 9Judgf10pLu7PBqpa1UJQEzZaB9HFKNY8FBXT2jl8qk5Nq3LZoTkA/1gZyqra0nr8mF7Cb1UwAF
 rRHx4LZotjTBR3CwaclHSLSiI1C7260YMJXMJi55HRwqkgnECYmSh5y8Scdbe/YkD+92XeIyuzW
 T0QcA1ic7SsarAAKngfTVwZLTjbYYkiFSqPDewAWyghsVWfuENNcrgn5G4O2OCK4LSPmdeGrv9e
 8wh6xq6mDW4ErgAAKB3ps+45yfWBb8UBVmkGW2Db/TECxYrg5I2RsY0yJ6g2tZK3QKvEssh67ux
 hGdKD+AYuGXEgTOCjgTaApMrimXDy8F4LiKf7HJiqV7x2pzVMdsxoGnAuH1sSPQE4eVemF9WW+6
 MJwDtY8aC5hTBUz1QL3JNJerlBy76q33OgifuayQryhRY2LTQb0m6pMhDP88SHj0vqBlPy8JeVE
 +8pIMPmY6e7o1w4L7ew==
X-Proofpoint-ORIG-GUID: 03AX4kFQbMuDxopQsKJ11n2qO87mBnTr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_02,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0
 spamscore=0 adultscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020079

Hi Dmitry,

On 2-Mar-26 1:44 AM, Dmitry Torokhov wrote:
> Hi Hans,
> 
> On Sat, Feb 28, 2026 at 03:52:58PM +0100, Hans de Goede wrote:
>> Elan touchscreens have a HID-battery device for the stylus which is always
>> there even if there is no stylus.
>>
>> This is causing upower to report an empty battery for the stylus and some
>> desktop-environments will show a notification about this, which is quite
>> annoying.
>>
>> Because of this the HID-battery is being ignored on all Elan I2c and USB
>> touchscreens, but this causes there to be no battery reporting for
>> the stylus at all.
>>
>> This adds a new HID_BATTERY_QUIRK_DYNAMIC and uses these for the Elan
>> touchscreens.
>>
>> This new quirks causes the present value of the battery to start at 0,
>> which will make userspace ignore it and only sets present to 1 after
>> receiving a battery input report which only happens when the stylus
>> gets in range.
> 
> My understanding was that "present" attribute is to be used for
> removable batteries (i.e. when a battery can be extracted from either
> from the system or from a peripheral) and we want to notify userspace of
> that fact).

In this case we have a touchscreen and a stylus with a battery embedded
in the stylus and we're setting present to 0 when the stylus (and thus
the battery) is not there. I realize this is a bit different but it
is close enough IMHO.

Also keep in mind that most people simply do not have the stylus at all,
these styluses are typically an optional accessory and some models where
the touchscreen supports this the vendor is not even selling a stylus to
go with the 2-in-1 laptop (but you may use a compatible stylus from other
vendors).

TL;DR; the user not having a stylus at all is the most common use case here.

> For example, if a laptop can have an additional battery UI
> can show if it is installed or not, and it should not simply ignore such
> power supplies.

As the screenshots of the KDE control-panel in the bug for this:
https://bugzilla.kernel.org/show_bug.cgi?id=221118

Show it is not being ignored, but its charge-level is ignored,
with the battery being shown as not present. Which is pretty much
what we want.

> On the other hand the "Unknown" operating status signals that we
> actually do not know the state of the battery, and fits better in our
> situation.

Reporting "Unknown" in the status attribute is not something which
drivers normally do. It is there in the ABI and upower seems to somewhat
handle it, but upower only handles it in that it forwards it to upower
DBUS API users it does not reset history, etc. as it does for present=0.

The problem with status=Unknown is that its meaning is not really well
defined. Unknown status mostly means that it is unknown if the battery is
charging / discharging / full for some reason. But if there still is a low
capacity reading then userspace might still warn about the low capacity in
this case, since the battery is still almost empty and presumably not
charging.

Also when the stylus is not there, the battery state is not unknown,
the entire stylus, including the battery is simply not there, so
reporting present=0 seems more appropriate and its meaning is well
defined and present=0 causes upower to not read/report any of the
other attributes.

And as mentioned most users will not have the stylus I think having
a non-present "ELAN Touchscreen Stylus battery" being reported makes
some sense to end users, where as having the same battery being
reported "Unknown" status and at 0% charge (Unknown status batteries
do have a charge) is more confusing for users.

> Anyway, I think we need Sebastian's input here.

Ack, Sebastian your input would be appreciated here ?

Regards,

Hans



> 
>>
>> Reported-by: ggrundik@gmail.com
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221118
>> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
>> ---
>>  drivers/hid/hid-input.c | 14 +++++++++++---
>>  include/linux/hid.h     |  1 +
>>  2 files changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
>> index 67ca1e88ce13..8fc20df99b97 100644
>> --- a/drivers/hid/hid-input.c
>> +++ b/drivers/hid/hid-input.c
>> @@ -354,6 +354,7 @@ static enum power_supply_property hidinput_battery_props[] = {
>>  #define HID_BATTERY_QUIRK_FEATURE	(1 << 1) /* ask for feature report */
>>  #define HID_BATTERY_QUIRK_IGNORE	(1 << 2) /* completely ignore the battery */
>>  #define HID_BATTERY_QUIRK_AVOID_QUERY	(1 << 3) /* do not query the battery */
>> +#define HID_BATTERY_QUIRK_DYNAMIC	(1 << 4) /* report present only after life signs */
>>  
>>  static const struct hid_device_id hid_battery_quirks[] = {
>>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
>> @@ -398,8 +399,8 @@ static const struct hid_device_id hid_battery_quirks[] = {
>>  	 * Elan HID touchscreens seem to all report a non present battery,
>>  	 * set HID_BATTERY_QUIRK_IGNORE for all Elan I2C and USB HID devices.
>>  	 */
>> -	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, HID_ANY_ID), HID_BATTERY_QUIRK_IGNORE },
>> -	{ HID_USB_DEVICE(USB_VENDOR_ID_ELAN, HID_ANY_ID), HID_BATTERY_QUIRK_IGNORE },
>> +	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, HID_ANY_ID), HID_BATTERY_QUIRK_DYNAMIC },
>> +	{ HID_USB_DEVICE(USB_VENDOR_ID_ELAN, HID_ANY_ID), HID_BATTERY_QUIRK_DYNAMIC },
>>  	{}
>>  };
>>  
>> @@ -456,11 +457,14 @@ static int hidinput_get_battery_property(struct power_supply *psy,
>>  	int ret = 0;
>>  
>>  	switch (prop) {
>> -	case POWER_SUPPLY_PROP_PRESENT:
>>  	case POWER_SUPPLY_PROP_ONLINE:
>>  		val->intval = 1;
>>  		break;
>>  
>> +	case POWER_SUPPLY_PROP_PRESENT:
>> +		val->intval = dev->battery_present;
>> +		break;
>> +
>>  	case POWER_SUPPLY_PROP_CAPACITY:
>>  		if (dev->battery_status != HID_BATTERY_REPORTED &&
>>  		    !dev->battery_avoid_query) {
>> @@ -573,6 +577,8 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
>>  	if (quirks & HID_BATTERY_QUIRK_AVOID_QUERY)
>>  		dev->battery_avoid_query = true;
>>  
>> +	dev->battery_present = (quirks & HID_BATTERY_QUIRK_DYNAMIC) ? false : true;
>> +
>>  	dev->battery = power_supply_register(&dev->dev, psy_desc, &psy_cfg);
>>  	if (IS_ERR(dev->battery)) {
>>  		error = PTR_ERR(dev->battery);
>> @@ -628,6 +634,7 @@ static void hidinput_update_battery(struct hid_device *dev, unsigned int usage,
>>  		return;
>>  
>>  	if (hidinput_update_battery_charge_status(dev, usage, value)) {
>> +		dev->battery_present = true;
>>  		power_supply_changed(dev->battery);
>>  		return;
>>  	}
>> @@ -643,6 +650,7 @@ static void hidinput_update_battery(struct hid_device *dev, unsigned int usage,
>>  	if (dev->battery_status != HID_BATTERY_REPORTED ||
>>  	    capacity != dev->battery_capacity ||
>>  	    ktime_after(ktime_get_coarse(), dev->battery_ratelimit_time)) {
>> +		dev->battery_present = true;
>>  		dev->battery_capacity = capacity;
>>  		dev->battery_status = HID_BATTERY_REPORTED;
>>  		dev->battery_ratelimit_time =
>> diff --git a/include/linux/hid.h b/include/linux/hid.h
>> index dce862cafbbd..d9b54f0e8671 100644
>> --- a/include/linux/hid.h
>> +++ b/include/linux/hid.h
>> @@ -682,6 +682,7 @@ struct hid_device {
>>  	__s32 battery_charge_status;
>>  	enum hid_battery_status battery_status;
>>  	bool battery_avoid_query;
>> +	bool battery_present;
>>  	ktime_t battery_ratelimit_time;
>>  #endif
>>  
> 
> Thanks.
> 

