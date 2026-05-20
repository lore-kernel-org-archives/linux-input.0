Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3884F3EDAB7;
	Wed, 20 May 2026 14:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779288096; cv=none; b=F+je2JG1EpfWuQkU0795iQXjTJtYjGgBQjEWSAlJ6/xf/uKx7RnO1hL8IfekZHzbO+0I2i8ebIogFTU9vYdgj+oxcX0z7sJoV6e7oxt/ivoEGjD412xOMJ+tsvUInie3V2kczJ/Vfv0OpydKN0pifDbNm3+gK77BN0/66iLugjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779288096; c=relaxed/simple;
	bh=vePGiqd8QHF0aVt398dNtiZyt5F3YVbVqGzfrTgnudc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dFIm23OnH2aCmMuTvOgxa+uZyL/wVjk6DSEmriq6JvYQwBNqrukOQOiPXEDhVszla0+/j8c9rNd03KIpusBiobbaw3SzFv30AA5PP6qUJHOSa+WYBzHG2hvOM7hOfTqRlWWfKYq3hoMRuWP3nBaYs7nrN4J2SZECZUjx3wvTtOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuERah6+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuERah6+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C88C1F000E9;
	Wed, 20 May 2026 14:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779288094;
	bh=WvcSANqXYxSuWMv70aiwowoFinc31+uKPSBaTXt6+oY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=BuERah6+47YW5iWHKhsEZ0zroxGvV206KQVRRtyhyJ2M/YpxiMGutiYbh5ugB9fwY
	 zCKwU+mGl9fPFVQlk7eXA2D2OmlkQU5VSiU0JBovDYH4rJL55BnH6sh1gNbDHswI+B
	 TPHu0VrR1cRuvoePktMUvVYKgHYBK4QLIrTstkZZP1bMenKulFt4Cs0g3lCF5xelzh
	 QKCXVuqZ2mwSb4Vix2KcGtnYFTDoLY+Owf7rGv/H2UCs/E1lm2eadm4YriBAi+7aiz
	 n7HsyG3uA3SnODbgQVV1n0lT2KCJyZuQftDhxUrNaMv5UBIyD8K4Dh3eb8se/BlTV3
	 Lp1kM/UEe3Lrg==
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
In-Reply-To: <20260429-mediatek-genio-mt6365-cleanup-v1-2-6f43838be92f@collabora.com>
References: <20260429-mediatek-genio-mt6365-cleanup-v1-2-6f43838be92f@collabora.com>
Subject: Re: (subset) [PATCH 2/9] dt-bindings: mfd: mediatek: mt6397: Add
 MT6365 PMIC support
Message-Id: <177928809004.2820600.8127364744264482549.b4-ty@b4>
Date: Wed, 20 May 2026 15:41:30 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Wed, 29 Apr 2026 11:44:15 +0200, Louis-Alexis Eyraud wrote:
> MT6365 PMIC is compatible with MT6359, so add the compatible strings
> for the main and sub devices (regulator, rtc, audio codec).

Applied, thanks!

[2/9] dt-bindings: mfd: mediatek: mt6397: Add MT6365 PMIC support
      commit: 5a7c6466133eee4370995ad5ccf4c377011a381e

--
Lee Jones [李琼斯]

