Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788C5477E57;
	Wed,  6 May 2026 15:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778081559; cv=none; b=MVN0mHXnvShtxus2vkRdoCpx3g9znNGkurpxc/+LKDw46wtN1GHyF/Fdc/J8Osxk8w3LVO298BRapxIOkDXzxOgX7RixjT5VylgRexOvgn3+vAcaKl0xTlk++jTKVg0v/f4D0rRPNz9iL6IkPiwzpkw+nA5K+bF5/sPdbwHx/BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778081559; c=relaxed/simple;
	bh=TAQ7q6fZ2Es2F6QydtbDwjXgS9QvCyHO2HaBQ4U9zyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pr3F+rW/Ip4VZkBRTpCe1sBdEj2bCacNlra39glwHwyw4f9y0GbgF74YYgKzcNesmXORQGzpvRN1HcuXTjtKQXiAAJdmmhAhPDEQoXhhBH9vnT5i2zSVFTVC2OSMX+EycAINryJVkbrx+x92lOEjIJxNBD6imRxait4yCu9k328=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVdMbrBy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVdMbrBy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF62C2BCB0;
	Wed,  6 May 2026 15:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778081558;
	bh=TAQ7q6fZ2Es2F6QydtbDwjXgS9QvCyHO2HaBQ4U9zyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DVdMbrByrFoyEMQvoFfKztaQT74EbmaRe2J48gWWbWGy4yzlVQ+T9tqZu0LwOoQVr
	 Q2gZKN32j1DGz5qnhdwwEhtbh+WNAepP15TAq9IfY5Lz2K3leO3dh0i4fVdDyOfcSf
	 7pOd+6ATTY7vN6EI3XDkmoOqBONRBKPYRs9/SPa/dC8It1LcnTeWiEOiBdUhzvr1ZN
	 Sgc6zhN6SxLTIhDf4CfrJVhLYSfxSLjgLa1PIBk0qVT1pcbY1Qe5iQSI2TSjgXkbTV
	 UeC9ft2X12eYFjYi1s4+SDZXeD9rs6iiYd5OWQpynEoz4oB7E6ou2WOGMUJpmiEoOm
	 xd8y44OSB9ECg==
Date: Wed, 6 May 2026 10:32:36 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: linux-iio@vger.kernel.org, Macpaul Lin <macpaul.lin@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Jonathan Cameron <jic23@kernel.org>, kernel@collabora.com,
	Lee Jones <lee@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pm@vger.kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	Sen Chu <sen.chu@mediatek.com>, linux-mediatek@lists.infradead.org,
	Andy Shevchenko <andy@kernel.org>,
	Chen Zhong <chen.zhong@mediatek.com>
Subject: Re: [PATCH 3/9] dt-bindings: input: mediatek,pmic-keys: Add MT6365
 support
Message-ID: <177808155624.2165765.133568600366378462.robh@kernel.org>
References: <20260429-mediatek-genio-mt6365-cleanup-v1-0-6f43838be92f@collabora.com>
 <20260429-mediatek-genio-mt6365-cleanup-v1-3-6f43838be92f@collabora.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429-mediatek-genio-mt6365-cleanup-v1-3-6f43838be92f@collabora.com>


On Wed, 29 Apr 2026 11:44:16 +0200, Louis-Alexis Eyraud wrote:
> Add compatible string for the pmic keys block found on the MT6365 PMIC,
> that is compatible with the one found in MT6359.
> 
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
> ---
>  .../bindings/input/mediatek,pmic-keys.yaml          | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

