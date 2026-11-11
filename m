Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794423442;
	b=CguPL4HqdhFidNAROH4Z6+XIXbRPVZFojZrqqolZGcXq1UdcuTiylVc9U/9DETu3daBI
	 EQjQXLQhjuY0An9+eBN8VdCA5qjmd9m/tRuLnMGAQD1P3iICORwoHkKWdvPUyCj+h7uWm
	 UowgOUv/drdphXgs+EyJJvdx4Iv/UQdcyW9Om8pRV0rw77X9caYad0Vl8CjUgYMGhtpBH
	 zsGdWmecqA9Pw36g8jlZTv0Bpr1nfkfZlu9B7kbKRQE+XR7vFOsOZx1iAbddq4VV7ojoT
	 wcuqxlLEeR/+W4+3x17XQMrSi9ndl1mZ4F5+SCi310eFEldapb2SzI1qx6Z1gGe9P6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794423442;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Content-Disposition;
	bh=wtJszn8+3NsUlzqSLIs8TPLmW4IzbruAZxBfG0QVUns=;
	b=RQUiYif2F6D0p/iDtrCkEvhmq6PM+5g1yZsuxVnQLdmsoGaB9BmwZZGb5jW+ydWmy271
	 PSs27SKmwM6Lm32DV1MH6KjCZbVWVsNphx1Nfblorge+xhm9jnONvUr0oHdEqK6nT5UVT
	 Fw3CtWnCQJnVl3WxhfkvJYpmkXg7q96N1g2c/sYX1rS0UnGSIzIPG+Tmnh+CF6jUT4WXw
	 gW9LnfErwejLPyZzDOlHWdMi9QbRk8sKH1yVF0SnaLvZUqJ9UIUHJd7WIisIN7tW2D6LM
	 oL6L6eXRWA8muqrw/plpP/aGsYM7s/ICIMfRUgcBTKSOg9pbNL7u20lc1qqU9/Z8YjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nOLLAdM7;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3B3606A31C
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 18:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD3B3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nOLLAdM7
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-36e99cf7bb3so5256281eec.0
        for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 10:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794423441; x=1795028241; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wtJszn8+3NsUlzqSLIs8TPLmW4IzbruAZxBfG0QVUns=;
        b=nOLLAdM7WWN5RGq9Ch6K+g0yGqQnh0JFQr72L+JxFVCZ6m2gOW/28Vhl4kP8no1Ad8
         wl5pT223eSYdc0oosM1Zc6cZ4ADU7kItMTAcC4uv+25VvcfZbKc489wz3vHoUBxumYSN
         +Xa540XqedVtR9QisljxR5rBl8udqFTLpcp1DFqls25hvSUco9eWCmP0Ydc63Zx2d1Wd
         Jmzz+2b6zXr2/tGmweL+M9SjyMu6kM+bkq1LEOLL4Ukianexm9l1L1D/eFBaa6KteO1v
         O/JBOb5WDbdcl7Winie2k4QGE2upkP77xGvymIMEFBQWTwc6L2UKv7shh2+wvm03hSQQ
         OkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794423441; x=1795028241;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wtJszn8+3NsUlzqSLIs8TPLmW4IzbruAZxBfG0QVUns=;
        b=sNPHRXb58FPtGYIFXyovf6DJia0MUW4Kbr6Zvz+FlGQzRN0ZkW3PVHJXunCz44fgtx
         cz+pweW3X6VYDziaiRTFHZ2ehKDTEJ1T8CjFpNdaxo/QMdCVuklA8XPoDHQjCRgwyLg/
         xbAQQSDaqwWLu+7jeGsY+kPfZlWwMUOMHEQlQDcknrz18sKXxTqtca14HT6GHxnAfa+M
         LYX0OzFQesJfIMtNGmQNjZYwJReV99DfbkfmKVKGpgYh3QNCB3GfsNe1tgVTWVZUjl18
         hKVeVtXICwKc6hDhjYbIhgmywHJ4prIT4DFI4Mn3ixrdH/kZLT63QIQM8jphvsYG2hB8
         nb6g==
X-Forwarded-Encrypted: i=1; AL+hErF7jfDPlqDAmvzJww4rrjFefcum5c2MBUES42BVQgZHZ7sUcQZ275eWHvWUCP8CkHqedEevXoUZsZmT+w==@vger.kernel.org
X-Gm-Message-State: APuU4Z/qAkq4WsEPiQzjJZkNiWP5CzZ0/mLwE1G+rXCaWaFNZXAnP60U
	u8QY7ZpdXeAyBIV/X4xx2vd3BfPE2bD1y2XoBU0H37HM1p5ua/hVspaJ
X-Gm-Gg: AYBFou1Ni+jvx6r52iIWU1mJIpSuN6B1nE2pjorfNKcCqV2FSEs+OuF9YprYifJc+Ds
	zGyIcNQbgQ4/LkUl7zgS5yASQZP5mP9eROTn0HGSyn4A2Ko9m4/Fr1ffzbgUXxWZktyx1bHgnCB
	qBkbQf1XahmLLJSgWH4wAeLgBb78oKYaVa/5WFeUjT2eqmJ4H/AZPbIHi4Rozy24eqw3Dv/vVeZ
	UCa0OYQykZKZq7gNuc1fXlnfsI8tYSpV3nGblTTUZ8Pr6+UelBOXgHdaXaRECYnyibzTbm1mIJB
	KHd/4QGDwZLCXreRC64D3gUphtQHwOJoVCImaE/i5XLgTvZUC8QHI5ebvmI/A9K/XSAyn0GHe7i
	KjMsaFz4XW+gf5VlJ6P7zJ+0EU35TFovzY3XJgYmY+umhOxlp21Rg2UFpP0Hn4DRG6iDofC0fpQ
	UgRo9wkRHcthGVQiMmIohxuWUujYJpN9J9FE5YL5G4W6CH5LuIvEf2no9tDJxWk8T2NmV3D+VCo
	N39Eda6ggomrIgjxT0muBLpQ/VKIzdBmsjQupuULcKbbckGuulS6xgZu+i/GjgoZxnxqUG5+Z5v
	LCbsheou0hx2OuftU+zlfQ/BT/XHtyNNkpyvaKfhYPd6HORG51H1vMn1ZwqUyQeF3V2VW3o=
X-Received: by 2002:a05:693c:8854:b0:376:c352:2fcb with SMTP id 5a478bee46e88-376c36186d5mr2599586eec.9.1794423440516;
        Wed, 11 Nov 2026 10:57:20 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:311a:ad7a:93f8:96c8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520512ec1sm17645762eec.12.2026.11.11.10.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 10:57:19 -0800 (PST)
Date: Wed, 11 Nov 2026 10:57:18 -0800
Message-ID: <599a0d10a56740c40c801facee37652d@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org,
	linux-input@vger.kernel.org
Subject: Re: [PATCH v2 12/33] HID: logitech-hidpp: mark device online on unified battery 0x1004 events
In-Reply-To: <sashiko-outbox-208598@kernel.org>
References: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com> <20261110-hid-logitech-hidpp-v2-12-30743e91d83b@gmail.com> <sashiko-outbox-208598@kernel.org>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wed, Nov 11, 2026 at 08:22:48AM +0000, sashiko-reviews@lists.linux.dev wrote:
> [Severity: High]
> Does this cause a regression on feature 0x1000 devices by overwriting
> hidpp->battery when a charging event arrives, and corrupt 0x1004 events by
> running hidpp20_battery_event_1000() first?
>
> Both feature 0x1000 and feature 0x1004 store their index in
> hidpp->battery.feature_index and use event ID 0x00, and
> hidpp_raw_hidpp_event() calls both handlers unconditionally:
>
> drivers/hid/hid-logitech-hidpp.c:hidpp_raw_hidpp_event() {
> 	...
> 	if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP20_BATTERY) {
> 		ret = hidpp20_battery_event_1000(hidpp, data, size);
> 		if (ret != 0)
> 			return ret;
> 		ret = hidpp20_battery_event_1004(hidpp, data, size);
> 		if (ret != 0)
> 			return ret;
> 	...
> }
>
> On a 0x1000 device, a charging report sets hidpp->battery.online to false
> in hidpp20_battery_event_1000() and returns 0.  With this change,
> hidpp20_battery_event_1004() then sees !hidpp->battery.online, forces
> changed to true, sets hidpp->battery.online back to true, and overwrites
> capacity, status, and level using 0x1004 decoding, which also prevents the
> 0 to 1 online transition needed to schedule reset_hi_res_work when the
> charging cable is unplugged.
>
> Conversely, on a 0x1004 device, hidpp20_battery_event_1000() runs first on
> every 0x1004 event and mutates hidpp->battery.online before
> hidpp20_battery_event_1004() checks !hidpp->battery.online, setting online
> to false on every charging event and true on discharging or full reconnect
> events.
>
> Gating hidpp20_battery_event_1000() and hidpp20_battery_event_1004() on
> HIDPP_CAPABILITY_UNIFIED_BATTERY would avoid both handlers matching the
> same event.

Good catch! Since both features share hidpp->battery.feature_index and
event ID 0x00, calling both handlers unconditionally causes them to
collide. I will update v3 to gate hidpp20_battery_event_1004() and
hidpp20_battery_event_1000() on HIDPP_CAPABILITY_UNIFIED_BATTERY in
hidpp_raw_hidpp_event(), matching hidpp_connect_event().

Thanks.

-- 
Dmitry
