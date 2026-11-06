Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794005403;
	b=LVkzPB3LEFIRzevzV4QzGrJZ7rx5rzLAbMuFnzGnvmVXux5uBh3Q8zSZozk4PI6ZwBNR
	 yPpb7a9uT2SEF7dcu1Gz2w/5QGftkpYhJeYFVq/ugzEfGZEGQ/J+WAABZFzJ9f2MXUqhs
	 Mupn7P0xEBzMSz5zyNVsGC3/j6Sp89KctfbC/3Zs4n7FtdTswPF3O374iL/kJ+/Z4IQtf
	 k4z+Y8VftZq6M+IweOcZjejBksEjTyETZt8l/uATK61/hVxWgIZA8agrQKJq8ZF8x8bfx
	 DwkH67xzaazeUPtBL2M93fguJNUVnKXws82v11K9KI/0STYX4jCoGwwV3YG92OF9A3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794005403;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=jdM5SiIPEimDeuq4rXZ03MYtBwz6JzOMb5ILjYkWvYY=;
	b=T6zI9kFATALKfR6XrvLGicQHAPK6qQ/isdwclPyUTzgtiazZ3P/UgjoOocdDOyKXndg5
	 3f42LFJ5bqQ9zWvmcJ9+EN/G0OBdckz5HbFEceSL1yVODpnDFAhZX0HLOcyxeJAsci4wD
	 YwnaXwFRrT/DNLPmnXkikYGjT/7qrZFs93JRxx1dghocdSA/zi8grMScfkhjtIKZJVmsz
	 hHvj01Oifk2Y6XnT8VbVhAXPGcSZsbreUF/BvlWLf6byVQaT4Mq2xgT8yF4Brity8b0kp
	 gdxjxMxkrWbEq8O2qV59O7Hf+8eUYRrD6F4YSQtsYfSKgWqSy9XUO5lNcq2oYa/kkdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qI1bRhXA;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACDD606A32C
	for <linux-input@vger.kernel.org>; Fri,  6 Nov 2026 22:50:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5ACDD606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qI1bRhXA
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3704d30b84fso791382eec.1
        for <linux-input@vger.kernel.org>; Fri, 06 Nov 2026 14:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794005402; x=1794610202; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jdM5SiIPEimDeuq4rXZ03MYtBwz6JzOMb5ILjYkWvYY=;
        b=qI1bRhXAzFSnRU/EQvqAwbe2gmyDRl5wFnVB6NTamKNoUPosaY1FWAGrf6PoI1RNtz
         Y4AfYLcvtJhSVUTDDIzYJPCoqkh74lfPpnXGovHd7MYBX4QXGqmTP7kRyvpNejOhq7Rh
         AesEV5adBjkZ57WwfE1euesjUqHpXSSFr9BTzIjwOZXP6lWM9WiwMyM0e9k9ksuX0Ioy
         qP9I8Netth6qF8bNafVPj77My4d73yGqFzkyu70tjB8dyY+LCIDpIxIPoXQQxE0IlqC+
         YJF8hrVqhRHKIxCceHld+WygAfmngi3sQTjyKxkon0j4PbUNT1DinQU6s4YOdIEhSHWQ
         N+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794005402; x=1794610202;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jdM5SiIPEimDeuq4rXZ03MYtBwz6JzOMb5ILjYkWvYY=;
        b=kB9/5eEfdHo6rEpMr85C6gfAGdcihWC2vfMZok6J6qVHep0r49HtmUswUsGbnfSXoV
         d17R9jckIvDNigvSaP1nJg2uoTykcYd0FKIxIybhY+3Fq86fDVISyNZSgtyacw6lGAwb
         VWnO/mnkBXvKKtjbvlF38FsdA3GZ0RpOhRthvBp1MbFfUujTzcBEmcQ9ULonJIWfIewg
         N45KnQtyOTEXGEi91+36w7e98ut01etqJcF7J29Aon+jMqyHRCdUI5ftd/lx3Ij1hI6n
         WYaxetIVYa7qP3OfUN9EGk7PBtjn2Z59NZBSlPY/Y3uyhsyQO13RxXn8wlWQW2u4jP4h
         605Q==
X-Forwarded-Encrypted: i=1; AL+hErERjwSYk8zm/GRJZ/bm1FLA1l6iPG2qSA49TLMqYeSMHAsvlUgFgTPpXQ96VWcA1GIDmme6V4lz8WEqIw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9XUyl5ODVkaJWMqqTgUstg7IobohlCxhQ5l7Fg9rnLnIBpJZCD
	JLNyY7BeDd0CH9zsUNSj0kakNNlQ7/UKbOXqfhjHDxLTk5NAG2R4hezw
X-Gm-Gg: AYBFou3RmT81F6HSultVHX2BA3fnS1IeLq/N/EQvhHASBKnofr6/dsD0OfvHLy1kb+2
	1w5ZM/H5fF4Z+u+nXp+cLADJBhVk/HLe4wGFpK5oRYzFB1Y12wGifSmcCeAa96g8JZh5W3Kkuo8
	JQaXNFSxKPZfHP6kdODQYSLGHUICNH+75nlwn3JHc4keEkwytDKKAZSPDyqAad2ckxFTzaG/LjW
	ttwvgX8i24uLMFCcMy0wczf7SslMOTYlsqloVLc0Z96JDbFozz57NK6k4pDdM/JXHVbCdPMiE40
	CtSeAQwbxtAk1VnsRjzjWdEJfm5Tj1jUIQKjsAutVapDL6rJolFyh1YlvpzVTlSiSBRiRRbzx4S
	kCZxd/MkrQvWQLN5o7/oCVHtgvi//i8lGcxqByVaVU78ujpIGG58BJ9EKBROWEaYowPeiQ6TUeA
	wWseyCyYleQmr7cgQe8Ym2JkwF40M+a4ih2F42fCgPJKmF5m06y7Rj5Tym0iPAXrCl8K4G2uesP
	l64UBbJAHq/pxpSL2wNOEL/CqHPNR40ICV54LX26F8/LdqJSoWClmOckOcCoFoARyg9XeYb80Ia
	UFxxhOZwaPF426l5a50sLE91rLd2VLxEqxSiHJF5yGaaOTPjaCc3Stc+HGIRbdQRgs44cBd+M1n
	VHI7klTI/yZsdyA==
X-Received: by 2002:a05:693c:62d1:b0:369:21a:dce0 with SMTP id 5a478bee46e88-36f7494d0c6mr5227807eec.6.1794005402183;
        Fri, 06 Nov 2026 14:50:02 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:5c0c:8517:173d:e24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa922c6c7sm11883707eec.10.2026.11.06.14.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 14:50:01 -0800 (PST)
Date: Fri, 6 Nov 2026 14:49:58 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: clicedvly768 <harepro29@gmail.com>
Cc: ojeda@kernel.org, rust-for-linux@vger.kernel.org, 
	linux-input@vger.kernel.org
Subject: Re: [PATCH v5 1/2] rust: input: add input device abstractions
Message-ID: <au5ZLv09L2l3LwZP@google.com>
References: <20261106223033.452853-1-harepro29@gmail.com>
 <20261106223033.452853-2-harepro29@gmail.com>
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
In-Reply-To: <20261106223033.452853-2-harepro29@gmail.com>

On Sat, Nov 07, 2026 at 03:30:32AM +0500, clicedvly768 wrote:
> Add safe Rust abstractions for Linux input devices (struct input_dev).
> 
> This provides:
> - `AllocatedDevice`: a newly allocated, unregistered input device handle
>   that allows configuring capabilities (keys, absolute axis limits, parent
>   device) before registration.
> - Safe string methods: `set_name` and `set_phys` accept `&'static CStr`
>   to prevent use-after-free since the input core does not copy strings.
> - `set_phys_from_parent`: dynamic physical location path formatting
>   ("%s/input0") stored safely in an owned kernel heap buffer.
> - Device lifecycle and reference count management: `set_parent` takes
>   a reference count via `bindings::get_device` to avoid dangling pointers,
>   releasing it appropriately on drop or post-registration.
> - Bounds-checked `set_abs_params` validating `axis < ABS_CNT` (0x40)
>   to prevent memory corruption in `dev->absinfo`.
> - `RegisteredDevice`: a registered input device handle providing safe,
>   inlined methods to report keys, absolute coordinates, and synchronization
>   events. Automatically calls `input_unregister_device` on drop (RAII).
> - Constants for bus types (`bus::*`) and event types (`event_type::*`).
> - Alphabetically sorted imports and module entries gated with
>   `#[cfg(CONFIG_INPUT = "y")]` and `#if IS_REACHABLE(CONFIG_INPUT)`
>   to avoid link failures when CONFIG_INPUT is disabled or modular.
> 
> Signed-off-by: clicedvly768 <harepro29@gmail.com>

I am sorry, who??

If you are not willing to put your name when "certifying" a body of code
I am not interested in looking at it.

Thanks.

-- 
Dmitry
