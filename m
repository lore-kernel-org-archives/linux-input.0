Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A211645629D;
	Tue, 18 Aug 2026 15:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787066076; cv=none; b=WWc5r2g12bp1qGDVyEYElsLW5QYg0PIQuroWViF6gWU0ukG6T+75aHU3ZCND5I4F8vSux7Ni9EaT1PRkcbAltqFKRE/IsEOWP9Sl7n9paai19n6Bh1ClRFtS7AAgotbeWKXIG+1GHuTfS+9xBhmKydUABaJJ2yYkRTFpuVU7gfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787066076; c=relaxed/simple;
	bh=k1hoNyVpiMb5nugh3F7JK+Dcf+wldIKzcFr1U6yCpSE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EcQbWW2NHHvssRwXCB8BI9bt6OYOHEj4IYKk0CUW+4oqWavF9MKt63XPPVUbdAqWgbslUe3eErcNwbHB85xiqzNPO8oybLwAq6BX+CqqAktgsAO7KO4fAlSoWZcjY7PmAcnuBtQHOoSzDxYkisthH3gjDKu/jQvlX3aiumAANHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZmAyJnL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZmAyJnL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31D71F000E9;
	Tue, 18 Aug 2026 15:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787066075;
	bh=k1hoNyVpiMb5nugh3F7JK+Dcf+wldIKzcFr1U6yCpSE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=RZmAyJnLcQnrOU2OT1Hz/+rAxWPbPSFLOiSO18BLUkuygzH8B/+BtEcv+khkrQGuP
	 sxGvicShJsy58LXKTzkGzvPx3//QcKKGQyZccR+3XreCOBSKdu/IFgOAIgej3c9r6t
	 eea35mjhd0N17sJCAEpXycAIoJkxo+vC1W8yFj2CRYs1PpnMudqNCRPBZDZS8vrCDW
	 ROdXOVxFp92kQMQMXhdP9UWTQV8aukdOICCrMTP1M6lnmwzVEHF1q8RuysjUyxi+HO
	 JMthndg3u3GOhiCZoEh72D8ZRne9dTfVQZqZKRq8EBNHkCdOAbMHjec7sp3RM7zjoA
	 3xoY25bu/356w==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Roman Vivchar <rva333@protonmail.com>
Subject: Re: [PATCH] dt-bindings: input: mediatek,mt6779-keypad: add mt6572
In-Reply-To: <20260814-6572-dt-keypad-v1-1-2ceff2373211@protonmail.com>
References: <20260814-6572-dt-keypad-v1-1-2ceff2373211@protonmail.com>
Date: Tue, 18 Aug 2026 17:14:32 +0200
Message-ID: <87zeyjh353.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Roman,

Thank you for the patch.

On Fri, Aug 14, 2026 at 16:13, Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org> wrote:

> From: Roman Vivchar <rva333@protonmail.com>
>
> Add a compatible string for the mt6572 keypad, that is compatible with
> mt6779.
>
> Signed-off-by: Roman Vivchar <rva333@protonmail.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

