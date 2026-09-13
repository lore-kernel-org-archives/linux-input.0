Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBC630D41B;
	Sun, 13 Sep 2026 09:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789291720; cv=none; b=k1DngnaYY818nVZrK1+BmHtIv4BND++hSkDnjEhh/yTlRzzsGcahkhV2bB8vDZlUpadboGnY59xx+rVES5fhKdn9iW9IB94y6BBfoXT3R3K4ikiS4m3oyMNBQ7ibkzi/UJGyLY+7Ce+xFyCE8dDu0N3HKzTGHFb1yP0X9qZEw4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789291720; c=relaxed/simple;
	bh=1J2/1A6pyNm3aR9HUjwEPLKv/fEdMVMciUSdbisyEXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzZnO+d/9URwEag6/y+IWtYpEwMNI0cMPBR9DlTrYMMnM1ZTORRD22U3H3Z3Ar3okHkdjUfdCyz2OkHf2X5GqgJib6sNdno8RgejeWT+XHSaUiDcgrko0rTzml9idrSpYHmRuV3VJ/XZ92l9qQqp98J+Qrb4LIv1Vl2k4rzqF0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCSO7GKz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCSO7GKz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C351E1F000FF;
	Sun, 13 Sep 2026 09:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789291719;
	bh=zRAXfflsyj0gMVmrP2SJ8BE+BkhuhBUZSSDA6IPtF5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XCSO7GKz9o3uceyzTvd2Cz9OhstiXGsVVBfu+ECIJUKO38njH9mgwNQoxHxIV+j+L
	 P+5nwUVrg65tc3maIdiRtAOrvJTkdI5pxBpz+HuUzG3Aj/NYjehdvRWEm3dskWBsg1
	 AkTobT0Ua10pF+lGqTk4JW0W12tzHzQDoMejWwp3TZrXz43mDhlStTwN15XSJa/ULY
	 euBwit6Qcl3QguhhC1Gf6sPdv3DJ9s9kK+BY7kq1HJ5tYKRPdEE57eNgRImqdlyFt4
	 kynBkzrr716a4sM8t0I2tMikBCaEw9ay8FktiekulDeSl8ZvidJTpjUjJ9mq7IxQKT
	 I8maUfPqkkYdA==
Date: Sun, 13 Sep 2026 11:28:34 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: input: touchscreen: document ESWIN
 EPH8621
Message-ID: <20260913-military-cherry-tortoise-176cab@quoll>
References: <20260911-eswin-eph8621-v1-0-db447ff9e445@fairphone.com>
 <20260911-eswin-eph8621-v1-1-db447ff9e445@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260911-eswin-eph8621-v1-1-db447ff9e445@fairphone.com>

On Fri, Sep 11, 2026 at 05:16:09PM +0200, Luca Weiss wrote:
> Document the ESWIN EPH8621 touchscreen controller, which can operate in
> SPI mode. Other touchscreen controllers from the EPH861X family (and
> potentially also EPH8621) can also operate in I2C mode, this was not
> added yet.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  .../bindings/input/touchscreen/eswin,eph8621.yaml  | 79 ++++++++++++++++++++++

...

> +  touchscreen-swapped-x-y: true
> +
> +additionalProperties: false

If there is going to be a new version, this should be just before
example.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

