Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795501587;
	b=e3FvoOuCnQVvdJW6zYpPwz2C+qcjfj4R13Xx8KoIBlN0YcqC6VJqeX5EoFEX5rpIACdv
	 1bmlUnodCGmz+m13XlBQknC7y46jS2awX+tSHuDP//yl/3s+gLJRImVXGJ3QUgyKlQuzA
	 jLBhK0H6teQTUc7UDFogIyjYfGATroElqPRTpJI3D0bNEnPviNjEIq+IevBUNpk53kJ0I
	 1VrXUgS1rN0G4jm3mJ7xuHJL/QLAM52a6B7Eo8Lb8on12Im7khesNbol8e1YXCtcXCHsg
	 qX1MNTyfG4RbHdsJq6y+aFL9RUMzVDmfkOV6DDnGFX1Pc9S5hbcIO6F01+ESn0gQAjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795501587;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=k13cl8AnOgXOYxh9rMCZd+VqMKK57TsIjB6ASgYtOw4=;
	b=zMNAiNvrPQagYecq3fSTYKENHJa+xmBoG3x8mKgfD+H3kQBzI3zXF4EbjWOCu+yzfZvn
	 FjNpC8mGiMWvIEmHiJP/dNMGjQawZ0Q5UYKoL3wHOUkE9d4FmOGTVtUa3bfIpNFWlnlfb
	 tKcPX3lgfktfWFJ9a8eZaOtBCxeGfx0ZIeXhqgMQ2p+s+n36pxhCjprwHTY6iaq5Ea+Cp
	 4LowFxOdIVcX0LrrmS51AyHrC6Hez1h+Xxiy2QfobRrMxY5bB4ZLzLdZdV8F2cfwqYcML
	 RscnMDJyGglVOShyF3fpII7EN5zG4S9Ktf6eSatl74kfZP5Esx6FAhqskhgIOrg+GBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aw2NmU5m;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FC7606A326
	for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 06:26:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91FC7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aw2NmU5m
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-386c336eab8so282877eec.0
        for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 22:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795501587; x=1796106387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k13cl8AnOgXOYxh9rMCZd+VqMKK57TsIjB6ASgYtOw4=;
        b=aw2NmU5mXIfml8zWv2yXkgGBsdqu0t1jHUU7WofPUO5XM93i9Id2hMdudHcF3xP4Bt
         gndhdLLj6iSmZdDlUp8knzGn+AjdVC04G8TCXIkouk7gAtkgCiqZjbo9rb7A+4YpLG9i
         DTFhf1W20CWS11DtXdXNq2spKqNYuLnRGnvSO8k3QBpTskFPW+4BL4gYYq/jVZut+zKY
         cabPckCi3C55CjRPgcVnzV+du220fYI7mjU3ydGU0p741gRVqGFIapvLGQURFOOfv3o2
         4906pe2WYq0QGwkqb83H1VMVThVX/wRgSWBrTpCk8CI/c7B1BGVD2WNXvBPsmK2Kc3jr
         bIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795501587; x=1796106387;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k13cl8AnOgXOYxh9rMCZd+VqMKK57TsIjB6ASgYtOw4=;
        b=feH+Q3tGjP77Kqlo0EfftdIvjlbeQ+TmeTSh94hEBk6tpuv4co/pGLAcAYs94GQkcU
         Xqr4NW5Psozm6kmkNIid819xHLiYMbdmCkfFJ5HDageCEoeOiEQNTor7wpRFpsThQEj+
         nXUvNfoi45YT/vfdJ6faBWjnsFuhM1IXTS2hfBLfhu1i7ecbeZC1KirP2TjvlNtIdsKo
         9hjMaDOxMKalTDLSM+d9V8BRvwx9tdECO18t7DdVXWHJkuuv3n7IxMRLucby09i1nZMW
         e8I30CEd+6ZKXqwI9fsKtbLdlRA6vysfxcPu+vGHhjuDgw8w+krIno9qCxR9tUGCZ1pj
         MJLQ==
X-Forwarded-Encrypted: i=1; AL+hErHDr6dViSu03/HoHsF37ZRylhzfnshFRyKM19nA/kYMXBhThDE/NV1Ia22DCkztcvJup3bZuYvW/hQs9g==@vger.kernel.org
X-Gm-Message-State: APuU4Z853KFJIXx07qjOoPKeHYpFvrZw1LJI93M6dGPPcypC0Zrd0DpK
	nuIR/uuz9mrrV8sEkespGVE9hPjY7SntI+bYE916L3vCyY2kNS5kJryx
X-Gm-Gg: AZFdTZcyEC4lZOZZ31n6kmK3DKmpNdS9Y8+ukbM1usaogN/YqxPFNshfkSbKbv8BrVx
	nLl6BS6D7irZIOavL2mSA027zndvADg3MIZDNl9dt8pDcyVqN15Pb2yGjJDcJYimZ1X7rp8Yjv/
	nmSS8EiLot4a6mLqjSJnipAT7rFzNQ5k3QgcA9lQp2U7SoRI6+Cs+r/Saat6VSMoSgx4kKI0r7D
	daDlYR6y961L66+ElnfklCFBehvvKJIqAVUaXo8976RdBhUJp3v+CTLFz94rQq58yYINjESSvlr
	h5nA2yyFJ8+o+HW9qdURhSGJMhf9Nuy3Cr+AMUqLONmIfwzCuvZbd1NCaa9iZ563m//NE1pn7qe
	76+oIkrODHXztZ1cYNTimaIWdWv4klK1f6gnb89mUmEZ2B7mwOkv1bYJPiB5Rd2Cvsr83zBnx1t
	3g5YG15d4TMefhVOxRtMaQ1bgHlzhbu0BAmyF4r0kaNsmoygww1e+S0sCq6Z0hVPQ+OggIqFEXD
	WziSgIRSIHlnhMVb2F0SQZ4u0zUPpkCwC05273xbEZvo7zHBZtTLTBMyB5EqO9Mtz57ou8XztED
	aRJiXyWgjQzaRqDrCiMK5UMeWMgTp6ivsdBMK/01UUGz+4IZxs04qfIzc8Pjo40KHuprqoHi
X-Received: by 2002:a05:693c:880c:20b0:386:ab85:a011 with SMTP id 5a478bee46e88-386ab85a718mr6427409eec.27.1795501586545;
        Mon, 23 Nov 2026 22:26:26 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:ee3b:b892:771b:3bc7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385646633d0sm72739389eec.3.2026.11.23.22.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 22:26:25 -0800 (PST)
Date: Mon, 23 Nov 2026 22:26:22 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Alexander Letuchiy <asalde.le1@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sean Wang <sean.wang@mediatek.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Mattijs Korpershoek <mkorpershoek@kernel.org>, Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org, 
	linux-input@vger.kernel.org, phone-devel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v3 4/7] dt-bindings: input: mediatek,mt6779-keypad: Add
 compatible for MT6895
Message-ID: <awUuAzGu3ZoADKyB@google.com>
References: <20261123-initial-mt6895-v3-0-95c46597e63d@gmail.com>
 <20261123-initial-mt6895-v3-4-95c46597e63d@gmail.com>
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
In-Reply-To: <20261123-initial-mt6895-v3-4-95c46597e63d@gmail.com>

On Mon, Nov 23, 2026 at 02:18:37PM +0300, Alexander Letuchiy wrote:
> Add a compatible string for the keypad of the MediaTek MT6895 (Dimensity
> 8000/8100) SoC. Its registers are the same as on MT6779, so it works
> with the existing driver through the mediatek,mt6779-keypad fallback.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>

Applied, thank you.

-- 
Dmitry
