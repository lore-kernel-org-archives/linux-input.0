Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795256457;
	b=iQqx7eStjLoqe5aRf5fEfN9XkDM4EZR9IddMtq8Ly6YsiURjhJxahdREXtt7wJBCEtjU
	 trV7p7wBsQmbrjwPiS31tTTiXfnBD5o4V3nzxRXsbzoj8TtmJidpl5eW+wGXAGv1E4i32
	 MPza2bchnK894lVMVtbCmNSQrzbb8LR73exv63qY54Xx2yVRnTr/HDftLX8MEG/+q4xTj
	 MnmGkV7wTbSM8aKCnFjVPmNRtYZdfXvJvR+gMwkPg69FTp8UimLiHyOsg2tlimeLKx2y1
	 Gsmm6z8ghGtsNVLdRw2Mv30gbsiIBJEfMJVUbiljD5hQauTmeD8G+8H9rFLT/cOyzYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795256457;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=PBpuaU4ZDQrnpSnbxJPolIK00ZR9E921mIZ9nlUSwCI=;
	b=NIi6btddXIDEhU4ch/nXKE2cdRXRXfoQJiBjhyKzy7n0hp3jmeQ2ZJDtguIJBtbjEzxG
	 y2XoKnvGxAQeFMFpqevt04HwQPo4Ey7BnP0rPEvd1kiI33UO6SV0V/XCXEVG7k6jWcLI7
	 3hDRhJw9cWzUIMHBNDUKfDjTXzHweeEJgAFnFxxkyOdq9MQHWTx4XzYqdvQ1Yq7Ebgxns
	 9SW2wZMFVsd5p2vG9qRza/mMEiwdxeI4PFvzHbwwFXbH/ScCT8TQ+j3wDp0KMy5JYU+7q
	 8TG6BzwIVGzSTZRETYY1393uqwR6p0SYdyQVJY66mT8aIXNiDM3rKy0lOcLO9h6K+0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RnU3Y4Xs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C28B606A33F;
	Sat, 21 Nov 2026 10:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RnU3Y4Xs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0F91F000E6;
	Sat, 21 Nov 2026 10:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795256457;
	bh=PBpuaU4ZDQrnpSnbxJPolIK00ZR9E921mIZ9nlUSwCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RnU3Y4XsE0fMQzt9mlKiq7UR/qJeV3o5+mKuONYtx7rgqkHLRgaOyxFg22FZPCt21
	 Hx2TRMWTSfjSPalRtTfH3Y1/AWR+v8vX2xCyReNwfKx0kkNGMwW+2T6+9utriTBY0Z
	 fHUyOpmNKuSkQEGLErZNSn/NzLv+6axlv/UWchCSL7SCrH3YjjBgIlYKKHG87ZF0Xn
	 YEQnZIoNMz1rRh9d5eBcPYhOCUMJI8DkBSuENsDZmSiWhpblTZV3YSc5GGw9NDzyaT
	 //Oz6Y0VsoMFdiLA7OqEd+3EMBwQ24l0j5JTN6xMXVulJjuYHUlZtrSn23xvlv/VrB
	 0illTsdzUizVg==
Date: Sat, 21 Nov 2026 11:20:53 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Abdur Rofik <rofikcoga@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	phone-devel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 01/10] dt-bindings: arm: qcom: add LG V60 ThinQ 5G
 (timelm)
Message-ID: <20261121-crafty-mysterious-degu-50a9dc@quoll>
References: <20261120155450.7719-1-rofikcoga@gmail.com>
 <20261120155450.7719-2-rofikcoga@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261120155450.7719-2-rofikcoga@gmail.com>

On Fri, Nov 20, 2026 at 04:54:40PM +0100, Abdur Rofik wrote:
> Document the compatible for the LG V60 ThinQ 5G (timelm), based on
> the Qualcomm SM8250 platform.
> 
> Signed-off-by: Abdur Rofik <rofikcoga@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

