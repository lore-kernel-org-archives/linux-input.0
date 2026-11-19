Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795121034;
	b=Osnei4bWjFLcfsf7XDxCf+AkROA+NC2o5bUiMs0ktMIuQrlk4Kpk9pV5XI91wuso+uVi
	 rpU7BV0M/frc09opo0wFC+Va5ybKngZR2t9j+7jqkXFRpgOuz0g44moGm0A10v3orkFK8
	 Tvjp2dTk4X5ObghtcpML3/d/e7yhxfBv9Lub/lVKQ2XO2JshLFXfpPQWGqaTbpDEVx6IN
	 lkL+VhdTQjKqyBULCuOrmeSPuXg8gAgr5Y+54KDQpAp/b+2JzQzCSXKJyXtEbh/5/5BaZ
	 YJ9Ee/5kKd7KPnuegU0KDro55YJcnlr1eyT7H1SPtBia4gypC5sCLm4RGyxywLM1EtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795121034;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=5FuGWnpoRnGfJUPP95+vbL5XVs0jYD6RpmDm3Ay3n3I=;
	b=NrrlyCU1aYGKnSo7oHtaj6yUHHkSezoVZ/ZAeUPK0ZRFrqo7u2LkdLNgBce6v56I1qpm
	 TudA1f6QU68q4pOu1goBb3cDUyzxm5rt+To+L4K4D+GH5XotA391scZHBx3VaJsLEjwsp
	 pr/Kloco/kua1az/QdmVxvZzvV2ZwEXJrK4Sp12+d03cSiRVg+nzrRFkB/dEGPg0W2DNn
	 4toCh11uTeNu1gMawcWEA65cNJZ9XObE0ZO2Xn0n+27eD4y0DxbjVYmHS/PUDXHytid/W
	 qtAjUM36GVfR45tABcujeUivx2YxhR0ywhet8x1xE4FQxtW1gCxq0NKKngxQSi1L4PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jFBRAhnY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6BE606BB80;
	Thu, 19 Nov 2026 20:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jFBRAhnY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9AF71F000C0;
	Thu, 19 Nov 2026 20:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795121034;
	bh=5FuGWnpoRnGfJUPP95+vbL5XVs0jYD6RpmDm3Ay3n3I=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=jFBRAhnYENrURvD8F7EwBKzD5YEBanB30Si908P1ro7xGIL7NvfGXP7lkwgaJtry5
	 gfAkClH/QQ/ID5F9oBvYRpnzEzkeq7iZqdm8MAAbA9NOjkIIbwjK6/j2UbnEHok4CY
	 i4OrGED4Yz7K3Io6bx9rmu1Carz53pIeqdRvbI+WkGGjEuGFYg/Jh7Xzs7EfzDEZbO
	 nvzhDuufOQQLvPX4q+0/gGaHXcz+ggIxDnreo1IfSprP3Aen0DSEMiYuN7EHkjoog8
	 N0glqOkvhUZQp+AKyd3NdxVE0iRtsxQT0Su8HiAoz5kIPyfKpJa2GnFFtstu2jOIvD
	 mes136M1B7TKg==
Date: Thu, 19 Nov 2026 21:43:51 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Helge Deller <deller@gmx.de>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    Aveline Noir <jm5905938@gmail.com>, linux-input@vger.kernel.org, 
    linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 2/2] HID: picolcd: Avoid framebuffer last-close
 deadlock
In-Reply-To: <f52cd9ed-4e23-4160-b305-650d853bc18b@gmx.de>
Message-ID: <5pr05248-751q-224s-2876-pp5599q5o985@xreary.bet>
References: <CANOyQmGfmBdTRaEamVdGuMBToVLeXGi6qLrnX=xkA9acsL9TSQ@mail.gmail.com> <CANOyQmHF-gjvnLqTGEVBcU6+AWj5ha+7tJhE2E_Cv9aj-gRXdA@mail.gmail.com> <76cddcc5-2cf8-40da-9139-e78353975e41@gmx.de> <179308935900.645289.17780178981863221787@gmail.com>
 <f52cd9ed-4e23-4160-b305-650d853bc18b@gmx.de>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 18 Nov 2026, Helge Deller wrote:

> Jiri & Benjamin, can you check and decide on patch #1 of this series ?

The patch is line-wrapped / whitespace damaged and can't be applied.

Aveline, could you please fix that on your side and resend?

Thanks,

-- 
Jiri Kosina
SUSE Labs

