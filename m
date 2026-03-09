Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5463B3C278C;
	Mon,  9 Mar 2026 18:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773082268; cv=none; b=ONJYvrr0jGCxIcAWPAaTvX6YpWHB0n9FJEb3skwaRdq47v3wQbQEJbNHBH74LapAh85WUrPvlysqu8xkJ0cBqFATy4lVkWMaeo9q4z0EmvnJmewaVf32uWHNeutj4c5PRWSPrSDuKVHZbDchTm0I0AuAHAZW/ka6g6RJaPDFVCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773082268; c=relaxed/simple;
	bh=nqYfApOVSSCsS4d7PjZzx+J2r990nk5D5zRmQq7jl0o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hf5xxcozgzQ1XnB2L7voIBpK9gXrv/D3AxJrFxg7BGnuSfii5g6dEkSw0d5OcAQAzqH3VTp6aSQd7/i1XCM07sSqlGVAzVtsw4zlwYo7/zB/EAQXEl2cpvC9gttsO0VUC1YKr7F7oUfqBRLvsnwwMCBUiBuedhtS+Z6mdmv3d0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yt6cP81s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yt6cP81s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2249BC2BC9E;
	Mon,  9 Mar 2026 18:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773082268;
	bh=nqYfApOVSSCsS4d7PjZzx+J2r990nk5D5zRmQq7jl0o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Yt6cP81swpC/co1+qqWoCwlgcaif6JxszzVAaSdXZtwNTR2DNPSCteFVlWYP7aJrs
	 KY4NgwPQ6AmXs6y1RwIJOZNLplhGDvUqfWIf4rdGXziI2qjfypQUDrK/yJoJNaSipu
	 ToXsMcwwOAOXZD4gu/K2MWu+ZedGNu030OEGezLjrZ/Ct2Kd+Do9cA/BjoTA5ZRIi8
	 kRL3Bbqr1uidDIXTvWHLdB9//4y2kU4vThDuM6mjvMIP4kzu88RHMjAtA1G0Au61RP
	 KBqSu5QgDG1vmlRtOS9hFbHejMLzsMr0deWUKGeIE1cL82wlx8RGZ/m7PsgdzzwONB
	 JWyo9JfREJOAA==
From: Lee Jones <lee@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Lee Jones <lee@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260211-yaml_mfd-v1-2-05cb48bc6f09@nxp.com>
References: <20260211-yaml_mfd-v1-2-05cb48bc6f09@nxp.com>
Subject: Re: (subset) [PATCH 2/3] dt-bindings: mfd: convert
 fsl-imx25-tsadc.txt to yaml format
Message-Id: <177308226486.1639852.9421685432338403845.b4-ty@kernel.org>
Date: Mon, 09 Mar 2026 18:51:04 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-52d38

On Wed, 11 Feb 2026 16:41:05 -0500, Frank Li wrote:
> Convert fsl-imx25-tsadc.txt to yaml format.
> 
> Addtional changes:
> - Add ranges.
> 
> 

Applied, thanks!

[2/3] dt-bindings: mfd: convert fsl-imx25-tsadc.txt to yaml format
      commit: 61b80ec6685a08addd76ea6622636d709e7d989d

--
Lee Jones [李琼斯]

