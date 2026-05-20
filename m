Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4841F4634;
	Wed, 20 May 2026 14:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779288057; cv=none; b=c91FeMHViFIsY7DxXagTUVWLP9NuNDshPl9z1O9U8Mdux+Xgu7QWt8sf/gJI/5rXp/hY/5uBfteliK74IavX3eDIByi7+4mgU8pM+fFsdes6oSTGF/C3mF+Tr2hH/K5CitRqc10bguNWHU4IE5XQFtkjaN+//Z+0Eb66l+dpJm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779288057; c=relaxed/simple;
	bh=2PkB7amz5xIxKzYNT0yuVu20jPzCD49VJMX4Esiu23g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hkyb7XH8yHZuJbaN/dP2x8GQVKFpIxlKuz7O1BrmFC4WIWBN1L0pBcrdTKjd6gyj4igX2H6MhNjIayjqsOzroar1AfqjvIjJcQCKquo/MmzihYLXwcKhtgdCr5tVg6zH9N1ZqytLSawhxwvz4fnM5EhFlurxxAu/+o/NU5Aqzqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwNTL7Di; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwNTL7Di"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 518441F000E9;
	Wed, 20 May 2026 14:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779288056;
	bh=iBEbE+camjUKBlwCJLf2N5rzNs637OGXYU74gPqV2Gs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=YwNTL7Di1i10LxrXKrgPrBkT/a0mF+W44BHvguh46QEVvWVQhe0w+ull5XI4rpvl2
	 xj7C4ZwWYw2a4mHGNQlMI0kNuXVTLmxMOsFqIFOGImN0/Ky2idXrx4n/KSAHG8YAOC
	 ceNvoEmEppM7aJdswGqOMQ7vOMKSJd3hzJ2TaDhZq5/Cvk8QN7w0xGxXtN99ntUlig
	 CQqeKfTybxHPUrK+Q/yxN+uUEJG4xzA1b88pZuFhXOlw9QSPhEiTTd10Fq2uZwRU86
	 eQIowsSmbhCuQ9Wm5pbWGSiknzkmBJ/eA0BljqC0rmAIWxyGmdEIW7NcUJrzXOwDwD
	 J32BMNelRQr9g==
From: Lee Jones <lee@kernel.org>
To: Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Chen Zhong <chen.zhong@mediatek.com>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: kernel@collabora.com, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org
In-Reply-To: <20260429-mediatek-genio-mt6365-cleanup-v1-1-6f43838be92f@collabora.com>
References: <20260429-mediatek-genio-mt6365-cleanup-v1-1-6f43838be92f@collabora.com>
Subject: Re: (subset) [PATCH 1/9] dt-bindings: mfd: mediatek: mt6397: Add
 rtc for MT6359
Message-Id: <177928805103.2819461.14868445480011643756.b4-ty@b4>
Date: Wed, 20 May 2026 15:40:51 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Wed, 29 Apr 2026 11:44:14 +0200, Louis-Alexis Eyraud wrote:
> The rtc block of MT6359 PMIC is compatible with the one found in MT6358
> but this compatibility was never expressed in the dt-bindings, so add
> the missing compatible string for the rtc subnode.

Applied, thanks!

[1/9] dt-bindings: mfd: mediatek: mt6397: Add rtc for MT6359
      commit: 4edf75f835bad0b7e7ac022594b129f9dbf8698c

--
Lee Jones [李琼斯]

