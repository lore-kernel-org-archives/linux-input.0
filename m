Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794127374;
	b=JA7ZXOew0eDK4zdTx11TYshtrWNwqd0HTGblHYfNcnvrn1N2xoZt7VcVMnpQtKhype17
	 JuAQ41auOglnHkBeV1BxIGMyr68KPNjUU7b9mPeCYC9pIsYufmRnaE2J9zQ4FciCisUR/
	 mwAHAh8GdXNg8d8TNZO0TiWbymib7PvYRadzUC3MFg8pZJC9RDuegQGtCDgv6C6LiqbtA
	 z/HQoeCiQe3Drc+iM9gGvRNdJ0Ui5LxZh2ZBzW9TcgZ63SlmpoKVmqIr1Yb71kEiy0jCI
	 ZU2AKtCJUhrzViDDJkfLeqgtCJfzViogWOE4iDZsOuTYI3eu/Ii7MZ6rk66hbfpnKdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794127374;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YAO6+6Mae3ehm36oisKgJJdRjVFNwYD63LsMg3fVU4A=;
	b=4frklm8QyoR3NwyguDClwoLn/hIQRWsX6B1H3U5miUOut02t97tgv4TryI/70c3Xktz2
	 5Or8utEdCmMgXZ05/lAI7uBAgB0l7INN2gP5tVfK9lgvtyEkqWL7Su9hMwuOKp6ousclU
	 cQ8Em1oL2qcf9a0WyoetKBYFK1L+P6LnOboji+j/Ph3iwCUpEHYRMESSfE2HIUwI16u0A
	 /NdAJZzgPOvcvxxKmhlCstwlonvILojXlCkvvxxTZAU5hhiOugm0n/aTzZTAIOx7lT6u1
	 2DuGZ9d8pRrGd43KBNswJlXiRfa8tMhirCUIWDPeqcBluSFFjaYhfEZPhmKBWPCiHcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="jehD8wB/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3B7606A31C;
	Sun,  8 Nov 2026 08:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jehD8wB/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643B61F0089F;
	Sun,  8 Nov 2026 08:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794127373;
	bh=YAO6+6Mae3ehm36oisKgJJdRjVFNwYD63LsMg3fVU4A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jehD8wB/9WWQPaMtiIUYmQpoxolGvwLF2gB4k1dB4fglqrj58nd+EE7oQUEWhT7hb
	 JTcoFdANWlYRo93eRMGbqvVsIflr8isS0U2TiysphDMlQfkSreaQXtTrv7CB0Ws6Cy
	 sOL4JE6rOHjTJGMDswhzbJZHyqD/vnsn62lSAmDBlUepUehQRUD5q92TaAiBnErydH
	 aLzqV6Sz3lSyVkD6hBjreAAHMeP3XHJN82BJgqVchxraZdrgXrFEe1QzVlrblYknU6
	 2v1cjpv+gF1JwXjxJROMMmSEQl/cj8/1uEdy5CZoAQcBkhCYV4+zgJwtxCPI1hZCOl
	 FSLNpXX24Bbjg==
Message-ID: <sashiko-outbox-203652@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] Input: s6sy761 - move chip differences into
 per-chip data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nizat Mikayilli" <nacht@dxdmail.cc>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261108-b4-s6sy761-fts1ba90a-v1-4-999b3cfaf82d@dxdmail.cc>
References: <20261108-b4-s6sy761-fts1ba90a-v1-0-999b3cfaf82d@dxdmail.cc>
 <20261108-b4-s6sy761-fts1ba90a-v1-4-999b3cfaf82d@dxdmail.cc>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 08:42:52 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] Input: s6sy761 - interrupt storm on I2C error in
  s6sy761_irq_handler() [1]
--

commit a2e70885f2393c600cd0947a2d064a0c055020a7
Author: Nizat Mikayilli <nacht@dxdmail.cc>

Input: s6sy761 - move chip differences into per-chip data

This commit moves controller-specific parameters and callbacks into a
per-chip data structure to prepare for adding support for the ST FTS1BA90A
controller.

> diff --git a/drivers/input/touchscreen/s6sy761.c b/drivers/input/touchscr=
een/s6sy761.c
> index 59166865d397c..f000ed0d7a9a4 100644
> --- a/drivers/input/touchscreen/s6sy761.c
> +++ b/drivers/input/touchscreen/s6sy761.c

> @@ -229,7 +244,7 @@ static irqreturn_t s6sy761_irq_handler(int irq, void =
*dev)
> =20
>  	ret =3D i2c_smbus_read_i2c_block_data(sdata->client,
>  					    S6SY761_READ_ONE_EVENT,
> -					    S6SY761_EVENT_SIZE,
> +					    sdata->chip->event_size,
>  					    sdata->data);
>  	if (ret < 0) {
>  		dev_err(&sdata->client->dev, "failed to read events\n");

[Severity: High]
This problem wasn't introduced by this patch, but can returning IRQ_HANDLED
when i2c_smbus_read_i2c_block_data() or s6sy761_read_events() fails cause
an interrupt storm [1]?

The IRQ is registered with IRQF_TRIGGER_LOW.  When an I2C read fails, the
pending event is not drained from the controller, so the level-triggered
interrupt line stays asserted and immediately re-fires once unmasked, while
returning IRQ_HANDLED instead of IRQ_NONE prevents the spurious interrupt
detector from disabling the IRQ.

[1] https://sashiko.dev/#/bug/linux-d31827dd-6777-4c33-8908-c3b4fbd062c3

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-b4-s6sy761=
-fts1ba90a-v1-0-999b3cfaf82d@dxdmail.cc?part=3D4
