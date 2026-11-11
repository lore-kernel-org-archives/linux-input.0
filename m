Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794423447;
	b=QZ9yOpEUKOrjEBeSCDr8qrWqJvy0/AKVikpT596B13XPYJXW21BdJTY3iDU5Uy4y8RNC
	 dDEJch1CL9h0v5tGKG3OmQLIpcYm6RC3iBildWAhTPv8arFbd0tMNRB2E2K+8LD//FBUe
	 uiE5gHQ9mKD4A6GslsG0/G5+OgDeN1BIb/WfL8InqQ1EXCmCQll6zqGYSeZa3hPfkPBkH
	 xwm9teq9YYNxO7GUCLUKhIQlzEV5N8WZv2f5j4Pmwjfdx0EUpSJv/DjQ+22ItLv2/TE3i
	 /I0LipSy6BsXupl52UtzozvyQa655kTeKIVHkdcP0OyrfHPHo4mMu++RKqe8SLR6CaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794423447;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Content-Disposition;
	bh=x5kazdw9pUpWwrvAjh6CexZLT/5KSVUjeRcT+ok0+pI=;
	b=t3uSVW7JJUEuKzNbU5aVd1R0tecTMN58OGvivpQ+1Al4qYApCeheTIqHgC2sRXRF15a6
	 WHcQG198eEnP/l5t2ZnLiBwNV2ZjXX1EAomy2uqN3RUTOJRFyRfdgXuicbh4qA+iUqQ7m
	 08Nx7w4X+ThIvZnKS1rpfAttW/zSSWHr1mYfsVng85Rs+FcrOgptBNuiDx+5EaYuPUTCw
	 436ZMtfVUmYnI8fEFq5f3CTyixNx39ITXzmSEHoM5+S7S9XXU/jsSdJN3ZCslv+LInYJ+
	 Zshgd9VmTx6N300JDdya2ncwSf98xCA0r2UkCflcT9+yG8nVfb7jTAWq1wj7kO0qQ4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SZx+4aRj;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5717606A324
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 18:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5717606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SZx+4aRj
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-37071c0f42aso5948062eec.0
        for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 10:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794423446; x=1795028246; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=x5kazdw9pUpWwrvAjh6CexZLT/5KSVUjeRcT+ok0+pI=;
        b=SZx+4aRjXswlYlmhGk/53X2qNvtnHcTAZ4kufRpVhqwCMsYBF4GzWyu12BlIeSdEzS
         yueQX8GnjOLvydE++iF70lzB+/e7p87DRKORcw7++aWaB523F294QF+W69NIrXd874Wa
         uioIt7q5MgfRlubbnt8aLKsA1sY5y0dJHcitebgrC7Htzow4V99/MpIau9J3rjh84Pyi
         eYPIH1akF+74KFMhS+t7R3PoxRhyBAzGNbLKnLXerVFN9PioIBMetY4S4USvOa4AUBOg
         sNcfOYovxLnldEnm+RzyeXgIWKBLcTvGhp2YQe+8QNYdoH2+PYgXOAp6Md+GqTnWWd9S
         A5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794423446; x=1795028246;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=x5kazdw9pUpWwrvAjh6CexZLT/5KSVUjeRcT+ok0+pI=;
        b=an7s2zMu+bK/EJVD68UVxlvVaJQrU+YX9EI7INXnMT2xyLoy2UffQFKHPmTDurtMBf
         HKywreILphRiWVquis8MKTvjg9itrmUKyD8U0HudtAwkdrPLd4kPOn8mIEtLaHGtqYly
         OBjA8Ay/n8E1XtZ5PKSdHQSkNfIUCekf0XdOES1XejtKmmLE+kJVWgbtNYDHuWLvMt3x
         AoiuSJi7xAKf9l6LgBI3EIllPskCxL+V85uxabSEUJ+h1E9OnC7nusvJ/QCkcZf0Nb1u
         wwDI7dDwUvb6Ts2RvfiPExSevsBAHXu26xYOilKIN1mK9LpgkOzNS/Gg66V08Ys1yO5y
         Xjqg==
X-Forwarded-Encrypted: i=1; AL+hErET6+lcwDZNgcnoCxfi9HAxwCSRr+k91Lx/QNtmnGIstyjcMVYJNE6pkTW9m8gvirH4r4yH0hpum0lK3w==@vger.kernel.org
X-Gm-Message-State: APuU4Z8TTksRCa3PeVHY6n+86X6Onc7ykIZZsIVCIpgtrHZEyt1USKA5
	bMMYKIegi5z5BjHXJ+btdCw6dMklgaCbMUBZwVdLc/at6FYi2efiYmNQ
X-Gm-Gg: AYBFou1Yefv/EWuUSUUEAM3ezselGIzv7Kmt+ZANKCg57+jsX7Rs7cSHxb0rWfghmmu
	Svufk3wGBS3vEpAsWMMY20yf6x7YeDGTL1f5Q+g4If/Kc6mt3o/l5aSBWgpXJDsaAqErms4T8XB
	Up0jB+kOOlZFL4aFroByaghU3waj6cx1rzo7kKFF+oCs/tV6d+t1CrYKP/sybIrqzn9nCoNiIhQ
	LhMa5HOugpwNWxMbglyHSby2pUhIjfE0XiYMMrVdamgt+/HPMl1FJyKf53L+HyFk1ojDxS0bU75
	uAwAugOF/4Og8xwrjuIM8z/P1pmAVQh32FBRcn382GmmaWk7+Sp98LXOEl8hgz2JmArIuF7DkHT
	cs9GbAVcjobFjkzBDeip0kYHwGL9NpxdzgR+0WpLBPQeIBeScjUdQk8UvZ5gebnRVqWmj5pO6y4
	PCTmU4l4PXOPvo7rgKS21p83RmYB42gy3NNYfvMK7pCQi5SgV2IuTDCZVt67VRp8rQcjlzgsJ1x
	x/uelnZTcs/gXrl5E/JDTNO9r7UCWKbn8So4jy3cgghAa0DCtnYhhzO9tx/QzvKY+FJ0XCugV9a
	dAmYm9PosRHkwUUB985cy4La4hQrjYnhZHn9URMx8yw/Mc37XV9hNHHQKwkIefRMzX7cNQ==
X-Received: by 2002:a05:693c:88d1:20b0:36a:3ac:b15 with SMTP id 5a478bee46e88-37686d34463mr3531908eec.36.1794423445666;
        Wed, 11 Nov 2026 10:57:25 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:311a:ad7a:93f8:96c8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520512ec1sm17646491eec.12.2026.11.11.10.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 10:57:24 -0800 (PST)
Date: Wed, 11 Nov 2026 10:57:24 -0800
Message-ID: <881603869168da758913733db4391b6a@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org,
	linux-input@vger.kernel.org
Subject: Re: [PATCH v2 14/33] HID: logitech-hidpp: expose charge_type property for battery voltage feature
In-Reply-To: <sashiko-outbox-208625@kernel.org>
References: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com> <20261110-hid-logitech-hidpp-v2-14-30743e91d83b@gmail.com> <sashiko-outbox-208625@kernel.org>
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

On Wed, Nov 11, 2026 at 08:39:27AM +0000, sashiko-reviews@lists.linux.dev wrote:
> [Severity: Medium]
> Does exposing POWER_SUPPLY_PROP_CHARGE_TYPE here cause sysfs to report an
> active charging rate even when the device is unplugged and discharging?
>
> hidpp20_battery_map_status_voltage() unconditionally sets *charge_type to
> POWER_SUPPLY_CHARGE_TYPE_STANDARD (or FAST / TRICKLE if bits 3 or 4 are
> set) regardless of whether external power (flags & 0x80) is present or
> status is POWER_SUPPLY_STATUS_CHARGING:
>
> drivers/hid/hid-logitech-hidpp.c:hidpp20_battery_map_status_voltage() {
>     ...
> 	} else
> 		status = POWER_SUPPLY_STATUS_DISCHARGING;
>
> 	*charge_type = POWER_SUPPLY_CHARGE_TYPE_STANDARD;
> 	if (test_bit(3, &flags)) {
> 		*charge_type = POWER_SUPPLY_CHARGE_TYPE_FAST;
> 	}
> 	if (test_bit(4, &flags)) {
> 		*charge_type = POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
> 	}
>     ...
> }
>
> When a device operates wirelessly on battery power, is full, or is not
> charging, reading charge_type from sysfs returns Standard (or Fast/Trickle)
> instead of N/A (POWER_SUPPLY_CHARGE_TYPE_NONE).  Also, when a wireless
> device disconnects, hidpp_connect_event() resets online, status, and level
> to unknown, but leaves hidpp->battery.charge_type at its previous active
> value instead of POWER_SUPPLY_CHARGE_TYPE_UNKNOWN.

Agreed. I will update hidpp20_battery_map_status_voltage() in v3 so that
charge_type is only set to FAST, TRICKLE, or STANDARD when status is
POWER_SUPPLY_STATUS_CHARGING, defaults to POWER_SUPPLY_CHARGE_TYPE_NONE
when discharging, full, or not charging, and is set to
POWER_SUPPLY_CHARGE_TYPE_UNKNOWN on unknown status or wireless
disconnect.

Thanks.

-- 
Dmitry
