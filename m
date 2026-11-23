Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795464845;
	b=ZAkjyo+yumgCjSfthTo6oSgPA3KZ/a6e/yTTO2wPbNDzx64F8gJPQlU9f7Hh1UZspGe5
	 +dbx76Qo+JVHCFoQ9QYuig/d9BIUKglIdrloK0Ld2Jb06zGlm5qhmnWaRv9aTasOEhuQk
	 /IfT4f/0zgjnuaHsefR1wMkfwFpES2g0DMmeSoY6AHpLEROE6uya9LgiBCkt0okVmElEA
	 8HiWeeDQ3AdpyQ0tC6B+qlic2Ad8c4q+yO5ov9sVN88G4LxXsI71SMlGs+xnNmgv5nt8u
	 exoKj5u/7FB8UyqESW39T88JyVHWtKYQGCWFzTK+4FKsvhAbyDMYnFwbQii214tnsrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795464845;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=dgeT5HSySDkjBdmipJm4ZLy1GjB1CH3yde0pguoA2Lg=;
	b=oqZQOCbKTtJLYnTfYpgKRFieuP3exewHRi7KO9UBnh9iMwoibWbObo7s4NloaDsCpZW7
	 oUXx8kXZE8+DUfw76aM00XlnKqDmOk8Swn3WdNB6lqqrMmq43UsWW9IfECYhNNIBhgyET
	 c4tp0j6LvIz4Iwtf1Nk+9dixIE/+zVVaHuUb2/3Pp0nbWdOlaaJrQ42RiFkUhK0FwH2fM
	 9Eu/qcMj0xYjYNob2jkvf0QTyt5a+bE/1Vm7+EaK7PjhidpXFBhGFMLNCeIuyTMhIbAMa
	 ym3FaSgNETu7b6dEXTO+srXdVPHJcScP0mCqCRlQUxtfx/u5Xt6TKy3Xu+U6TsVTcDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="O/QYgvZm";
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E72B606A321
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 20:14:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E72B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O/QYgvZm
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-38699cf08dfso3771717eec.1
        for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 12:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795464843; x=1796069643; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dgeT5HSySDkjBdmipJm4ZLy1GjB1CH3yde0pguoA2Lg=;
        b=O/QYgvZmhabx3+D1Ox0nAqUklAwki5ts/e5ICD3coNuTFdwkbOEZN1+A7RpaXEaQwL
         Mp4iBvaRVCxjPQ7fVMeTNRD8T8FoxT7n7oxKfV3t3J8vEdjJqUCAKqgmMab+Ay57xxB+
         bcVpILohdXpSCjVMN7aXBpUyixQATBOkrAY8wSTNkf2jhPRN+Q1N5+TQTREXzogel4si
         QW5sgjsw7YTrPRx/77ku31KCZRv/wLnBT0F18Vn/OdNghH4QCpBIP9G2+idR7IOZuGCS
         itNt8FdcM5sVUtZT2ZP7qYHmDSK2KV8KeJFQXljcQIviEb/kursmQKvy6ypAemXGiOae
         +Q2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795464843; x=1796069643;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dgeT5HSySDkjBdmipJm4ZLy1GjB1CH3yde0pguoA2Lg=;
        b=g4tryDnVe+gCZcgu7bK1M+/NKf6envmBAW/18DuNXv5UfV6TIAxXYPXKJT3nDS4t0s
         Tdc0mR15RLehmFOzxp3rUrbzEPUGaBWx+OEurHmFv3J0djik6/vVAg/3DXsFME47tVnC
         6PAB4mPlRnlopI6Y8B7GKs9ILYiasckKvVFeXJWKElM9Bg4vPkcCmHwLA0a8BDpqPiiH
         E0jBo0HMmF36dSIA+o/z/GkMZKbFn1fLqtEPXP5gC15DOcY58wkVzzMqXiS19tBZ5O+R
         qTZ21pnbQ7qM4yoehi+iWz1xBOrFzKtcHlo1hxO2ydXrItjc1n4HOoFhNeY0/oFxwaAy
         oDTA==
X-Forwarded-Encrypted: i=1; AL+hErF9ZQYv5dryOaufMWePD6q2lZKn+hjJKUexMeyZuADCxf6mIrAKiaOB7aqmhK/8yB7nyFxGPbaUPGUaag==@vger.kernel.org
X-Gm-Message-State: APuU4Z+CkxqZU+1eA0EYPEte1PdpWygtL11jatrgXcDZc7DGO43wPnLI
	N9sJz9/7fL0b5h44Zzn6skH9BkdDQ1T3vtT6+feY3e5NtMnvjVGoDeMM
X-Gm-Gg: AZFdTZeHfvj/i3EDHHXEFPtvL/We51ejMMsWesq0uyp8CLWAu50zM4/bE/GOBnFoesi
	wgUi2iHoo8W2qibTRJtZyChm/FM+80cQA+NepIYJEqEYVw3tseP4mEAxXGDRRNLgEWSKUofCX4E
	wBkEjwlBAUP41ulDV84Wr1cWjSG3P3MAf9OVy3VDEM3jbKPWfXh4ynlcwqUsJuodT7l1kK4xaip
	qbho2x6MvwO7rZ6sAOP/DcdlgcdgnSbbPojhH0X9O1Ogp+LiDKeeHqzbKOtqtvo1V4lH7N/469c
	5K0ENhfl+cyGQz003XDbf4EFrGqvYTwGzwavHWB759wzy1Ic4svW7sjMjsEEAGwRVROAbf5gN+X
	x5HTme9ClvHzq33l8e2qyzjSxXvI5Sb+qk3fzRThu9lCLZXLAcDu0uZjFB17PgH29FuiQ0+hZ9Q
	dmJ8pWL1N3rg+FyhvB6HlxWcM4C2qb4kg45aJVCq54y1SRmrycHDqBA27Hi0KCX+UikllfKFLLR
	9RmC5060RjDM+ARy6CSeEw95Nvz9jiRfoV0dSXI1up+Sg+Ex2otz3oi5jMCFx0Fu1CHbsiBVLgE
	uBKi52nqWbGVeLfqsPncD8wa0vnC77Lhs29jnHR/sVNwx4EE46x9ri5kJkG5qZvetPgkm5s=
X-Received: by 2002:a05:7301:259a:b0:36e:800a:71fe with SMTP id 5a478bee46e88-3856c4b844cmr12383687eec.1.1795464843155;
        Mon, 23 Nov 2026 12:14:03 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:4121:d698:201c:9274])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386b9bdafb5sm4836352eec.9.2026.11.23.12.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 12:14:02 -0800 (PST)
Date: Mon, 23 Nov 2026 12:13:59 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>, 
	Ronald =?utf-8?B?VHNjaGFsw6Ry?= <ronald@innovation.ch>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 03/10] Input: applespi - cancel touchpad registration
 work on removal
Message-ID: <awSebEs9zEV7GDF8@google.com>
References: <20261123183200.3900004-1-lee@kernel.org>
 <20261123183200.3900004-4-lee@kernel.org>
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
Content-Disposition: inline
In-Reply-To: <20261123183200.3900004-4-lee@kernel.org>

On Mon, Nov 23, 2026 at 06:31:09PM +0000, Lee Jones wrote:
> applespi_probe() allocates its driver state with devm_kzalloc_obj() and
> initiates an asynchronous touchpad information query whose completion
> schedules applespi->work to allocate and register the managed touchpad
> input device in applespi_worker().
> 
> applespi_remove() disables the ACPI GPE and drains in-flight SPI writes
> and reads, but never cancels applespi->work.  If a touchpad info
> response scheduled applespi->work just before applespi_drain_reads()
> completed, applespi_worker() can run during or after devres teardown,
> corrupting the device resource list via devm_input_allocate_device() and
> dereferencing freed driver data.
> 
> Cancel applespi->work synchronously after applespi_drain_reads(), once
> no further SPI responses can schedule it.
> 
> Fixes: 038b1a05eae6 ("Input: add Apple SPI keyboard and trackpad driver")
> Closes: https://sashiko.dev/#/bug/linux-bb2fd773-6c20-468c-a092-6814f008077f
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  drivers/input/keyboard/applespi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
> index 96c504f28495..d964cd3ee5af 100644
> --- a/drivers/input/keyboard/applespi.c
> +++ b/drivers/input/keyboard/applespi.c
> @@ -1819,6 +1819,7 @@ static void applespi_remove(struct spi_device *spi)
>  	device_wakeup_disable(&spi->dev);
>  
>  	applespi_drain_reads(applespi);
> +	cancel_work_sync(&applespi->work);

Likely should be disable_work_sync() instead.

Thanks.

-- 
Dmitry
