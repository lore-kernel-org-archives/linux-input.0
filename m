Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF833E8660;
	Tue, 29 Sep 2026 08:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790670540; cv=none; b=A20xRIVJCTEHEqWKFtHq4Wv5tGrV8N5mRgdy+5+5kBkmwVjIWK93KLoVn2D68w3ktz78oTnXafBNc2knN9Tw4ZtpKgWEbnQdvCgdwvpzOs9//bEjSkVuAdfjO9ecaJuu1ObAscnXGL8rkaOxjglqk4sYgo+YTQerE7X9RXuKSCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790670540; c=relaxed/simple;
	bh=mABRqTBqPueqtJGb7KsMKUob1wDgoqJsYHR/i9IbX/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=du5PIUfvW7NmJKMfumbT/y6Z+wKkvq1YLDjMYFYDFgHpZdX6rUwa7HwSZsuBaVdJ7mwvsRULFU7f9PAbf+GkOnp75WGVJYJof0uhroJBcN/QC2qMjga7ddPvaOREAN/ZC21O+rsaQaR+XThG6obt5ZVIfnQWcFQP7RZgL3HpwCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjvnRiVR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjvnRiVR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CAE61F000FF;
	Tue, 29 Sep 2026 08:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790670539;
	bh=ErXCTMd9axWR1jD8SecS5bDbICUqt/ph2JGq6IOzvnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UjvnRiVRm1aRTjDBmXAHjvoILtdKlmNUrWu5POLFor62ynYJOA2fqSgDoGskFgpcc
	 GUv26YNxDVioC+74jtuhRekodZlyV6udP1q+3nZlQV7fLMPqrsoznjaCXLLqly9EKP
	 /LG0lATEOjarG/jYJEX8qhJByFwGciiG+KCBY285l7GnGgDTyXJw9/Lo2iFrSBtDB8
	 15ZEZNJNnOoijG2PYgn5j72A13l5JKZ9ALWuw7WH6YzCIgBLTtPhT1DZcBfoMqXNQd
	 s3fgOGNj0DkUN8ypqcb6i5p32tWgsxoTXKgZpzUfaYs1kguO75iiUmjp2uY+iS0TLU
	 kuTlAyyJXLjhQ==
Date: Tue, 29 Sep 2026 10:28:55 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: David Heidelberg <david@ixit.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Petr Hodina <petr.hodina@protonmail.com>, linux-input@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	phone-devel@vger.kernel.org
Subject: Re: [PATCH v8 2/5] dt-bindings: input: touchscreen: st,stmfts:
 Improve example
Message-ID: <20260929-brilliant-magic-cobra-462c86@quoll>
References: <20260925-stmfts5-v8-0-0fcf49e2c85f@ixit.cz>
 <20260925-stmfts5-v8-2-0fcf49e2c85f@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260925-stmfts5-v8-2-0fcf49e2c85f@ixit.cz>

On Fri, Sep 25, 2026 at 11:22:20PM +0200, David Heidelberg wrote:
> The touchscreen-size-{x,y} is exact number, the -1 deduction is done on
> driver side.
> 
> Example now use interrupts-extended and size obviously not deducted by
> one.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  Documentation/devicetree/bindings/input/touchscreen/st,stmfts.yaml | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

