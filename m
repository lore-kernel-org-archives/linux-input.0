Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794589997;
	b=Ka1FMNTYAGfJ3YZFNbhp5RvyLK1p7fY8dXgkFMsZUECxRZclyCJlyMW7Gl2fUbIZ4njM
	 2qDrPuUygOSShFqs6sd4/W1sZGUrUnO6kYww0i2kRi2cdjwjtMFi5T9Ldes9kvVRLbPPG
	 PH+3YOTdn5xBJ+MBcynkM4kKxZSR3AOuZcvgTn/dc0HU8z71XBiFubtUBNWzRLqARwV/G
	 Fps9Eo55UQpNj7rmAW3xuWvYaQEBIfBF9C6gclANuzSv2NEBmStXBx27Jj6u9Bv39+ePL
	 t2JSGyBxdk5SFno/wwLHSEfGo4MhGWT098cN98VXAgE8Sj2EFuosRWQMnVHQ+sr3cpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589997;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=bonakH17m6oL3I6u6f22hNg5N1ig4SK5E1SkaoENsVo=;
	b=1NFabWF3NkNyOzrSquiD1RhJ7B3uajcu1JejhOgBL1hKPL9B4YmjIwAMnM3TlSk8ipWK
	 +bH3Q471ZQoKjy51NXaIRGeXKpDRPHHWHNqIuQefbLgQsK2+6mXVd+mheb8BF4hm4eEtr
	 OYRFvO+IIETUQOe0j5A8Rkjsn7shFKueVouNFlYNgcfpIEZtpQhfla77NjZWojfStHCAe
	 lTqa5J4tTyCNgxAQbfxAne87OhJVaMb5/7Pkgrm3oDeG8vgeulMVeUCG6HkGj6t+5NnM9
	 RQGRkDLIq2uQcJoILkXSS3OCJpRWkKayNoarTbcHYHVaSVCrhvaOe4GEL7ztV7GJgMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DiOGWW5A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD4F606A334;
	Fri, 13 Nov 2026 17:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DiOGWW5A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD94B1F000D0;
	Fri, 13 Nov 2026 17:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794589997;
	bh=bonakH17m6oL3I6u6f22hNg5N1ig4SK5E1SkaoENsVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DiOGWW5AblLFcTIFUrgE/alIXAiZXbzEhZbiIXhFXE8H/zK//AjmvQiVdRU2ZBZgw
	 YuJtKCusYKUus+2whWriFHNVHslI4dDXzhW1FoNrjObxZxHsLlCS8N1f5Urk/+nfts
	 I/1RB4QSNgC15X5zSln0RFNaKLZZPGo61aGvqrJIcDn2grBij96TZGAaEHDDVV5EcL
	 59io1+xQ/4z75IqkElQ5J3bpoB5fdF0/+oKbAZ5ezCRVzInwE5hqaK8IddqaTjdh90
	 3/Mz44iAuaK2JQreGJJI+Z9XcEA1a77Y7iTR+7v2NixTB1vJ/Lo7rt8nM7TeD0hY96
	 Wn0fc2K8hSecA==
From: Sven Peter <sven@kernel.org>
To: Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Michael Reeves <michael.reeves077@gmail.com>
Cc: Sven Peter <sven@kernel.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-input@vger.kernel.org,
	Yureka Lilian <yureka@cyberchaos.dev>,
	Hector Martin <marcan@marcan.st>,
	Sasha Finkelstein <k@chaosmail.tech>
Subject: Re: (subset) [PATCH v5 0/8] Add support for Apple Silicon DockChannel internal keyboards
Date: Fri, 13 Nov 2026 18:13:00 +0100
Message-ID: <179458995719.5774.15567568274381558619.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261108-b4-apple-mtp-keyboard-v5-0-e2c97b82669a@gmail.com>
References: <20261108-b4-apple-mtp-keyboard-v5-0-e2c97b82669a@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 08 Nov 2026 07:25:05 +0000, Michael Reeves wrote:
> This series introduces support for the internal keyboards on Apple
> Silicon M2 and M3 MacBook models.
> 
> On these platforms, built-in input devices are managed by a dedicated
> coprocessor running an RTKit-based operating system. Communication
> between this coprocessor and the main processor is carried out over a
> low-latency hardware byte FIFO interface called DockChannel.
> 
> [...]

Applied to git@github.com:AsahiLinux/linux.git (apple-soc/drivers-7.5), thanks!

[4/8] soc: apple: rtkit: Add tracekit endpoint
      https://github.com/AsahiLinux/linux/commit/6a2cf965b53f

Best regards,
-- 
Sven Peter <sven@kernel.org>

