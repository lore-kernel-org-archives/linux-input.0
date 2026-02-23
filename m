Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86746358D3D;
	Mon, 23 Feb 2026 12:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771849496; cv=none; b=jySCPYOz71uqL8J8Z7KLF3+RLmIm35G3aoJUQSGDliY4Vy+gbzDGwrbr0iPFdKCiTB//ecZkn7La4vKkvGwLG+3hjMJcauNhdfBeGYetbzEn5UDrxro/geWLrFhVo2nlAZIrHJDRU12g5kELgexBtxqIo0kKLJ08d9jt9CB9jD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771849496; c=relaxed/simple;
	bh=EiW0Z+t0RcDcPdpVej3j7y+vuld++Y/zuPUbN7UI5q4=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=sfH29DbmdWR1vJgp9WMVZEEKVEHMinvzulJVAo79/h+mNuVrD2xIWyEs/+mJO+9EaQGCDmRiJ4a4JiIcCcJ3b3jHsXrILWN2pEGOno37Svj2HccoY2wl++wWqDmMNV71UmUIAed2TZqCZL6XeV0pCpuqAnD/q9Yxl8+Vp5MRJ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKo6/zgu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKo6/zgu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1811AC116C6;
	Mon, 23 Feb 2026 12:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771849496;
	bh=EiW0Z+t0RcDcPdpVej3j7y+vuld++Y/zuPUbN7UI5q4=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=OKo6/zgumo8713SC6HGgLQebfdc2ogmVl8cGP5nssz9bA9mrkX4aXHCfgVym9/wsL
	 GA/jqLpVEJhmIi8OZQASW5H2/6IQGIpon+Ef4g+Fysj113eSU5sK8a10iDmKj5s6gj
	 2KNO3LUeZ0LkghPXeGnLff1qJdrGLdyfvdVRQzLgVMR3PfbNEGSnqHETHgi0hB7nke
	 Ree/fycRcj13wOgVs8pbeDNinSGYYtF/g3dPMQuxksegMwaN/XpwtvsH3TB5U6i3FP
	 Sozs0P75cdkN6Qo51jIvdDHHi5/lUQaXWnYGOyGZZ4dZjNIascaThUA3Av6pmfqgEH
	 KdkuJOXNLg5Ug==
Date: Mon, 23 Feb 2026 06:24:55 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 linux-input@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Marc Paolo Sosa <marcpaolo.sosa@analog.com>
In-Reply-To: <20260223-max16150-v1-1-38e2a4f0d0f1@analog.com>
References: <20260223-max16150-v1-0-38e2a4f0d0f1@analog.com>
 <20260223-max16150-v1-1-38e2a4f0d0f1@analog.com>
Message-Id: <177184949524.3256996.10057873509160996630.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: input: add adi,max16150.yaml


On Mon, 23 Feb 2026 19:03:39 +0800, Marc Paolo Sosa wrote:
> Add documentation for device tree bindings for MAX16150/MAX16169
> 
> Signed-off-by: Marc Paolo Sosa <marcpaolo.sosa@analog.com>
> ---
>  .../devicetree/bindings/input/adi,max16150.yaml    | 57 ++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/adi,max16150.example.dtb: power-button (adi,max16150a): 'interrupt-gpios' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/input/adi,max16150.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260223-max16150-v1-1-38e2a4f0d0f1@analog.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

