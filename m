Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794362268;
	b=25o1FTnRmTRFN2lykoMjq91OBYU2Fi6kW4DKOa4ovvTl4zQrrWCN0guJCYO8XBe+fYXY
	 TQgE41nD7Ez7duO7CaR807NK0qIsoXmtjAXtNZZy2OHcp7gj6yabyJ0s98syoc7swIyf1
	 z7upvCJBiNtzHWdA50vXPLScASbh6tBteLBEyjrhsveewlwGjXKkD2Fhf6PbwgR1kt78Y
	 fVPYBZVEL+YAnv5OyVMyhp/2SBIkFXGVuMqms679htTa5OtRWuaFlCwq7JnrUMIfqj8Mx
	 H7SBLZ1lq7LF1OMpJ+t8B0VjLyYXjUbGyDa2pXUaCX6WF9rQ9SRR/0pHvyCpk0wgvlw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362268;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=n14r7j3tiWrKvVPoznKApe6IXK1TKN1rvekMdWEmVq8=;
	b=oF6dPQUc24prptldVP0V9BIRgAVLa3SLVthvZIQ+kCgbDEXkuPMJ97r15GUfDcBV39Vv
	 QE3ouBQ8+1TkfEeDG2udo3Br3MNyJ6N0zqp1Volc1K7gzksc7ImBXlLebOW/aqO+EkZoQ
	 0CZT5APZpH0B7+4NeKqdsWKilemV7XMFdo0BYZTg1d1BBTpUtb3u5oicDdA9DMxBjWtmy
	 TPkR9Pv7+pd4RoK1rwl+LppB6YjbRXdHSbgjH80DVonOyWCKnOgtsBjtv+TmkznkY0eqw
	 Xan4bDjCgHP5OmTkffMluLuCmhlBX5hVS9Gms24OF+QQY9HdqxT2dF0NyoeEOstt6hA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gc6j0gFd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.54
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EFB606A326
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 01:57:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48EFB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gc6j0gFd
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-67bec5dc8d4so1863727d50.0
        for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 17:57:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794362267; cv=none;
        d=google.com; s=arc-20260327;
        b=LUC/FqE4EKjvuwLF/rGprgF2nybR+F6TDfHIpGGHYHtbkpt/wvhA0yEXhWUXpdJaf/
         8bcJsBo4Nso2JzPXLB0FcF3s02JkERlaRhHUljtAW8tte7waz/bX8voehdWb4UOCdcWu
         x9Ag/fb0CnqhzIWua+4uhheIcCArbHJBdOFPZUjuH6L5rgZJiuUXktT2SwL6zlA/N9wy
         sJZoqV30vq9Z2Oxbx+oQnmGi8G6yBVRrbPzXD0QI7sE/YIrXgNw2ojV0OG6YJqSQa3IV
         w1Iq1SHfzOLKY8JvbM+xZ7+RCPMZLa7N1WXfw1rvj2ES9I3SCzlAAQKG5aStip+kYL8T
         EQHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n14r7j3tiWrKvVPoznKApe6IXK1TKN1rvekMdWEmVq8=;
        fh=Mh3Ae2I8Z4/i2tOSVSHOJ+d/SWsbVayNRW34JLP7mTQ=;
        b=Rm4gWpuzP01fI872+f3Jecal6Mx8+qRKv17u8l+UI8vJYa1kSnkvb13KQZg9iJOVlR
         4t7EiqQEPX3LNNbF8nW2aiRIzRJygqOHRxS8pP5DKtuDrkF/TWVXyRtQr4pOSpy+dzvz
         j1WsBmIyIPr8rIxzNkCCpcMdcrCduDzCVob6uRB+xQApoPD9VDbPq1uCnxK6KHdMf9Up
         /AObE/EkN4EKvMpaLMlZ1zJnt7IdKHBjoyo9Lwo5AEFuVGMsyMeZSztXZnrehKA5dTT/
         lJ9zpfBCmy4+K9S9AEOc75rWxdkLshQ+Wg35xudiA/FihnCuBaY1pbdNGK4HGrBTmHuf
         3tgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794362267; x=1794967067; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n14r7j3tiWrKvVPoznKApe6IXK1TKN1rvekMdWEmVq8=;
        b=Gc6j0gFdjp84SMRrPO2fu0xOmYK447dr9MikIWbL+L6NK7jKoog+HZ6NVoudTasbNH
         LJ7y9TEuxhgeeerS9XHsOriZlsP9I3yJZIebJ/85xKKDKCkHtix6lx1zRhuE0NONiJgG
         a7h8Jv2ugw++3Ihdu598/9ZN7HUCLjEZc1N5LV41B/UBlpZonluEpKgj9bbPkdck19Mw
         mu+xKtXj8defGbe3E7bpywhOTSdZ2aDwPfjoauqxlEn4is8HaqWsVCtPpVFsgz2cfcN2
         j6gHSFJl8OgTFVXunf2qvpdAUGEPBSpS0hxn+69Gnu7fCWOnumfw2u5QIUHhRrIAVXpt
         WBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794362267; x=1794967067;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n14r7j3tiWrKvVPoznKApe6IXK1TKN1rvekMdWEmVq8=;
        b=LuUOw0IejHg8C96GXwt+SGCv/+VwFa/2s2oWhpu4G6ct4vP1dhUoJJUVHFIA3dn9KC
         ztP3g9SB16fyRNOtXrot3M38KXjEqRH6ma5p1yJ/VLQJASk93Qw7sUB/YwgTNwViZt1P
         tCbq4eDRaja4KiiAcaai+thmG7QT1cDnZuUQoquWKTCdKGjrncuV/FY7tzMVFgZE08NS
         2D9oQVasaZb6muwWIn5U31xAFpDniXH13+F2iwcYrY6g++nQmlnGOugKCDPEGS4t1Fix
         z9c/0MeIcd6gE3As8O2fSC0EwnZUgaxSRWTc5H+yVtUs0CWBdXBbPy0sEOUqwg724rIs
         MG4g==
X-Forwarded-Encrypted: i=1; AL+hErFZf6jdMAKaJO6qSDdnWkesqkZnt2O2bWpiTIheyP88cFrJc5cYxbgRCdo5i4Y05mFPvrnk2xw84QcMtw==@vger.kernel.org
X-Gm-Message-State: APuU4Z85IsAXDrTIuaAD3XkBkjAPRXTFCt/qTxiSgtUBfatlaEmAGjbl
	WbT7HBAWTuBPR7Fa2t5NE926Qd8e8BJBvLZDAggT7buJwanTW3/j/58X0zCAoylAvNIG5AiMYp8
	pS9PwnFd5uMiLekDQLfiu6Dkuh3ztDFI=
X-Gm-Gg: AYBFou2kYBM4J1Beu7+WedFtuGzM5wKEFGEBFWlu1qp5N8gZzOKRUBBfBrVjwk9cn+e
	XVLXqg6v7hDjlbFaN+Qr49Dsy6OIAgz3/e2xX16R9KEBO/qly1fEKy1zHOv+nz9tTUcuypR3Qoq
	tyft89CNz+wPjiz9x4BwH+cPUHJh49aN9z0xV8l67rB/0KiPTbjLda73G50YSP1ufNsHm9+zF23
	yIqu42VcL0SesGm9viQMmvuqoW9wT1+mhMw9Po0lAgiAhXvj9aefuqRysncexD4vMi6bAk2hgKv
	FnJ4K4gOOT7gqXzPpLYnWvPSaZ24Ri/LjoT2FPIwdFeUwh65xheuETRFfgoyvv+IVgyStT89dCO
	z+PiTMhn5jzN3r9qydNZRku4XZXP8wnLvDx16JK+DnPkyqlELgSMfnrOzeLJBuOYDUBI=
X-Received: by 2002:a05:690e:80b:10b0:679:a190:cf21 with SMTP id
 956f58d0204a3-67c67f54906mr653906d50.40.1794362267159; Tue, 10 Nov 2026
 17:57:47 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108-b4-apple-mtp-keyboard-v5-0-e2c97b82669a@gmail.com>
 <20261108-b4-apple-mtp-keyboard-v5-2-e2c97b82669a@gmail.com>
 <20261110-accurate-unselfish-cockle-3a39bd@quoll> <CANpmGNufv4_PM=1D1E-KRNQOuCPj8k+sGUJ1Y2HkkAtoSuL0Ow@mail.gmail.com>
 <3b5ac166-17aa-4418-bdb8-c7b9de22b991@kernel.org>
In-Reply-To: <3b5ac166-17aa-4418-bdb8-c7b9de22b991@kernel.org>
From: Michael Reeves <michael.reeves077@gmail.com>
Date: Wed, 11 Nov 2026 12:57:35 +1100
X-Gm-Features: AclHuK8xliRxrSv2YHsVIHXaEDGub-xO05VL_zEYwoOsVKkETettvgLLeJxK-6U
Message-ID: <CANpmGNuQQY-aiorBaNmzyywsVNR0P0NzCXnYweJ9fmkydYO2Gw@mail.gmail.com>
Subject: Re: [PATCH v5 2/8] dt-bindings: input: apple: Add DockChannel HID transport
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 10:30=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
> I would vote for input/hid.yaml
Thanks, I'll do that one. Because there's no change to the actual
structure, I'll wait until the 25th before sending v6, to give some
time for the mailbox / input maintainers to give feedback on the
drivers and anything they'd like changed for v6.

Thanks,
Michael
