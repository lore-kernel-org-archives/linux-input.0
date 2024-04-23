Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5644019470;
	Tue, 23 Apr 2024 14:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713882759; cv=none; b=tyFEtBM5my99/mi5SOxAW4dNVnj9tEel4lDonmJm+GZJDU2J+wPc6fHqksIdIZko0jw3pGxQI6wT7JJlmHxu/xUqCVg7Px2133pqZtvdGCrJ3Fws9MlUY925PBTLtvWFeb7dJv3MCqdip55v5XNbA5oW/HsLhNNHqOaVh/JnRkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713882759; c=relaxed/simple;
	bh=UG4Ckj0nMbH7B0JHsiJXAgvQNIVvA99ebpslMDJkG+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXdGINRcu31sAFpYXQGyBABkJgnkyAIcHsjxUPR4t91BFzunnliv4JA3BTeME7QOKZFPjat+8131baFv9GIvLg6S0kFEOdN/Uh1SdJ4/wcxki49nKyRbaAgV0qekFw+/M0by3G/dm8jB0VeshjTxEsAiIUYMIxlnPdEwybuE3Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OiPqcHjD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OiPqcHjD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1F4C2BD11;
	Tue, 23 Apr 2024 14:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713882758;
	bh=UG4Ckj0nMbH7B0JHsiJXAgvQNIVvA99ebpslMDJkG+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OiPqcHjD5e4XHAkIvbr126NMpBXMcCjkBkTevTi7oTzIKohSkRGzfpAcW0VD+0Hnx
	 WNIZcm45p8O5X+aX/Ir5QFFC6DVG2PCedaiOSLqXS8wzmMHX5lGtPbhhLsPaQf9eY6
	 Vb/t8/i+KvhQiLNp1K+4DzYRMyUHrZfEZLw87+9oO0ths2/Yehk07HxaryZN16ktqt
	 Jlo7P+y27aUzjKzX6+fPU310ZMVuybtQHRiYahbqnUpJCKgwEf4U8HCdFUUkBXHJaH
	 kRg/2ifj3orAnEIDt70a+ZlSlJdFebXQ4RnI7g2cum1cjn47YJv7w7GJbgsZuxjnMp
	 vj8psl1kLqvVw==
Date: Tue, 23 Apr 2024 09:32:36 -0500
From: Rob Herring <robh@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: devicetree@vger.kernel.org, James McGregor <jamcgregor@protonmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 1/2] dt-bindings: input: sun4i-lradc-keys: Add H616
 compatible
Message-ID: <171388262405.158384.14488465462806439930.robh@kernel.org>
References: <20240422164511.2488261-1-andre.przywara@arm.com>
 <20240422164511.2488261-2-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422164511.2488261-2-andre.przywara@arm.com>


On Mon, 22 Apr 2024 17:45:10 +0100, Andre Przywara wrote:
> From: James McGregor <jamcgregor@protonmail.com>
> 
> The Allwinner H616 SoC has an LRADC which is compatible with the
> versions in existing SoCs.
> Add a compatible string for H616, with the R329 fallback. This is the
> same as the D1, so put them into an enum.
> 
> Signed-off-by: James McGregor <jamcgregor@protonmail.com>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../bindings/input/allwinner,sun4i-a10-lradc-keys.yaml        | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

While the Reviewed-by from Andre was a bit unusual, the explanation 
makes sense.

Also note that b4 can proxy send patches for people with broken (or 
non-existent) SMTP servers.

Rob
