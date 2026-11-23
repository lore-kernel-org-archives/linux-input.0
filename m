Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795457842;
	b=EbFGkeZdAcasj3whi6TKh/I2N6ztnzI9e1LP/FEWQ/Rstpng/qEIhNT79bEcJ1RtaEXt
	 Q6VypY0A/S2JqneZnMfd8eWLO0GhgrGlGf8ItoLR3psSKoL6xIvvpja4S8AgfpiG5+xZx
	 6oUbaCiijGsM8GRv0gfbsj18jCRL7BCAPV96ng2Y6PADdumyoxwpC5AXoe90SMMSin6oY
	 2vVKoSDKL30MCeT0rjOvJ0RE6Xm1NX0PANa+I2xB6NE9N8iRoO2/4wmy9LmVseHrsUoZE
	 UOviFmqEuAo/j/2+H8hVjxZ35PG4urdud0da2p8TgIFApVTEH2SkfgGNynGvII/aUGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795457842;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=nutOLNh5W4dTyqWoDODtl05Z3AwT5FmB7YX35PdwCns=;
	b=v8Er2DmqVR7AdbtfYACJejY0+CMfVy6zvxdbHN8xOyh89e2M6eHtUMyZM/P3jVKR+A2F
	 d6bX28fcx4YjNlqbKSFCCoSx3akFE5HlPSVSPpvMsMC1zOOVXHigV99VOZVii2RkZyykp
	 XA2RVnpMPx2MeLDfLTh5EZGjXomaAj3iP48FjYk85N3hS/M6UbObxpfk2S3FVyDjL+GQk
	 DUD+omXIWfLOVS5pjwadjE8J5ofQqSduiYBJamOn159czf7LbssSSkISftrq35Ygp/0ho
	 QORHDimsfrGwkwTdBCZlyA6ZdjRBoU0Thq48HrD/kzEfa8RfcAsN3kHP+GRHNYFsskA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="rAYH/KsP";
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30280606A31E
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 18:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30280606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rAYH/KsP
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1aefd1bf74aso1536000c88.1
        for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 10:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795457841; x=1796062641; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nutOLNh5W4dTyqWoDODtl05Z3AwT5FmB7YX35PdwCns=;
        b=rAYH/KsPQ2r/RcXZrUUK/+RyNmCDADQytEDNpjaMcCXTfiXyWEnnWAeUTHlbeT1h/Y
         qHwaPsDQAmRjVTxo3yHP/ZxdK2d1pQPZJTuRho+pPQ54PpswU33GkPgAhpInghjXSwrr
         nTGajwtB+qtkURu4+ZKSqSL3sh8sqJhc2yEryyEwGVpB7uIOdec+bJD7aF3syrUVN8Xr
         aye+4YEwqCu4SqRp+p75soLvgnuiZ6sRscgSsHz44gG7pV2rY0DpCQ7KvVAhkwx1+C5U
         dh41FWY8UzlZRHj+N1E6SmqbM9tBGQqKhbGxWZ5SH/nVYnxMMFCwy3o3GYL116ewZSfF
         uNPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795457841; x=1796062641;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nutOLNh5W4dTyqWoDODtl05Z3AwT5FmB7YX35PdwCns=;
        b=qh5ESmHvYFHTINy22dszLpjg49Ddz6IP8O7E5y8gOVMY/fG59HIFsUO+ZZ7mrRz9+0
         yleCA24FTmvFFAsnbX3pgAJJdJTTfm1dfdQdcis9vJdpQhJFKWhMkLgRFz4zr+s2QnTt
         aOelQcQTW8Hf8svj7Kyh8Cl8YQKBHkZrsO/dMf7/6qjFkmYY27XCkgoyVDG1Owog6EVx
         HsY0JsZmemI9WW6wLpnlEPW6W1IGqJ+aW5BTHAwOlZPHQEPgOgrQwAiLuVR28+FdB4YN
         8q4boUdVe8J26hg9U1/N15FzXQ44y5nDirmCQHhug3egLBcN1Vx9g8UlmOVkq7qbextY
         YuRQ==
X-Forwarded-Encrypted: i=1; AL+hErF8WCf19ajusTV9lbYOsdDFBwzdoVCxpzHzgtbdmKzaqi9y2S+IkknoVLlAFy4FZTVeJbRrQolrEE7sQg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/4PYg9qeZXuMEI6omKr5OSBItDa96G1vOiU0eUzP6rFBLX6JK4
	xGXQfkr56KR4JLw8I+nL84ujt7TuBUsaehGsscBwlw08urmLwUbOY5Hw
X-Gm-Gg: AZFdTZeYmFp4+q+A1Y4hu5/D6+iWUSaEBAmnfE8inzrp158cC5VYFNN5ey92Ac5yf51
	spILq/owTjUEfJ7NqRhK+/ZOmFXQ/6zhvRP3DiH7dH3xxRFd/vsBtLpUgchOYHgNwi2cq/+gCy1
	ILimIOHZFx5GBGisXD0jQXTgo8kvH1p3dCrl19IO4lRiOr7c7DB9l6GV49GO+jUTZc+jRcl+pkY
	l9m2fEkqhtWL9SlhekSQc3EQiR9XipLcjt44421eFZBtUkMj1jBewOj5vsisgNWBGH6FPhwIPYf
	X4Qt7h3PozrQT2ajizvej2PX+VCuUpbizXnbqbgAGzeklVrWsp5w5a+5n5Y30nHmPoS2u5HEeN3
	DkefrNCnnhbiVZIpdzUznswfCbp2MIFnXOvX++wF73jCmsBadEUCOGoQ5h2jOopWpc6LHAjQH5J
	/UWQyUZxbUC8Qvetd++4Ni0lXiXPvFpzw4xoLY5XAifykUjKmMyVqx29P2NUC0NsdZM4YQpmGun
	qfKz7PyxkMYe5kBskeR+Bglr+Rzk3/vg4kev5pl83MOrC6nidx1XJQJH6VWeMs0VEzykYXRkKRB
	H8AVZ4HhBnw5BZb6KGNJgOpj0BTe2hvIzMdii3I7OR0o7+7vb1L1p3NDCtfUp3++VBD+xPOz
X-Received: by 2002:a05:7022:1703:b0:1b5:64c0:d2be with SMTP id a92af1059eb24-1b564c0d31fmr7645119c88.19.1795457840287;
        Mon, 23 Nov 2026 10:17:20 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:4121:d698:201c:9274])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b556840494sm30439137c88.12.2026.11.23.10.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 10:17:19 -0800 (PST)
Date: Mon, 23 Nov 2026 10:17:16 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: david@ixit.cz
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Andi Shyti <andi@etezian.org>, 
	Javier Martinez Canillas <javier@osg.samsung.com>, Rob Herring <robh@kernel.org>, linux-input@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	phone-devel@vger.kernel.org
Subject: Re: [PATCH] Input: stmfts - restore touch after system resume with
 the device open
Message-ID: <awSDI1T2DjX63HlL@google.com>
References: <20261123-stmfts-suspend-v1-1-4b2276879e8d@ixit.cz>
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
In-Reply-To: <20261123-stmfts-suspend-v1-1-4b2276879e8d@ixit.cz>

On Mon, Nov 23, 2026 at 05:13:41PM +0100, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> stmfts_resume() only calls stmfts_power_on(), which re-initialises the
> controller and deliberately leaves it in SLEEP_IN, assuming nobody uses
> the touchscreen yet. That assumption does not hold for a system resume:
> userspace keeps the evdev node open, runtime PM still considers the
> device active and stmfts_input_open() never runs again, so the
> controller stays asleep with scanning off. On FTS5 the controller
> interrupt enable command is part of the runtime resume sequence, so the
> result is a completely dead touchscreen until the input device is
> reopened.
> 
> Factor the scan enable part of stmfts_input_open() into
> stmfts_start_scan() and, when the input device is open, replay the
> runtime resume sequence and re-enable scanning from stmfts_resume().
> 
> Fixes: 78bcac7b2ae1 ("Input: add support for the STMicroelectronics FingerTip touchscreen")
> Signed-off-by: David Heidelberg <david@ixit.cz>

Applied, thank you.

-- 
Dmitry
