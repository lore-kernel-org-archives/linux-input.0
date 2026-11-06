Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793969632;
	b=QbWx6YRiH7HzSEsIctlpr20TWniMUBgY3CayCv9c39flI7K7Q9Yj+zDAavyOQi6N8bni
	 5x08f3/CAQDQ+09AYXLj5yNpy/Xz59HLBSwJg5knKVyYpWpM8XZIE34B092gV5qnOEWTS
	 UFCOgkZeMUG5xlbsUOM+CKV6yq5CbHKYrQUzBeZ/xO7yS1hsVLfROzM9zFddaIHm963es
	 HghgvAfJJNPw5Vzf7axAwalegHBN9h0IsTOE6o6DPSr/tvDN2mMN69KZpq9Pb1d8hzfRt
	 7NasxaSG/K38elodUUleygaPH5hdGxU3qHBJedAUHUPGITmcIRBbnt9EbLOW1b9S3uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793969632;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oTHjiyDX2guT5VBDXE9scu6NOC96wb99UsVWoSwnSP0=;
	b=hB9fdQzWEyOahORpmgxaqyjBNzLFLJQ+BcAPMdSTozJVzN3jdbG4HweH9BOQSw1dsHKD
	 TwXRAKtydDrDtVv8vMfE1+mq3Qj+49Qrc+wVRhJIvVg8XSIWiyhVfDDFcByBiGdk31R8e
	 LsOmJJzIU5puzfgG6xWbe4yUCtpv5+Hl2j+Ih8VVynuLPjoLXC+UBieTNYQ1eo5g3zB+X
	 ykOEFKjnx3Y8qG3LR86iiicYd5qTqSORxxp4LOkq+uLsdCFDZv6basORLYk1JblHw3kCF
	 LBMx8p1IeiEdf8wIkVVU+8S907G6CtbxkMbINLuQ5Z4X5Ci9kngrMDCp0W6URDLpLYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RTQOMoxi;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFAD606A338
	for <linux-input@vger.kernel.org>; Fri,  6 Nov 2026 12:53:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AFAD606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RTQOMoxi
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a20bde60a0so4860255e9.3
        for <linux-input@vger.kernel.org>; Fri, 06 Nov 2026 04:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793969631; x=1794574431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oTHjiyDX2guT5VBDXE9scu6NOC96wb99UsVWoSwnSP0=;
        b=RTQOMoxix56I3khgiwxSLlG6MqNj4SnKFN0SBhox6cEqvgnl7JGomA1wRtDOmcDzLn
         SMJbxP2clNS4vp9IEQIfNqOTQieTPb/o/DkCapHlrMzsPu6UpPko7DR4mpB3S63dhpsA
         yQIBpXjJ5HgVWdunVyqSVTnmQDD07f5uSMGGmNBys+TeI0//Lgvjg03DukZF8YSSjcXa
         6iBj+12ApuubwP4ZWxCaiBMjqjQQa1joZPEi92XjrxUdybrBwYF7+rkj8D7F62pL697Z
         Dm7VhyarpKwTU6Om6ty0AEYYTNZ8YrIxmj2NZuNBefTI3ypgkCjCScMTGyRuYCr0YEb0
         v0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793969631; x=1794574431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oTHjiyDX2guT5VBDXE9scu6NOC96wb99UsVWoSwnSP0=;
        b=KnwU+Gr89PCkQ2SsQcgObDgNi/aAPdObijI/tcFFC7BsVq3WN1xUbwqYIQcECDJSi0
         7ec72/42sB9f2NqiZTBhP7B+xjmljFNO9Z54RhQJVhDg7tos6psZ6m9bnleqpEVJaNcJ
         ipF9Mr1+iam6zilA6GBXlDeg2Iw7Sm0KJE7cHAbPXvDwgG+GgZ/aB0ag5eSyUwlmGPKH
         ZKofsG2HV7/67utUs0S2KZFg93/1EPbtvfZ8+Q5kVzqqptyT5gg6wKvLWtbelSxyDs/R
         NTAwylTChoOZYgwYTLFh03pljUepbfmwL9yMmu7WWVBncLq5w7U8SWCJilH0mpmdZF3t
         wQ1A==
X-Forwarded-Encrypted: i=1; AKwUvBwI9eEizjlpDIlWCNaFQ/YHXU3sDa+lTY1Qu8Qzb/832sfeNRwrBCC0pZH4NL4y0VK88y/iGKj95+PzKA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/ecyPJ8pdwcSTZIVstJIowtZS/GHEPG7hOVwfuDKLQDy0qn5K1
	5MIACnlNS/byGTki0vXkxep6i/Uw3VEFb/usO+dUoJSN/UBIoiSN9N11
X-Gm-Gg: AYBFou2wjOUhaeaiIealf2yptdGfyE6Bgquy7YDYWLA377vpZSKtnvvFXT7UnAwF0Xr
	Pmtm4RCd1npOSrXVOnuoFPIuIrRpm0T1h2yM/l6zFeke3K27hylz+faF5tnJP1Hkp/pWkOXICrf
	i8Ib3rjTb6X0q/sn+0xKI0X17HH4HrpBFeR72mQgyuNxKnW/xMOZgjG0tChMmh9NGvkK7Y3q6+W
	QYXuUJhRaY5L5sc2O+os5E7RJ/ps0ggyVx/S6hJsaPEwZEd1BadQEWh9Kyl/Wkg8h8JloXcf/Ew
	SU4ERHJxTGbkWU+56IahC6lSb0OUUUOjGSYXtfsPnAFAa5ZKSkdIGpbiEEUfbaOLtf+LAJKgoXq
	83/BL9u0XKHYPHjzhv33hP5yDP5DqDuxjKiccMpmFHGcSeyD4hjbmn+c26BouiQ2mx/3mqvEwRh
	vs6dizuMoIA3lrC1Px14L0742I1/Se4JKgy/9qOtTkTH2wgnRMGGU9ih93hRx1OAXG46Yhx8ebH
	cBXyFtoMRkHRG8FUWx4MVOsegJI8MIo1MgjdyIshPlJCOzlsyPONC0/YoJ53DSWPQKENi7wsLxX
	QjZ71kkNNADcdIUcFW627NAEyQxY
X-Received: by 2002:a05:600c:1913:b0:4a2:1398:dd05 with SMTP id 5b1f17b1804b1-4b6de0ce791mr41196125e9.16.1793969630568;
        Fri, 06 Nov 2026 04:53:50 -0800 (PST)
Received: from m2.. ([37.142.148.124])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4b6e1b5d676sm58687815e9.7.2026.11.06.04.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 04:53:49 -0800 (PST)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Raman Varabets <kernel-linux-20260610-80b7ab08@raman.v1.sg>,
	Germain Hebert <germain.hebert@ca.abb.com>,
	Christina Quast <contact@christina-quast.de>,
	Rio Liu <rio@r26.me>,
	Bruno Giacomazzi <brunoceg1@gmail.com>,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Zaidman <michael.zaidman@gmail.com>
Subject: Re: [PATCH v2 03/15] HID: ft260: add GPIO support
Date: Fri,  6 Nov 2026 14:53:40 +0200
Message-ID: <20261106125340.18483-1-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <7a3kc2tj2mh62aklablkma5teiinm6b6z2rlvrfwk76xcnd2rb@xwsgziioxz6u>
References: <7a3kc2tj2mh62aklablkma5teiinm6b6z2rlvrfwk76xcnd2rb@xwsgziioxz6u>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Nov 03, 2026 at 01:53:26PM +0100, Bartosz Golaszewski wrote:
> There's a lot of sashiko comments to address but a few additional nits
> below.

Thank you for the review. I am working through the Sashiko findings
for v3. Below is what I plan for each of your points.

>> +	mutex_lock(&dev->lock);
>
> Use lock guards from linux/cleanup.h.

[...]

>> +exit:
>> +	mutex_unlock(&dev->lock);
>
> That way you'll avoid this label. Same elsewhere.

I plan to do this as one new patch at the end of v3, which converts
the whole driver to guard(), and to remove these labels there.

The reason is that I also maintain an out-of-tree version of this
driver for kernels older than 6.5, which do not have linux/cleanup.h.
With the conversion as the last patch, the code before it becomes the
base for that version. It builds on older kernels with small changes,
and I can simply leave the last patch out there.

>> +	dev->gc = devm_kzalloc(&hdev->dev, sizeof(*dev->gc), GFP_KERNEL);
>> +	if (!dev->gc)
>> +		return -ENOMEM;
>
> Why is this dynamically allocated? Make it part of ft260_device.

Will do in v3.

>> +	if (!label) {
>> +		ret = -ENOMEM;
>> +		goto exit;
>
> Just return here? Why the label?

Right, it will return directly.

>> +	snprintf(label, label_sz, "%s%s", prefix, dev_name(&hdev->dev));
>
> devm_kasprintf()?

Yes, v3 uses devm_kasprintf().

>> +	hid_info(hdev, "initialize gpio chip on %s\n", label);
>
> Drop logs like this, they add nothing except useless noise. Same
> elsewhere.

Agreed. In v3 I drop both "initialize gpio chip" messages.

The "enabled GPIOs" message moves from info to debug verbosity. It is
off by default. I would like to keep it there, because my hardware
tests read the GPIO mask from it.

Two messages stay at info level. "registering device /dev/ttyFT%d" is
the only one that tells which tty belongs to which device, like
"converter now attached to ttyUSB%d" in the USB serial core.
"chip code" was in the driver before this series, and it is the only
place that prints the chip version.

Thanks,
Michael
