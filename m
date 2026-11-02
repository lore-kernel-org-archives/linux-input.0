Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641737;
	b=Ydr4gmv6dZvN7cl87MMt8Nl+L5SCEE5519A/5ltxQteQ+ex6LJl6XYdt2rdQtMpIg1jB
	 ctRizvSG1c3StyOtiSbbKUJCTeIlylqWMvLtcnG7vriUrNa3VbgWIA4koGMauWeLu8G7X
	 cBJjAS/N/M0oa+14IOpMGm9k1Df23gzVbkpukXGoJy7eFcARME2wZ6zyhMBs0QZQtb/2T
	 WovkueXkRbp6ft5XiPCLojTy6ZEUqyl4jZP3MfLajVVd72qujlbyQujpfSSh+hSP3fviM
	 HH3PskRwUNgTRAmHicfuc6lcQ2bNxDKqmtBRl/wMWm/kq+fmYbji3o/n5IbGXKdz8Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641737;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=N3GSDyu9X+vOJu7TdWvo+Vd3yq5RaRgJrz6U2rVEjsQ=;
	b=KA7UQQCF2ivpJVdGgsNlL9860K4uF+pph7lDoMohBnP1jstH6EKP5q+jl4I0z0/ap3ia
	 lDx2Wdnxm/Vyh8LirFsyy0uBf1txB50obcUhDnQ7Lf1kMz4zuGDMzKic/yXPgq1IxMi0Q
	 mJNoBPc+wpTOc0i5rE5+srt2Gl2UjUIC1Iqlu+oifj3enRHrfO4AQAIneVSFjMECEOl1t
	 yOIfb++6eSAkjCID6Cdbe5fRgEAkRjaSc/HZmFIHuaA+O6oeTH/fOwcPRkuseyAUlnZ0o
	 tqlTrjuV5big1JK9wGWc3LsUuf6GqreF8zlecaE5KgmefwXGW3zWyMqM8kYhYkM879A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=squebb.ca;
	spf=pass smtp.mailfrom=squebb.ca;
	dkim=pass header.d=squebb.ca header.i=@squebb.ca header.a=rsa-sha256 header.s=fm3 header.b=IiNo+lzZ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=U1NSwhIm;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAE8606A330
	for <linux-input@vger.kernel.org>; Mon,  2 Nov 2026 17:48:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FAE8606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=squebb.ca header.i=@squebb.ca header.a=rsa-sha256 header.s=fm3 header.b=IiNo+lzZ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=U1NSwhIm
Received: from stl-compute-04.internal (stl-compute-04.internal [10.204.2.64])
	by mailfout.phl.internal (Postfix) with ESMTP id 6D9A2EC06E5
	for <linux-input@vger.kernel.org>; Mon,  2 Nov 2026 12:48:55 -0500 (EST)
Received: from stl-imap-02 ([10.204.2.93])
  by stl-compute-04.internal (MEProxy); Mon, 02 Nov 2026 12:48:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793641734;
	 x=1793728134; bh=N3GSDyu9X+vOJu7TdWvo+Vd3yq5RaRgJrz6U2rVEjsQ=; b=
	IiNo+lzZdgRgb1LmBnbR/AyaxzHsiiTesFUTALF3o7B9p3xcIVUAdqkOuq/FB+3j
	ckJl3ZYnXLQVZxN1girWl7EvTkaIIfwruCS0kWzvBYeBDpfn2jpUhDNQGt6nvTjw
	Q7VA4KSPjpTOOHqWFMR5+7whPzdNg2aY0HNWxDibNKHMe68I6aww8cLv3xgaUgjl
	J5w4HiKEaHTRJegs8XNNNt6w8fXnrCuD4rWW3ELCZKMZ9gj8rakvPWlhvIdO9maK
	QqPrvCJl44djieuf3qmC3o5MynWgQ8crEhJSzCs7FiNocD57HHuWEJ1NaDfDW9mF
	pLcwWfKeY9777T5mryNexQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793641734; x=
	1793728134; bh=N3GSDyu9X+vOJu7TdWvo+Vd3yq5RaRgJrz6U2rVEjsQ=; b=U
	1NSwhImXB10yFfX8P11maB4ou+M02tRikMiuiL6vSghMJOhiAYpkhIZvvDBKu2y1
	Cfj/q2njqV+T1hTVW60PR2aZSH2LqpshS78iUsVwR+3URueNjDPZ0aIO4vgly/fQ
	YzqaMHF66hc+MI8rjOiaryq46qiGBEooVXRFtGAeEHJq/CAIyM1tmLfwPp6llxoJ
	OvANyp2fBCaFBro5HI7gr6f1uAlQSWquS/mSQz0l9zM607kzZHLIKdqBbucaBreG
	9a7Ei2Odikkq9wAZ6dTLlLlixOgjNCQFECBJjoXYE/ktWAtUrJUsvt2NbVdJM2jO
	lnI07YK05cXJdcbjH3D7Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=squebb.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793641734; d=squebb.ca;
	mf=PG1wZWFyc29uLWxlbm92b0BzcXVlYmIuY2E+;
	rt=PGxpbnV4LWlucHV0QHZnZXIua2VybmVsLm9yZz4=;
	s=fm3:rsa-sha256:OUOTdxRu5MRiTwthNMyWYF+B8dayxiMvN1jZjRoaij4BFZV
	wJy9ZAC18vtEeyjocmjSCOYJJvDMlyszjBCS/wOlK5jA3fCKcn09ap0QXoWxHAX7
	Ru3OEHEpX8SHRx9gwzkVTJO8P/EJ5P2wxC5y88e+KWev2NkhgxoeA/jLYlITHHVO
	F953oU3fmOEIwso9ghp1T5j4NWiHx3rLQtlBsr6KfwIE3vcYtQb8tCAoireymowq
	pdEbgVPDAwK/deREMhiWjHESzcjbvGuYveDfL8Dr5dELqfMk9krODa3TacIaAJ8g
	AvTGznmW1cqVH4tR/YeGC7QkH8QpbNBlGwHSZhw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:+T9rqvcAn2tEourMhxxvEXXGzZA3/HK6R+riLlbkuOo=:UJ0nj2m4f6P1FRVJiS22N/Tuphb29VM7fiePoWeLp9E=;
X-ME-Sender: <xms:Bs3oauhsfU46CBG4TEC_L7--h1PKdoFYDQ6MR-hOGVK3V5PsbXC4FQ>
    <xme:Bs3oap2iroxmhqrIqCU8YLmcPyjo0gnQIPeMOk8e7MJDrEw8rsPjOJFe0_9CRMJWs
    -M1vUFYG8a4T4Iq0Aq_ISlp4OS6gXEiz-aT97rkMlJUhhMbUcrRuqNQ>
X-ME-Proxy-Cause: dmFkZTEMLs5fHg3Me8rdwk2ZYUrYjrTNASYaAuulDI3RfmwAr8iMA8VVpMZM91C5E+cExz
    SvTAmkihgn2nuHYYWcCpJA5e64zhj7Su7KehaoyIkM7xZV8bQ8D9YOcRbRXxO/fnd1jvRc
    8uqY6Ccsg1v25lhz1XYlAxL3NDP2eKxr16zaNz/JJBEVmeHluKtODu1j8MrPIkO/fO6sBO
    +78ls0gL5YejrSt5pVEHj/XpWu6R5Dd4wXLmBGoYUCp9bvxZwgm6/2vV9C0Nanx6Ix6ms6
    0InrmiHpAOrGeAvX+VltfKV18OHT2K9atTCxabn40oTSYKdP/14NMnLfwKHlXt/wg7/Sm0
    da9kBEZNdbCPfM0SJF0abNROp/XWz4bal8MXwANhJrLRRlmQa9+a96+CrV6Q/PR0ZVyjMh
    8myXu6C7xemjddHSWaRqb/9Ir1Y30JjPHib1NDU6539eFne2ZS4Np3eEBbjquero7QHa2P
    DpyksJXy8EmBrhIJgJ1fm8Jb9YBVzkyxs+52xsE6uslLtPAexlZlaW0GxUev9FX0xJulTS
    DujWKU0tZG2aAuSC9SKsHR6W1oe0gOkNdPgBagbIrfT1AkAEC1p/ix+sx4R2oiN66ITpb2
    I+U1/B/MhaNTq+92+VQmjGtspNZ/r4txpD2V09QWiwcUU0Hycr6+dDpxSWkg
X-ME-Proxy: <xmx:Bs3oavF83XQx6mOw3moUglnDgz-UpYFpoqponWGpI8zfbuc3Lkd_0w>
    <xmx:Bs3oaum8iOulIDf3m1UtkDKUzzGmS6HfEC9YZzi_TulAz1ZqN4-ZWA>
    <xmx:Bs3oajahAUMn_1SRNqIlNgbFtJ61CnGqvr-n_3hqnxF0kSJCiyIzAA>
    <xmx:Bs3oajGW__5mCJw7Pf1EFo1SvMD87zOtOchCojknTVsOEIZQ1xy4Yg>
    <xmx:Bs3oamwvuvn45oikuuzaYOtcuKkrR-Kn8NVeNywG9C5UiuduuifUrnIu>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.stl.internal (Postfix, from userid 501)
	id 6D88F2C00082; Mon,  2 Nov 2026 12:48:54 -0500 (EST)
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
X-ThreadId: AYDYWHX8bjAc
Date: Mon, 02 Nov 2026 12:48:34 -0500
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Ricardo Ribalda" <ribalda@chromium.org>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
 "Jiri Kosina" <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Message-Id: <0fd097a2-029b-4023-bc22-d2eb587a646d@app.fastmail.com>
In-Reply-To: 
 <CANiDSCs1qyOpv=W-F-94skQm4o-Aj9d0PbL7xr5qtdtLjWQ7vg@mail.gmail.com>
References: <20260831-lenovo-go-v1-1-e9526e88ee09@chromium.org>
 <CANiDSCs1qyOpv=W-F-94skQm4o-Aj9d0PbL7xr5qtdtLjWQ7vg@mail.gmail.com>
Subject: Re: [PATCH] HID: Merge duplicated documentation for Lenovo Legion
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Nov 2, 2026, at 7:40 AM, Ricardo Ribalda wrote:
> Friendly ping...
>
> On Mon, 31 Aug 2026 at 13:12, Ricardo Ribalda <ribalda@chromium.org> wrote:
>>
>> Lenovo Legion Go and Lenovo Legion Go S share some definitions. Merge them in
>> sysfs-driver-hid-lenovo-go to avoid this warning:
>>
>> WARNING] /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode is defined 2 times: ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:364; ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s:234
>> [WARNING] /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode_index is defined 2 times: ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:373; ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s:243
>> [WARNING] /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled is defined 2 times: ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:636; ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s:252
>> [WARNING] /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled_index is defined 2 times: ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:645; ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s:261
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 168c91839139 ("HID: Add documentation for Lenovo Legion Go drivers")
>> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>> ---
>>  .../ABI/testing/sysfs-driver-hid-lenovo-go         | 11 +++----
>>  .../ABI/testing/sysfs-driver-hid-lenovo-go-s       | 35 ----------------------
>>  2 files changed, 6 insertions(+), 40 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go b/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go
>> index c8221373ef76..f3ba3504939d 100644
>> --- a/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go
>> +++ b/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go
>> @@ -364,11 +364,12 @@ Description:      This displays the available options for the mode attribute.
>>  What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode
>>  Date:          April 2026
>>  Contact:       linux-input@vger.kernel.org
>> -Description:   This controls the behavior of built in chord combinations.
>> +Description:   This controls the behavior of built-in chord combinations.

Nit - this minor change is not part of the patch description.

>> +               For the Legion Go S, this controls the touchpad's operating mode.
>>
>>                 Values are windows or linux.
>>
>> -               Applies to Lenovo Legion Go and Go 2 line of handheld devices.
>> +               Applies to Lenovo Legion Go, Go 2, and Go S line of handheld devices.
>>
>>  What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode_index
>>  Date:          April 2026
>> @@ -377,7 +378,7 @@ Description:        This displays the available options for the os_mode attribute.
>>
>>                 Values are windows or linux.
>>
>> -               Applies to Lenovo Legion Go and Go 2 line of handheld devices.
>> +               Applies to Lenovo Legion Go, Go 2, and Go S line of handheld devices.
>>
>>  What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/product_version
>>  Date:          April 2026
>> @@ -640,7 +641,7 @@ Description:        This controls enabling or disabling the touchpad.
>>
>>                 Values are true, false.
>>
>> -               Applies to Lenovo Legion Go and Go 2 line of handheld devices.
>> +               Applies to Lenovo Legion Go, Go 2, and Go S line of handheld devices.
>>
>>  What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled_index
>>  Date:          April 2026
>> @@ -649,7 +650,7 @@ Description:        This displays the available options for the touchpad/enabled attrib
>>
>>                 Values are true, false.
>>
>> -               Applies to Lenovo Legion Go and Go 2 line of handheld devices.
>> +               Applies to Lenovo Legion Go, Go 2, and Go S line of handheld devices.
>>
>>  What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/vibration_enabled
>>  Date:          April 2026
>> diff --git a/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s b/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s
>> index 4d317074bb7e..218164cfe544 100644
>> --- a/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s
>> +++ b/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s
>> @@ -231,41 +231,6 @@ Description:       This displays the available options for the mouse/step attribute.
>>
>>                 Applies to Lenovo Legion Go S line of handheld devices.
>>
>> -What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode
>> -Date:          April 2026
>> -Contact:       linux-input@vger.kernel.org
>> -Description:   This controls which value is used for the touchpads operating mode.
>> -
>> -               Values are windows or linux.
>> -
>> -               Applies to Lenovo Legion Go S line of handheld devices.
>> -
>> -What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode_index
>> -Date:          April 2026
>> -Contact:       linux-input@vger.kernel.org
>> -Description:   This displays the available options for the os_mode attribute.
>> -
>> -               Values are windows or linux.
>> -
>> -               Applies to Lenovo Legion Go S line of handheld devices.
>> -
>> -What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled
>> -Date:          April 2026
>> -Contact:       linux-input@vger.kernel.org
>> -Description:   This controls enabling or disabling the built-in touchpad.
>> -
>> -               Values are true or false.
>> -
>> -               Applies to Lenovo Legion Go S line of handheld devices.
>> -
>> -What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled_index
>> -Date:          April 2026
>> -Contact:       linux-input@vger.kernel.org
>> -Description:   This displays the available options for the touchpad/enabled attribute.
>> -
>> -               Values are true or false.
>> -
>> -               Applies to Lenovo Legion Go S line of handheld devices.
>>
>>  What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/linux_mode
>>  Date:          April 2026
>>
>> ---
>> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
>> change-id: 20260831-lenovo-go-7b4ec4bf0cd5
>>
>> Best regards,
>> --
>> Ricardo Ribalda <ribalda@chromium.org>
>>
>
>
> -- 
> Ricardo Ribalda

All looks good to me.
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Mark
