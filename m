Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F333033CB;
	Mon, 23 Feb 2026 15:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771861851; cv=none; b=MY/1BDbq6+vkt2Gb2WbLW6z1yNhR3ZA1/hgdL553tAVcTzz/oibZ3aXLbdcxAktswHBfJI5PR1uu7pe7JJmU5grVSw8WUSk8mi3cOEbny7LobTC/BKqTvKU6FRYf6fAW0r2objz6kuydjt4AhCwJglr9Zt7tWD2VEJBLmw24dzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771861851; c=relaxed/simple;
	bh=aJ5EyMPZ514vEtlPFGBe+wFHZLdDb9C9CteZzNd2WY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eE8zzFPM1qIX725Bng6FZM+UUHvsWbQ/i5xmWAR2sUCT8kkXqmS2+kqyfGAMow1Vtt7pSaHri/dBU5+Et/w/v7C+NYnKZStZcColGMPS/osYAgDMvWyFhtafBGZxSs83c1SEc8dJEnfD4Ptin+AcOdiqoBjRsbVurfQU4xGnINY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKtVgkJN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKtVgkJN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28E59C116C6;
	Mon, 23 Feb 2026 15:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771861851;
	bh=aJ5EyMPZ514vEtlPFGBe+wFHZLdDb9C9CteZzNd2WY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TKtVgkJNeZfETQcWTS97nYYDsyWka+quQZk+Yoh7QE2e4O7L0jD/5J/L6i9ksj1iG
	 KrWghqBJ7PayeNJpHkZUMJ0qrNWo+MG2c+G/G/AeOylrFkL0YVxAKmQlmT5DmVWBfv
	 XmFiPftbaMoPxQu9nrLVV5fWC3krpSwC2cU6XA/uhF7sud3EBsU8kfozEBIOnRf1Bu
	 uKPtfRK9qizbbyXF8B3ntotV6JfD3BFLeA8vWo/hxPuKd1lr3PvAKyoXDR2BJO78f0
	 aU9u9KgHp1Xjwa54ZPLPeI8WUUhBry2elECp1eVg2ybjDIidbB9b9zN8n1uIYk+h+y
	 9t7KFfNa0hIRQ==
Date: Mon, 23 Feb 2026 09:50:50 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, linux-kernel@vger.kernel.org,
	Pavel Machek <pavel@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Tony Lindgren <tony@atomide.com>, Lee Jones <lee@kernel.org>,
	linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-leds@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v3 1/9] dt-bindings: regulator: cpcap-regulator: convert
 to DT schema
Message-ID: <177186184949.3801292.5943140830566827615.robh@kernel.org>
References: <20260223063858.12208-1-clamor95@gmail.com>
 <20260223063858.12208-2-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223063858.12208-2-clamor95@gmail.com>


On Mon, 23 Feb 2026 08:38:50 +0200, Svyatoslav Ryhel wrote:
> Convert devicetree bindings for the Motorola CPCAP MFD regulator subnode
> from TXT to YAML format. Main functionality preserved.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../bindings/regulator/cpcap-regulator.txt    | 35 --------------
>  .../regulator/motorola,cpcap-regulator.yaml   | 46 +++++++++++++++++++
>  2 files changed, 46 insertions(+), 35 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
>  create mode 100644 Documentation/devicetree/bindings/regulator/motorola,cpcap-regulator.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

