Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EFE18DF80;
	Fri,  6 Mar 2026 00:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772756972; cv=none; b=jcwdK7hpmtSdWIwj9gZ781a/9SSh16dbHKuc+5Z3G5w3gCOLNq53Fku/ECM8qmDnXxEzgAq8hluzHd5t3aj1BnTNP427qnzQg8+4GI7IvcqHHyJS8Qqrij5bcPocWZo0hK1PmrX9nj+pfuCZs8OHegdJTNJlgP74GOA5BIcf8GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772756972; c=relaxed/simple;
	bh=H/ApE2Ifn1Gwf6HdI5rD2qg2A1C36R8oMsoc12fiRtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6coe2u1Ol3DVp5lLDdAco73wxfese0/OHiPgFJgNGiHZ2u0FhD7yTU9MuumXfQfjTDnO9PYsD56fH0t2+0iFtcyi8hgiLNzh08B3aYaVJ1H9Zeru7hD0tUw6lopTuJqPuSW3QbN+/EXuMJ61QFD5VL1gHPh/s0lBEkzoyLo9oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhRsuBQa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhRsuBQa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC8D2C116C6;
	Fri,  6 Mar 2026 00:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772756971;
	bh=H/ApE2Ifn1Gwf6HdI5rD2qg2A1C36R8oMsoc12fiRtE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LhRsuBQa2HW1msxsnJ1GDnVDwGgwkTtwysMZq4+woC0ocQdwWhGlzNU+N0+B5vfTl
	 ovmzsoIiOGaNz3xniEY6aKgIntgyaCPQAnRlGd1Jfh2DEGL4/1++9E0+4dSVYt4nSy
	 quDtjQhfegKASaFRSUXp1XBF3qyGZ0WNSgbN+AlRsRK3xefJMGMdowu1DmMrAJ/lh0
	 Eg53SZTvSty8k2hpkMkJqdG65oP2uTAM+bUx3h72S6PKHjKd4UrlvpJqTa1wuQ+4vD
	 RCohdrq5kYeD/Om8A01/jFs3Y5uitjN69tr4n4Wpoa3gAzvL84BNwm5xXNi3Jy0zrX
	 C1sz/TvvAvvqA==
Date: Thu, 5 Mar 2026 18:29:31 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-input@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Sen Chu <sen.chu@mediatek.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Julien Massot <julien.massot@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	Eddie Huang <eddie.huang@mediatek.com>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Gary Bisson <bisson.gary@gmail.com>, Lee Jones <lee@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Fabien Parent <parent.f@gmail.com>, Val Packett <val@packett.cool>,
	Macpaul Lin <macpaul.lin@mediatek.com>, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-mediatek@lists.infradead.org, Mark Brown <broonie@kernel.org>,
	linux-pm@vger.kernel.org, Chen Zhong <chen.zhong@mediatek.com>
Subject: Re: [PATCH 3/9] dt-bindings: input: mtk-pmic-keys: add MT6392
 binding definition
Message-ID: <177275697060.854738.6493014317679593134.robh@kernel.org>
References: <cover.1771865014.git.l.scorcia@gmail.com>
 <056cbc09fcbb4a2845cece69209a2a564d993ac5.1771865015.git.l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <056cbc09fcbb4a2845cece69209a2a564d993ac5.1771865015.git.l.scorcia@gmail.com>


On Mon, 23 Feb 2026 17:12:42 +0000, Luca Leonardo Scorcia wrote:
> From: Fabien Parent <parent.f@gmail.com>
> 
> Add the binding documentation of the mtk-pmic-keys for the MT6392 PMICs.
> 
> Signed-off-by: Fabien Parent <parent.f@gmail.com>
> Signed-off-by: Val Packett <val@packett.cool>
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
> ---
>  Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

