Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FEF352C4F;
	Mon, 23 Feb 2026 09:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771840462; cv=none; b=NpnxtyeiIbxnnn7x6NltWO6lWNNbQar5hf+ajb11DxRGl11Lg5FyLUHbGGDAnfzPv4BwWvDN8PVHVinRd2BGifCdvaAIoRjN/m5IKZnwq7eZXLST/GATRkYttdB5kDXH38PzmLgeocqPVpS8nL3ViMThnZRIVa60V3mYBqSRxck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771840462; c=relaxed/simple;
	bh=JP1pdb/vVZxj9G4mdDV/0hPp8oNhvMWmT7KFOtEWuh0=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=F3srAiIHJf4JF3h30CO3tKSFYMGm/Ewf3RT8oRmvqwrH5BOVHgAn0P4EPpFBbsnuq89iFHoIhn1H1yE1+zIdiuSWY9oWA/Hrq1o10KFMBb87U9OaubWlsREClLYB1m5CURRSfqNyKRD2f1j0OayelCxneHcg3qsDkk0Sq9dz9/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/n1nh8V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/n1nh8V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F715C19421;
	Mon, 23 Feb 2026 09:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771840462;
	bh=JP1pdb/vVZxj9G4mdDV/0hPp8oNhvMWmT7KFOtEWuh0=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=F/n1nh8VnG4//SRFwLWpwzohmjh24y4UHjRnzOe6iP4gH5XvjSemRPGem9A89E5cz
	 BkuehtAeVh+zrH5i1cGXH98pCr7xWTDu5TWs5vOZGOcNelrPhPC6nmAUOjkMcnGye5
	 KaLQ8yKyt22HhhAu4WhDxELlsD1cyBTRZs+0GOYPzAKBHpD2F5Rka6uNTDWlGFf1EW
	 W3v3vpZRfJ6o+s91QUpyBu+nI6AWrdB7TTvJxSbXkzC2KiMOuhfmtevBkS+N9if/5l
	 NDgXLRbCAjYwUiyqGVheccSUrG3wU4ArvpeofPfo+eeFiD+D1vCz6uojfbn3tt/rLK
	 nRGRWbml5pN4Q==
Date: Mon, 23 Feb 2026 03:54:21 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
 Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, 
 Pavel Machek <pavel@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 linux-leds@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Lee Jones <lee@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
In-Reply-To: <20260223063858.12208-5-clamor95@gmail.com>
References: <20260223063858.12208-1-clamor95@gmail.com>
 <20260223063858.12208-5-clamor95@gmail.com>
Message-Id: <177184045967.2675277.12852967210350446807.robh@kernel.org>
Subject: Re: [PATCH v3 4/9] dt-bindings: leds: leds-cpcap: convert to DT
 schema


On Mon, 23 Feb 2026 08:38:53 +0200, Svyatoslav Ryhel wrote:
> Convert LEDs devicetree bindings for the Motorola CPCAP MFD from TXT to
> YAML format. This patch does not change any functionality; the bindings
> remain the same.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../devicetree/bindings/leds/leds-cpcap.txt   | 29 -------------
>  .../bindings/leds/motorola,cpcap-leds.yaml    | 42 +++++++++++++++++++
>  2 files changed, 42 insertions(+), 29 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/leds/leds-cpcap.txt
>  create mode 100644 Documentation/devicetree/bindings/leds/motorola,cpcap-leds.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):
Warning: Documentation/devicetree/bindings/leds/motorola,cpcap-leds.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
Warning: Documentation/devicetree/bindings/mfd/motorola-cpcap.txt references a file that doesn't exist: Documentation/devicetree/bindings/leds/leds-cpcap.txt
Documentation/devicetree/bindings/leds/motorola,cpcap-leds.yaml: Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
Documentation/devicetree/bindings/mfd/motorola-cpcap.txt: Documentation/devicetree/bindings/leds/leds-cpcap.txt

See https://patchwork.kernel.org/project/devicetree/patch/20260223063858.12208-5-clamor95@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

