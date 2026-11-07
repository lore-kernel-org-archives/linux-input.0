Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794133550;
	b=Q6q9AAw6GaHSkrsQDRqZd4a5uI2IwXrufuCsG5bDCAkLp1BmBSVsLFApCDAaPGCnfSPn
	 nSUcZQN5eJ34cBqci5bEx6Y6Dlq2/2dbx/MIBFie4c/MHlkWSE5pjecpvQljdXcIC+rPs
	 fH7Psc927O9LNIFaLIYkiKlo+KD2shGae7A/531KDh+PMtsF4jXkpC9qDAxvHmJSgxwyH
	 PoN/oKSNMjLldVdNDOr8G6a9qpOdiyczvuwurha45dusDDGGU56AZrChO/ALDJH+jmQbP
	 xCfEWuOUgEjhFsoy5gc7h022UDE7FXCBUti2Cww5HfNczIFyrS4yaMols8+f5kLLpgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794133550;
	h=Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=v1Af1P1P1zbev8CYQkts6hQ+hHJRvEA7sX0TkjFdZnw=;
	b=QB93FJFObGiWz9VPFNSYb6SOdPmZgicwRHIyaiCLr0CKuzFpm7GFZVXxtGY7JZJImGpW
	 jLKNxl92hqCBkJgoWc3FrURPMy5BRjkxnCI+8LjrtE+8A/qyBf6apkS1FDrOm/EyiqhNH
	 vLpk+TZs2pJW1dc0vdDqFU2ljDUYCiZehOqujQ87RRMWNF1sjPSnm2/8/QycKdhPlerkG
	 hIM3B+m0A80q0u/jBUaIS1KtQuWizQYC3A3dtaH7Hnq1nIImXUnmWUzm9sKskQm2oHKWm
	 d5p4pUurH5LpasYanuibvPfWO6aJnB5KUqD5pEpDM55SaS9qJtuguR+FJBNpjTGIA5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PNpKxx95;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992AA606A31C;
	Sun,  8 Nov 2026 10:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PNpKxx95
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 028201F0089F;
	Sun,  8 Nov 2026 10:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794133550;
	bh=v1Af1P1P1zbev8CYQkts6hQ+hHJRvEA7sX0TkjFdZnw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=PNpKxx95tQplb5JM4+uP1TWChj9AbUwLPfociXRfICTLjmxCZsejaOIwW3ME4ie8R
	 HmFXofTZWu8JpP2MW43DM3+pDXHvi6hiHE17B7I/TUzxhh+fQSFDtDXxMreH/NWSsf
	 8cyq8mBKLjCB7wDMu2KOl38Yo9G8k7b6ZgzLer+FnR/iTPIzqX1Z+Xk2WojQCfGufD
	 OhfJx3Z+C4C0m1RWkFRA6otBVj/6VmSmnoH+K1jsr/xbUyatur17pMbrlWXNnaxLqf
	 kt7iny3qW7m7ps+H9EYZMM7+TR57qqGMlkwl9ookoNI6pROi4I6zbnHf0wMz3GF8FK
	 WyrbCqg68nmEA==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 8509A2BDF03E;
	Sun, 08 Nov 2026 10:25:48 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
 Andi Shyti <andi.shyti@kernel.org>, Chen-Yu Tsai <wenst@chromium.org>
Cc: Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, chrome-platform@lists.linux.dev, 
 linux-input@vger.kernel.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261103043734.2179858-1-wenst@chromium.org>
References: <20261103043734.2179858-1-wenst@chromium.org>
Subject: Re: (subset) [PATCH v7 0/8] arm64: mediatek: Chromebook trackpad
 supply fixes
Message-Id: <179406980914.3424803.6201831446824678583.b4-ty@b4>
Date: Sat, 07 Nov 2026 16:43:29 +0000
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
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1241; i=broonie@kernel.org;
 h=from:subject:message-id; bh=YiAPZOAOOLU5YOLoZTNzrcCrnz944fe3k/TYLXO5sfw=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLI++OmIHPW+E3fsCTvnHlePnZLv27l4DoQUyWulREY6x
 286EMfYUcrCIMbFICumyBKXxf2yvuT1Gr6DC9tg5rAygQxh4OIUgImoXGb4X8KwJZIzezXroi7x
 WYeFpnm4m6/L3b/AvFr18r6k/sLE8wz/M/1VJh02W1fszLh1RtSWKfKXivZ3yAftjY+w65/y++Y
 2ZgA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 03 Nov 2026 12:37:24 +0800, Chen-Yu Tsai wrote:
> arm64: mediatek: Chromebook trackpad supply fixes
> 
> Hi everyone,
> 
> This is v7 of my Chromebook trackpad supply fixes and optimization
> series.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-7.5

Thanks!

[1/8] regulator: core: Add "enable and wait" functions
      https://git.kernel.org/broonie/regulator/c/9f9bcca6adc3

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

