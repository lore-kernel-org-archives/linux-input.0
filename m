Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795436282;
	b=uCxy83YT6bksp5/gQlpqaxuGj7m7qgYpcHAn3CMqRu3E67F+EkvCDHYnwwYz0TX0EjkV
	 I2pzZ/2ZrJHNme/KQbHFDatip39r7rl1qkHL9BrLcIXnK6cLqFBV8KB4HvtanubUMyCLM
	 mzvpMjcMd3K1x6xKQgPU2/ntWZwrlnsC0yReighgqlCuo28lB3H+7VkhcmqQA9g81lD9Y
	 WxDA2EB0QRUWwQ1j7pDjCHXrUJIadiGufJ9cJ3MJTCmZNFN+wZ6PaWxBeX7R5PK9CKHZA
	 R3tCFZpyzfGxAjXS+qJXqfsgawXPMx8YAmdaYhXZfXKiOidH+jnRIpCT/Dc13mweZ3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795436282;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=a88ULBFAQx4LAiXbEAQvfvekeJqnITJpUHZuo0L1DZQ=;
	b=p0KNk5FQ1X9j3T9dkaHWWPrA+339ylQv+psSVOUp/+GAKg2HzHsbXR5m7Jv1rrbPO7ZM
	 Ngr0MSY1hq8nzvcTWoioWaDRGtnK66dxadj1f4VY3M3oQI1ULrecIrzaqtIusp3Ama/92
	 FfzXf6Wk1tbFaSnzISVvBte/Z0m4rLNL5eTKyXI1MilPtGCH4pVIurTWs0Y2+5JH398VE
	 UkZZjySZV0RR0cQ09g6ECUUTKTHwVpYg04keCahliQk/sAeqfP/qrOgX4bFugjZplMoQ0
	 d2iGJbNlWigrN2EkUajKAoafn8hEmxhOAa2pDos+IBno+jRucL1uFayTELKopuLL9Ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d6YfVoas;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2726606A321
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 12:18:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2726606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d6YfVoas
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c50d3ac6b51so861401066b.1
        for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 04:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795436280; x=1796041080; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=a88ULBFAQx4LAiXbEAQvfvekeJqnITJpUHZuo0L1DZQ=;
        b=d6YfVoaswLbKwgD3P19bFRJ7ZURGLAM6cgUFg1Az7CArc+wqW7p9oN5XEDfz/OWZM7
         BNhsP3uqnO00vH5pTASrYPmILCkbDfnqyXbzN1aOLyXO8gKYRq0+8PPp6XSsqmClS/8y
         QKiU2lH2JXFvZ/cONB9A/We4EBus2jE8TIhb0YJYYCNbsds4KUlnma5I/AYVFUNggDM7
         VwxyJX7CVMT991m7EQNBh0qTSsWXSpLL8PQg+qDdReUbN6U2+9KdXOVGrc0vAuPLIv2T
         56SIttjVScC5XssqtGrOHAGAyglgIEmqbhLOnpJbhijs2+qCpmOi+mgWNmrU6hfO5c0h
         qjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795436280; x=1796041080;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a88ULBFAQx4LAiXbEAQvfvekeJqnITJpUHZuo0L1DZQ=;
        b=VsGngFn6fFqOfupRkQP/la+KA+kYu4jzoembGe5DjgRT0U9LhRa0SNDbnphJ5uqNu6
         8vgHJxEQDWAEk0RBRZw07we09w2wDql8Pnrsl4Ythr2iainnLrbgA4deXJqUcAXAoxpM
         s+B3IzfqB1xK64wzx+l/pFdLVAMFld/sIh1wsReFSlMcxar5KEZenuqL9iTSDoh2lLs5
         M7pUt+uXd/76FKT8oWJ7YS9G46NIjHoypmw7Gd7zP10xu6ukad2asvoDFD1Nx1dYmJkJ
         V6md1zYaPV0CWgHq7GxRgCUCQvNw+R2TnHUjMsX6+KCS5whSE3Ske67lz/ku3J6NYvez
         WEtg==
X-Forwarded-Encrypted: i=1; AL+hErFvgDUUpKAtMWo9qx9L50+eJbxdGEdl6MQaZpvP9RqkoHVuxPxs8aEJaqcxHfWBykPazJ4YsqLdMs8uNw==@vger.kernel.org
X-Gm-Message-State: APuU4Z93ZWGY9fg+S/rXKBR/qeiMokOw76N3P5ShOOGztMfCJTOHophJ
	cKgFyFJ8LaMt5Ob2OOuIqdxqyWXygzLHj8wj6XUPvzZkEPs91F11x3gg
X-Gm-Gg: AZFdTZeY8F6EVX0YoPC8M4qu4bV8/dGP3x7ChhDc9AOX6wswc5leyQBtlcUbh0v1O9G
	DK9u77NFMvHvIPFbbMhstv8k9/XeTydV+llpDhPMXbu+v3wUtZR07eNfcuGTUKIT7R3+fXrrx9p
	WbKPntrl2trlpBpn93EXIN/xNXaFd3h5vDWz/KioqUscwKun/g5eEyJ0gJq9bnZbPLxiljyAJOi
	a9GANMIR9kWPlfsP/WoC5No6wuF2u5VMt8r+G1mTlsFx7tu/ylPX1nRNrw9yRcAKQsZOlADsfDI
	87s9gwurz5HkhNYu1ytAHKf97HhCSfFU07fM2x8w/sotr9uOPhzTt7AnGw1DOhD9lbv8j/Y/QGQ
	i3RioWtfadybc1qAtJIoSVdy8Vj+lr+2gNSmeXS7w/a6yhvrb1gpj1k4kjVztmtvdkx078TxPKv
	gqI9mEjs9By50i7bI8xrzNzCLEp++/MLzIWX49hywa+jpNhyFgpG+1JZBTl0qK5p02lZQ1VBKO9
	miQNnHU4KAm5RNueV4EemQQ0iHUHwloCCZXOZtfC0XTSHnsNg72JcFTyi0/cLAn4ijyplfhf9rF
	gCUzMC/gCv4Ua13JWGrJKyy2Mw8PQq1Vc2S2ObhStZ4WsuwDXR7iRu+M
X-Received: by 2002:a17:907:6d26:b0:c51:50c9:741c with SMTP id a640c23a62f3a-c5150c98208mr692273566b.10.1795436279974;
        Mon, 23 Nov 2026 04:17:59 -0800 (PST)
Received: from localhost ([50.7.123.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513aec5115sm397263266b.51.2026.11.23.04.17.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 04:17:59 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Nov 2026 15:17:55 +0300
Message-Id: <DN2L1II131YK.3M3CEKXTOAUDX@gmail.com>
Cc: "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Matthias
 Brugger" <matthias.bgg@gmail.com>, "AngeloGioacchino Del Regno"
 <angelogioacchino.delregno@collabora.com>, "Sean Wang"
 <sean.wang@mediatek.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Jiri Slaby" <jirislaby@kernel.org>, "Daniel
 Lezcano" <daniel.lezcano@kernel.org>, "Thomas Gleixner" <tglx@kernel.org>,
 "Mattijs Korpershoek" <mkorpershoek@kernel.org>, "Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>, "Kees Cook" <kees@kernel.org>, "Tony Luck"
 <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>, <linux-serial@vger.kernel.org>,
 <linux-input@vger.kernel.org>, <phone-devel@vger.kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>, "Conor Dooley"
 <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 0/7] arm64: mediatek: Add initial MT6895 and Xiaomi
 Poco X4 GT support
From: "Alexander Letuchiy" <asalde.le1@gmail.com>
To: "Roman Vivchar" <rva333@protonmail.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261123-initial-mt6895-v3-0-95c46597e63d@gmail.com>
 <ckJZtdZ4-fPzsa3vkozNyEYYUbG9qd134hYb0hHEuq2nL8WMAR1PS87OpDfXrkU-E-85rsG1I4V99_M41j6-ewkD_41XPguDel3z8z0lmMk=@protonmail.com> <DN2KN6PFHOXG.1EWK1XUHY7IKK@gmail.com> <OZecqgdcxZrbwT7Ps6SDq9u1Q2EeF9jng68KHoWs8vTEetcTU8GAfC5LYcKzDGEZlr5Rlzh4rgzVh36JelFK1zHk3Dgh3TVGqj_a5Y3hv6Y=@protonmail.com>
In-Reply-To: <OZecqgdcxZrbwT7Ps6SDq9u1Q2EeF9jng68KHoWs8vTEetcTU8GAfC5LYcKzDGEZlr5Rlzh4rgzVh36JelFK1zHk3Dgh3TVGqj_a5Y3hv6Y=@protonmail.com>

On Mon Nov 23, 2026 at 3:04 PM MSK, Roman Vivchar wrote:
> On Monday, November 23rd, 2026 at 1:59 PM, Alexander Letuchiy <asalde.le1=
@gmail.com> wrote:
>
>> Hi Roman,
>>=20
>> On Mon Nov 23, 2026 at 2:41 PM MSK, Roman Vivchar wrote:
>> > > Bootloader dependency
>> > > ---------------------
>> > > This was tested with a modified LK bootloader that is not public.
>> >
>> > How are other xaga users supposed to boot the kernel? You might want t=
o
>> > port uniLoader instead, or if you're on an old enough security patch y=
ou
>> > can even replace stock LK with U-Boot. U-Boot chainloading is also
>> > possible.
>>=20
>> Right now I am replacing the stock LK with a modified one that knows
>> how to handle mainline DTs without expecting downstream Android nodes.
>
> LK is known to mess up GPIO and clock state. The earlier you replace LK
> the better.
>
>>=20
>> In an ideal world, I would like to replace LK directly with U-Boot as
>> you suggested, though U-Boot chainloading or uniLoader are also valid
>> options. Luckily, the security patch level isn't really a concern here =
=E2=80=94
>> xaga is already EOL and hasn't received official firmware updates for a
>> while, so LK replacement works across the final stock builds. I
>> definitely plan to look into a proper open bootloader setup for other
>> users in the future.
>
> You can take a look at mt6768. It's not upstream, but we replace U-Boot
> and TF-A with custom forks, as well as provide tooling to prepend
> meditek-specific headers for the latter.
>
> Best regards,
> Roman

Thanks for the pointers and the mt6768 reference, I'll check it out.

Best regards,
Alexander
