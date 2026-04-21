Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3C5366061;
	Tue, 21 Apr 2026 07:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776755692; cv=none; b=dkS8tMe2/VEArf8421HboxoSgVuFc7HDGNUExKx7bFSzZLf3/1x5ouCL2E0r2yM43sGVYWe3Orw5EfupQTylRsVeMXfHNZzOkQUugyzWiZ9esX5MXcWLn31bVVWeeFnoqmdNgFpX34AeZrgzN16oD78qzWwK8sDjnepOAbCDk3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776755692; c=relaxed/simple;
	bh=NUanx7qGcEqtnsDYPbtKV03ieoaKJQQYKCPCmeuCV9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5T1z43EAOd79hZ1IkrbbVBSG8rcNgSgvMZLHPpZwtshrEfAt7hcFwjvYR8VNcscimX687eP2m0cz8HzlTGoRcVzbbXUiDNhO1B58WrGgeH9w+fPBrF8DTLPcOVPcOb++26FrMhcTTlYiMgkjmnt/T3RVG03nGrwBzoSAxJC/HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJlNhX+g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJlNhX+g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA60BC2BCB0;
	Tue, 21 Apr 2026 07:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776755692;
	bh=NUanx7qGcEqtnsDYPbtKV03ieoaKJQQYKCPCmeuCV9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qJlNhX+gnKiGA56fWSwRjmzRlwB+m7T7RbDPJ3dBRfsI//7LAcU3XkZ5QNuyoLYxt
	 MVqdegtTgxId+uM6/G5T3K6i0qPqWW/5hRzGDMgakTCTQMai2a0IPaEdD2phm+vPNF
	 SI4Bhk4OsVisYTwpKWJ6QrJlcOKvJ/YvBb3DDYYNc0ICW936YxN2OuD1X1PUuEZHLE
	 fxM2m4h8C1Jd7fA5GEVIOyNQ9s7krKXEkwlE2GFwE1VVyxMIW2P9rmdAV/AaeXlLvi
	 FjNKkFtUiGrfnvbtdYaIaX/AEnt4t1eqzPTu9/gr608uMdGsyoWFGQEmDVlJdd4cih
	 QzKGs50zUU5tw==
Date: Tue, 21 Apr 2026 09:14:49 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Linus Walleij <linusw@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, Val Packett <val@packett.cool>, 
	Julien Massot <julien.massot@collabora.com>, Gary Bisson <bisson.gary@gmail.com>, 
	Fabien Parent <parent.f@gmail.com>, Akari Tsuyukusa <akkun11.open@gmail.com>, 
	Chen Zhong <chen.zhong@mediatek.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v5 3/9] regulator: dt-bindings: Add MediaTek MT6392 PMIC
Message-ID: <20260421-elastic-just-barracuda-45d0da@quoll>
References: <20260420213529.1645560-1-l.scorcia@gmail.com>
 <20260420213529.1645560-4-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260420213529.1645560-4-l.scorcia@gmail.com>

On Mon, Apr 20, 2026 at 10:30:02PM +0100, Luca Leonardo Scorcia wrote:
> Add bindings for the regulators found in the MediaTek MT6392 PMIC,
> usually found in board designs using the MediaTek MT8516/MT8167 SoCs.
> 
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
> ---
>  .../regulator/mediatek,mt6392-regulator.yaml  | 76 +++++++++++++++++++
>  .../regulator/mediatek,mt6392-regulator.h     | 24 ++++++
>  2 files changed, 100 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6392-regulator.yaml
>  create mode 100644 include/dt-bindings/regulator/mediatek,mt6392-regulator.h
> 

Your patchset is obviously non-bisectable. This must be squashed.
Test/check individual patches please.

Best regards,
Krzysztof

