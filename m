Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3F734D4D6;
	Thu,  5 Mar 2026 23:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772754227; cv=none; b=kycpgkMG+WnhuTHOIMSyMcOOTAqjjMorGwe2yGAeFsqlNkiXTBBxpQ91fz/DkLEH1SDRgBcW6glwl/hsYgEdin8kq59l0Q2f4ANggZvC6yXOLuCnuRDDJ+S8NxJUOJ8y+cg8DsX2ZbMgSxPPx93apTd2U7b4s4elTLoUSnChrAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772754227; c=relaxed/simple;
	bh=Cu+HuH+jRAq+lh68BIf/MeztQSSaSBd0C4RyJDRVkjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8ISMmo3kVBjybf7ytq0/szHKdoVbrT5QWVaA/SpGDe5F5Bxkhwak09pz9Fcbj8apyfyRp4Mbs9JmTyAUq7H7wCMILFCPhq25Yf7dtnvJEa5EPIK2g8qW+LbhayFZdKOQHOxgbuo1RrHUE8fXnfJmrio9fl5ahHZJFpgbfv/SEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8MoaVYO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8MoaVYO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9D5C116C6;
	Thu,  5 Mar 2026 23:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772754226;
	bh=Cu+HuH+jRAq+lh68BIf/MeztQSSaSBd0C4RyJDRVkjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d8MoaVYOrMPwLgvj0sqQIxxRwuksobMdykzX3xUuSPSgrTO7ZoD1AvQdNLN3+GZwv
	 6wsGVNXkav+jCThl5KXo3tW6/PvqWzxSaC1+2o+YQEt1Te35pl4OKO8lLmR4difH/f
	 2KwzAEu+EELPL2G2SUW1d7XyYUQVs39y7MCcq3p150NCq7aqO+BPIngmpj0iybTUly
	 C2DTwRv6bZw8BAmHWOIlrVs0EKQKiJIVcn48/10TvNGbUKuEyIlNfP58NrhFkzQ+qi
	 EXW00xrEvzZ5NAVpJSU+dfb7xt0IB39jQrBnRBkLLDqYS96rfin13CyV9gfhH1coRs
	 p9N46JTJ4PQJA==
Date: Thu, 5 Mar 2026 17:43:45 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Fabio Estevam <festevam@gmail.com>, Lee Jones <lee@kernel.org>,
	linux-input@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: input: touchscreen: convert
 fsl-mx25-tcq.txt to yaml
Message-ID: <177275422508.795241.1267020381842485721.robh@kernel.org>
References: <20260211-yaml_mfd-v1-0-05cb48bc6f09@nxp.com>
 <20260211-yaml_mfd-v1-1-05cb48bc6f09@nxp.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211-yaml_mfd-v1-1-05cb48bc6f09@nxp.com>


On Wed, 11 Feb 2026 16:41:04 -0500, Frank Li wrote:
> Convert fsl-mx25-tcq.txt to yaml.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../bindings/input/touchscreen/fsl,imx25-tcq.yaml  | 69 ++++++++++++++++++++++
>  .../bindings/input/touchscreen/fsl-mx25-tcq.txt    | 34 -----------
>  2 files changed, 69 insertions(+), 34 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

