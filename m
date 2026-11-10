Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794313697;
	b=Q7MXZJ5QbbnkfO6GJmMwpUK99d353WUn4VyNZqfVkkFRdRkgcmlYcMNPBR1C60nwFewm
	 Suhw7IhUsRBtyV2B+BRz4ciY0kWSB8dpyN2R9p3i6qKlDoegzB2r3j5I73LaWSfOwjvpr
	 t/aKGwCGYjKovDzwjfNOhkCj/CsrzvMFrbIM47QGgm3lXyUV7jQChHtchBgA3Of34Bd4s
	 HjIcS6XndDtrr9sNX5soPtruKskbTeyZYe4Sede0lhWiSr9LLPcLw76AKOTikvzDFrJK/
	 GlXQZV67zZoghDW3p+TT4KvGvFMohPMO41FsukNU5Ubc54euGTNDcUyG2fv26BCUuyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794313697;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=/nC/1DD8la1zIw7MWdv96m+/i2DMGK4fKRGC2o4Xb9E=;
	b=WAMSIQuFXOGIwV7drmJEGlSNVrP34zjsCkNwYQJTZQUOuxWC8yLnGFErs+p1wUIpBpLe
	 rYqosqc4WAt2JSPDjB62BbGBlyv+ud7C358v5ai7/VzZ9nXr9Wbcx8nvtLWaYDx/roFsh
	 8bBvkr/22CwAB1gZ/MrBrAnXj/cAZHPMRqUdLlWTRBXaurqjRkeIjpMi2aIN9VSwILmK0
	 GQAI91oqJmk1W1Ayk7IaqvxQyPu0RPVuCoqxIT0jKFJ50I2QOTGv84RifBbAx0SWr9Rjn
	 mn1h41janrkAphNLzoG6o1g0Eux+dZ6RR+omiqzoqSFYzdxfEz67grKmPNM6RyiNCcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=squebb.ca;
	spf=pass smtp.mailfrom=squebb.ca;
	dkim=pass header.d=squebb.ca header.i=@squebb.ca header.a=rsa-sha256 header.s=fm1 header.b="U/fBQzzc";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=GQbWgKZ4;
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247F1606A335
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 12:28:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 247F1606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=squebb.ca header.i=@squebb.ca header.a=rsa-sha256 header.s=fm1 header.b=U/fBQzzc;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=GQbWgKZ4
Received: from stl-compute-04.internal (stl-compute-04.internal [10.204.2.64])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 49D817A0254
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 07:28:15 -0500 (EST)
Received: from stl-imap-02 ([10.204.2.93])
  by stl-compute-04.internal (MEProxy); Tue, 10 Nov 2026 07:28:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1794313695;
	 x=1794400095; bh=/nC/1DD8la1zIw7MWdv96m+/i2DMGK4fKRGC2o4Xb9E=; b=
	U/fBQzzcNd968V8m2Dklb4okorM3mTHiBdA4BzEZpHj53/ZiD4/r4gYOI7i24yYR
	jUPYlRrusq3pIHVmNcENogTuD0zR3oqgXBrNGRHpHtMsnRd5k7GDeL39oC63bzkh
	VLZAtzT4Y589xrLeLDbgFQOlR1/LLuDOgz/AdHB5koMz9s46rI6Tln0NlNC9ionG
	naXjttYRpO5+lV9aWlFv65VEhjaIGybrHlTYlDhZMAjGUS5XwXdYELElI2kHUGaW
	B6QHo+MubtHdnmXl7JstE9lc3cwGC3h5/sKi1+w4qepQctpMnh2l71x/VBOs22Za
	6YVAIXgfJLTM1PqgrZ4y+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794313695; x=
	1794400095; bh=/nC/1DD8la1zIw7MWdv96m+/i2DMGK4fKRGC2o4Xb9E=; b=G
	QbWgKZ4gr6hiD4d0TI0mgycX0kbKDEODiGV0OzFFk+2FwUXCWZNJtvbYtJeE4Phb
	689xDimMNdx7hqxlwoUTSD4nCgb8iRzOQo+l3KkxEHUUxdEHkoqLN7UmUjGHsBOJ
	tvaF5XVM6WaH5mxIMaRlMCPUag1MtckYE+DF+eVb1lJ98icOsJvxb5WTs9wONlDG
	u8WI09cFSaT3VDZzZxR7Ya2WBHAUMPCdhWiKbrq4kab1mRx7qQWdCK2+1EamWnR4
	ANMhTFbjMohQN2P16Au0DIP1QdXURQBXCX87ZXNilGu8LibyqtIGTKTwtaWXqXPl
	LlaMfFBOYEyFuBoAadJlA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=squebb.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794313695; d=squebb.ca;
	mf=PG1wZWFyc29uLWxlbm92b0BzcXVlYmIuY2E+;
	rt=PGxpbnV4LWlucHV0QHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:Jctlz67OhDboZKT0uqWIyevil6anH7De3B3+jb0DoEY/Cg3
	oT7EKUsHxk6wv/CBvvfowiiEEBGDX6b7PKvzncX/HY0QnUV6MjjQwnKr0oZYjEfN
	JOMPiCRhM0k9KoLpFVroOtCtmBFvqYs9y1Vw/B9mQbk1+5EhYEeVpX2V/0sv4v38
	ZpTLMsFMAX2loUTbCp4iOlnrgHupu7408+cC/xRAzZwlTbkBzrwhJphEJZfVboGh
	m+QTJRTya4H8WYh8ODv71VRw6e5BQ6R8dsAUNrQAueLtVI710D3x4xRRY5GbWLuE
	7OxrmqDRJ2uEfMdbhfIpKzkQYgKkHcuRwxFSMEQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Xu17kfcaMKMyB86NOyP5+H1wzjYg91byssck7TLAHQY=:jmNQZ0SKquZeVpdwO+QfxCUptFfOY0MI4vgfHXbH+tM=;
X-ME-Sender: <xms:3g3zai-eC7UY--su4vkutQkznIFVD-xZwh9xu76asZd3XyW-RKzGmA>
    <xme:3g3zathn8_YXWXvhyvFQhs02cs1j1Jb-HzT0QKGTKN3QkxPcT65dUcancMvhuMhja
    lkd3VJlELzqeBu8TUU_c5PsrfJLnZJsf1eoTicgIigul693VhzojKY>
X-ME-Proxy-Cause: dmFkZTGKWkCq0IqbjuWRfjIXSD0QYpriiKaEbjO+2vpC5XjNt4hkVnBiJdi4URSqFAdApL
    75ovof2UvomKkTWEO1y+ub9eJ8Xium6pKmUpQuNbCikEHQWd5+nZwlNyWpAQ5DJMy2Med2
    xlleKlA6/KoJbPKMNRDtEjQNWxXZEe9hamqjs3FZpBMByl/AEeoqUUbWw1yYL9UcwP7Rtf
    WNmSerankQuln8oR1gO/JFANx9pr5Dktl4LpsnFb3dTvfAWk96Z2y/ITQcNJe6/k9ay0uP
    uFnuX/veIofmlS59p3z2IjlcWOA6KDEIOBHQDqOgyxgQip/8aLnDQgTcqaPHUUH2qZIFNv
    T5vHWaYtSSY2ObhyTXAFv6604uBp0FahiJdJjYSMFaww+v5561uuT/oTXWH6reEYxItsWk
    qhx1H48PDTKeb7lWNzCLtY97eTCs29IEva4pXFYeFuSwWzY0wLJIncp6DutKCjoZs/EYn/
    5ybz/xgXFqjvjhnzuaxzuZ4e3VVCpCHEfbApLP+Q3gw3GxFuQCKfM++yEBRmNFMmU5Z14Z
    IbSYa4aI1LDSdYouhAtYQ13PNVOgFuPRw9A3kavMyvzWQj+Q70obnq3HVxPmMyv3UakHI+
    MeVTwH5XGEK3a3FczqSngJp8K2KUpHNZrDqSx2h5RdMG5Dr63cpaj8UFdnKw
X-ME-Proxy: <xmx:3g3zahLPG3v6lY4SWhiy0s1y3y2n5q-ULEM4FNKb_wnUEevblZpXHg>
    <xmx:3g3zamGwdevSWXeHf56IfT-jY7xJ5b_JOXv_Tz0Lb8qX5y5LU8SA9A>
    <xmx:3g3zalSHOAteVn41kHvYUkHS4CR6OLOK7g0tM71hx0zFIeNcegUN3A>
    <xmx:3g3zaidYiCHJ348zyAITdNhppFsBIRXMv20_oL7TixcCVKr-3tT4RQ>
    <xmx:3w3zantpJs-gx0dGWgQjMjOvcNyOdOA4vm2l1acc4YSKU1BimgQIXR2V>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.stl.internal (Postfix, from userid 501)
	id 78AC72C00085; Tue, 10 Nov 2026 07:28:14 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: A4C1pTx2ltvJ
Date: Tue, 10 Nov 2026 07:27:53 -0500
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Hans de Goede" <johannes.goede@oss.qualcomm.com>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
 "Jiri Kosina" <jikos@kernel.org>, "Benjamin Tissoires" <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org
Message-Id: <35bbae20-c166-4889-bce3-36453dda1cd7@app.fastmail.com>
In-Reply-To: <032eb56b-89b8-4b5e-b291-4d4955e87009@oss.qualcomm.com>
References: <20261109214349.391853-1-johannes.goede@oss.qualcomm.com>
 <d66407e5-a057-4149-9ad8-1f0dd0c2d6a8@app.fastmail.com>
 <032eb56b-89b8-4b5e-b291-4d4955e87009@oss.qualcomm.com>
Subject: Re: [PATCH] HID: lenovo: suppress spurious F23 key events on ThinkPad T14s
 gen6/7 snapdragon
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, Nov 10, 2026, at 4:36 AM, Hans de Goede wrote:
> Hi,
>
> On 10-Nov-26 01:49, Mark Pearson wrote:
>> Hi Hans
>> 
>> On Mon, Nov 9, 2026, at 4:43 PM, Hans de Goede wrote:
>>> The Lenovo ThinkPad T14s gen6/7 snapdragon version I2C-HID keyboard sends
>>> spurirous F23 key-events when the Fn key is pressed/released. Leading to
>> 
>> Minor - typo (spurirous)
>
> Ack.
>
>>> e.g. garbage ESC-sequences in the terminal when doing FN key combos.
>>>
>>> A hwdb entry was added to map these to KEY_UNKNOWN [1], but this also maps
>>> the F23 part of the left-meta + left-shift + F23 combo send by the co-pilot
>>> key to KEY_UNKNOWN making that key unusable.
>>>
>>> Add a raw_event filter which removes any 0x72 codes from the 6 scancodes
>>> reported in the standard HID keyboard boot protocol report, but only when
>>> the report's modifier byte is not 0x0a to preserve the F23 press event
>>> when the co-pilot key is pressed.
>>>
>> Interesting - I'd missed that.
>> 
>> Should I be flagging this to the FW team? I think I'm unlikely to get anything fixed at this point realistically - so don't want to block the patch...but if there's something we can learn from this for maybe the next generation?
>
> For future hw it would be nice if just pressing Fn by itself would not send
> any spurious keypresses. Or at least not on the I2C-HID side. If this is
> an EC event instead we can just filter it in the EC driver.
>

Ack. Thanks - I'll let them know.

>
>>> Link: https://github.com/systemd/systemd/pull/44733 [1]
>>> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
>>> ---
>>>  drivers/hid/hid-ids.h    |  1 +
>>>  drivers/hid/hid-lenovo.c | 21 +++++++++++++++++++++
>>>  2 files changed, 22 insertions(+)
>>>
>>> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
>>> index 994e8bc69924..70d18d32fe3c 100644
>>> --- a/drivers/hid/hid-ids.h
>>> +++ b/drivers/hid/hid-ids.h
>>> @@ -473,6 +473,7 @@
>>>  #define USB_DEVICE_ID_EDIFIER_QR30	0xa101	/* EDIFIER Hal0 2.0 SE */
>>>
>>>  #define USB_VENDOR_ID_ELAN		0x04f3
>>> +#define I2C_DEVICE_ID_ELAN_LENOVO_T14S_KEYBOARD	0x000d
>>>  #define USB_DEVICE_ID_SB974D            0x0400
>>>  #define USB_DEVICE_ID_TOSHIBA_CLICK_L9W	0x0401
>>>  #define USB_DEVICE_ID_HP_X2		0x074d
>>> diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
>>> index 30bd3f794243..e997d0cf2672 100644
>>> --- a/drivers/hid/hid-lenovo.c
>>> +++ b/drivers/hid/hid-lenovo.c
>>> @@ -812,6 +812,22 @@ static int lenovo_raw_event(struct hid_device *hdev,
>>>  		      size >= 4 && report->id == 0x03))
>>>  		return lenovo_raw_event_TP_X12_tab(hdev, get_unaligned_le32(data));
>>>
>>> +	/*
>>> +	 * Lenovo ThinkPad T14s gen6/7 snapdragon version filter out spurious
>>> +	 * F23 events when Fn key is pressed. F23 cannot be unmapped because of
>>> +	 * the copilot key sending left-meta + left-shift + F23. Filter report 8
>>> +	 * (keyboard) scancode 0x72 (F23) when the modifier byte is not 0x0a.
>>> +	 */
>>> +	if (unlikely(hdev->product == I2C_DEVICE_ID_ELAN_LENOVO_T14S_KEYBOARD &&
>>> +		     size == 9 && data[0] == 8 && data[1] != 0x0a)) {
>>> +		for (int i = 3; i < 9; i++)
>>> +			if (data[i] == 0x72) {
>>> +				memmove(&data[i], &data[i + 1], 8 - i);
>>> +				data[8] = 0;
>>> +				break;
>>> +			}
>>> +	}
>>> +
>>>  	return 0;
>>>  }
>>>
>>> @@ -1393,6 +1409,10 @@ static int lenovo_probe(struct hid_device *hdev,
>>>  {
>>>  	int ret;
>>>
>>> +	/* Make the T14s  keyboard trackpoint a separate input-device */
>>> +	if (hdev->product == I2C_DEVICE_ID_ELAN_LENOVO_T14S_KEYBOARD)
>>> +		hdev->quirks |= HID_QUIRK_INPUT_PER_APP;
>>> +
>> 
>> Shouldn't this be in a separate commit?
>
> No this "quirk" is the default behavior of the hid-generic driver. This driver
> now will take over control from the hid-generic driver because of the device-id
> addition below.
>
> So setting this quirk preserves the existing default behavior.
>
Ah - my bad. Thanks for the explain.

>> 
>>>  	ret = hid_parse(hdev);
>>>  	if (ret) {
>>>  		hid_err(hdev, "hid_parse failed\n");
>>> @@ -1558,6 +1578,7 @@ static const struct hid_device_id 
>>> lenovo_devices[] = {
>>>  	{ HID_USB_DEVICE(USB_VENDOR_ID_IBM, 
>>> USB_DEVICE_ID_IBM_SCROLLPOINT_800DPI_OPTICAL_PRO) },
>>>  	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, 
>>> USB_DEVICE_ID_LENOVO_SCROLLPOINT_OPTICAL) },
>>>  	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, 
>>> USB_DEVICE_ID_LENOVO_TP10UBKBD) },
>>> +	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, 
>>> I2C_DEVICE_ID_ELAN_LENOVO_T14S_KEYBOARD) },
>>>  	/*
>>>  	 * Note bind to the HID_GROUP_GENERIC group, so that we only bind to 
>>> the keyboard
>>>  	 * part, while letting hid-multitouch.c handle the touchpad and 
>>> trackpoint.
>>> -- 
>>> 2.56.0
>> 

Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Mark
