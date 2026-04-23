Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552603E6DC6
	for <linux-input@vger.kernel.org>; Thu, 23 Apr 2026 09:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776937752; cv=none; b=izE3WOF6fbFdF6nDixuCv877z92sCOLUnvAy7WGhshYY6yRci53+X0jM5+k6saJQGBMR+emjlIIf6O5QlV+HLomQ9jQHiWNt/UKn969izL13NDs6upsjuOtv+GxTVfvsZh5HI/treK2JQR5vSZwZfjC65Ppv8bLZ+Uz0eYQj2Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776937752; c=relaxed/simple;
	bh=Y4PousOcVaaqckhVFMiOi8uTDkYPT7iGtB2HQBYZueY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kSsQq96Heom37Kjq+Fb6Ws1J9p9Qk6RmijygZBAvPaZIDNF5TG8SMciWKfMPUUOTqXQ8Qv9m9/1R9pnxPXINFdP5Ocr4gGMK9O0cH1Chk+9/eEtklDcGJJXNs9A0NI92YLUPkD/4xQk5kFHuaoWJtzkTqbVVT5G4K94x/CjVmyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Sb+rCSvY; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Sb+rCSvY"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so52090765e9.2
        for <linux-input@vger.kernel.org>; Thu, 23 Apr 2026 02:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776937749; x=1777542549; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W6CuFxsCV1eHyvW4GhPycszzfiSTsoYnKx4YlTr3Mnw=;
        b=Sb+rCSvYROZ71ajnKOBAfVpACSpObz+x8ovCArUeEm7zPzAFExhK1bd7SajpOCSeOT
         s8eseXTeU5rmk8g6LzhxXX9GIMqgoyRtWdoWIyx0YQLjxYDfUQIRT1VImJP0QnvVnq8x
         1g4eSCzXIIzxZfrUZSjYEl5Xv5Hu/fHgWfYrSd/sdyh+WC1RYeXVeFCuOlJfBqOhHgil
         5PCxnPj919iLeb6I6giCqqoCWPNxLlKL7KA5V4duFHm8/OmKVRBRrAhMTnYJpblQ/z48
         xG5kCso6VQWq1F985gUOKyCV50ZX/Grihc/FlF8NyVAiEaArE6VqE7e/TvrKjQ7XCfpV
         Plbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776937749; x=1777542549;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W6CuFxsCV1eHyvW4GhPycszzfiSTsoYnKx4YlTr3Mnw=;
        b=ix5E8tnW3xFgBLrN4TsrHBh/vGytg+h8HK8QdPHTWOaK0z7iSebQt8L95CXhzPdldS
         JmYgAPEY03FazSup/Ru9NYVCzHnWHtgyW0pKGJvndvCDIxhbEzv11An62hSMkSujobpR
         qM7fN717KsD07Eb8PBOSgNsxisA5rMMFul1n9swWLpdi9Vk08TQnvc2TdQw0wYtUylS6
         ZiZLxmkIp+lIxjtuHqnfKCYg2GVfrXT3jYOmXhWS2rH2y0/RrEjVE2wtFGQNeljYWs07
         xYD3mcbPMDVUGGOZBI7M1tI3Grqvwh/NtB063CkSieoJVa4z1Czfv5QzD+97J9NMmX5R
         1cTA==
X-Forwarded-Encrypted: i=1; AFNElJ8bL5tSK+pzuMibhiSlvW5xQ8LZBORawsmrCv6Ifp4/ZrRMc96mvLneSTo9P/0wIeUPCzGzPznwZ7i1Ig==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIK95U0iPpXbUDRMRqs6XIMcN4APXx3fu8qsHy0N3VpNAT2y6G
	7rwyv8Fq0swtoVVcD8jbCBCxyLNMCniYp6HW1NAYzAlFZc/VgBJS+TJGIbUljjgEHJw=
X-Gm-Gg: AeBDiesGqBwxWsQWOOdSIdCykYl4Z9UAYE1ozSy7hpQkGhoCeXRkof0SptkbAqmr1PD
	w/l6dneVa4YoLeMAZYNcfwD9NN7YN8msCA0PUzOT1xx6FORO8Xh6vgukJGNj8zdAUyEDnwzdU6V
	H71nncjO5EqEAXU6WGmExR7epkA1+Hz1H9fHWsS5cspniwkWFc61oG2aP5GCtHu+st0jzt+Iza3
	bHnwDdLGFdXD+JNi0BiFHsdaMEzRuPRvsXnPw6PDgsCQVR4TEWzJbfbplcRhSHljNW091d0jI7c
	+4CggFw9oH5dRuzQzKLj9+Q91PCiLXs3s0x5umMqPA5hFhHtFua3/kwBBAcfWnLRTejWs9bp58g
	P/r36Q3OcsdA0eZUUTq99fpfPAyEEDNOUddphK2BBll6VMvXgTBk11y/vHnS7W5sR/R1qVUyf3F
	S0XIDanNR7oHrv7aGCoK/FM7cSWDrggLis4erNDSw9aAhI1h4mn+VcYW2bG+VIS7itgtg7168Aw
	iVdyQ==
X-Received: by 2002:a05:600c:45d3:b0:48a:5821:5ffc with SMTP id 5b1f17b1804b1-48a58216a4bmr135595135e9.2.1776937748707;
        Thu, 23 Apr 2026 02:49:08 -0700 (PDT)
Received: from ?IPV6:2001:a61:1368:5101:a8e1:51e6:2ebb:a0e2? ([2001:a61:1368:5101:a8e1:51e6:2ebb:a0e2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a5aa3ae83sm207617095e9.12.2026.04.23.02.49.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 02:49:08 -0700 (PDT)
Message-ID: <7312e4df-9eab-4678-bd40-ae7187a53827@suse.com>
Date: Thu, 23 Apr 2026 11:49:02 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HID: usbhid: sanitize hid->uniq against non-printable
 bytes
To: Greg KH <greg@kroah.com>, Eric Naim <dnaim@cachyos.org>
Cc: Taylor Hewetson <taylor@exponent.digital>, Jiri Kosina
 <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260418025823.21767-1-taylor@exponent.digital>
 <2026041845-approve-pelvis-9845@gregkh>
 <81ef5ca0-b070-4afc-bda7-3e5a49677115@cachyos.org>
 <2026042330-underarm-reusable-effa@gregkh>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <2026042330-underarm-reusable-effa@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 23.04.26 11:29, Greg KH wrote:
> On Thu, Apr 23, 2026 at 05:55:00AM +0000, Eric Naim wrote:
>> On 4/18/26 3:14 PM, Greg KH wrote:

>> [1] https://github.com/systemd/systemd/issues/41339#issuecomment-4266429563
> 
> It's either up to the kernel, or every single userspace program that
> reads the strings from a device.  Might as well do it in one place,
> right?

No, because that puts the assumption that user space is not interested
in what the device actually returns and uses these strings just
for printing.
Eg. you can no longer use this in a udev rule.

	Regards
		Oliver

