Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267B91E9B37;
	Thu, 25 Jun 2026 03:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782358364; cv=none; b=jCv1CjW71+xXwF+Oge2xP4crd41yoW9OpsYGY3w+AVMSX++1aygJhMWaOnTKVI4U0BHAhB+1l+0ehUTMj/HpKD2AfCBtc/YmS7mMZ6N/4agZAjOuyViTePBCOwuPaEkkCHn0zkWxNA0/Zvmn9tN9pHRbXEQUDPHfydsxYs610DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782358364; c=relaxed/simple;
	bh=JGheuopsp2mLIfIpiy73fg30l7DNifCBvmhk/hhKNFk=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=paxeecUabw5Vn20Pj9QA1DT5mMsrwnSrlygR865m3ByFmp1ZpnSYrVCkCEW4rCiVGWEKw04AXdteABoRPf9zWf2LcnC6n4FaklUVT6Y0MMN7yt6d4qLsY9XGTp1ZaguxrqKSSf79928GlwPC/JccddQJlsswsef6UeBn5N0FW54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebdE0jcG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebdE0jcG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B7F1F000E9;
	Thu, 25 Jun 2026 03:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782358362;
	bh=OQmdu86f3xGWit3FX5euECxwtL9jKKb6r1TC7QBOJpg=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=ebdE0jcGtbeWg4C6LNbOJu5KpB52Fhcii0PQgI7VOWesWOY5xH3q2GIErdY4mOFz0
	 2UrVBA8mC9VS+yiIM+B8bXGgz3G4GBeNH54v+q2c+Nxt1tPwLXdz5LhPK2uhjvU9EE
	 J08qaMsK7Ccj1r8YszpL7c+lzhc/s/HnbQ6nMrsgyuKRR7ZQo1VSkqGw20tBTRVZIu
	 omY+/JUDFJ+ZYGTJYy+RRSNIPrRCYye0M0I4uwEcfuB+m618tTUEgn7Km3eH7EBt/H
	 bOc7bDPYSNoY0UHZOsDQnRwdd1FUeW02llsTqZFvzDBibK9H+rNE2aGKbzz8jh1+at
	 NEE261B0ZvN0g==
Date: Wed, 24 Jun 2026 22:32:41 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>, 
 Lee Jones <lee@kernel.org>, devicetree@vger.kernel.org, 
 kernel@oss.qualcomm.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, linux-kernel@vger.kernel.org, 
 David Collins <david.collins@oss.qualcomm.com>, 
 Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-input@vger.kernel.org, 
 Stephen Boyd <sboyd@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 linux-arm-msm@vger.kernel.org
To: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
In-Reply-To: <20260624-qcom-spmi-haptics-v2-2-b9118e60f3e3@oss.qualcomm.com>
References: <20260624-qcom-spmi-haptics-v2-0-b9118e60f3e3@oss.qualcomm.com>
 <20260624-qcom-spmi-haptics-v2-2-b9118e60f3e3@oss.qualcomm.com>
Message-Id: <178235836163.1577089.873414193711217000.robh@kernel.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: mfd: qcom,spmi-pmic: Document
 haptics device


On Wed, 24 Jun 2026 19:00:37 -0700, Fenglin Wu wrote:
> Some of the Qualcomm SPMI PMIC has haptics device in it, add it in the
> device list.
> 
> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/qcom,spmi-haptics.yaml: properties:qcom,vmax-microvolt: '$ref' should not be valid under {'const': '$ref'}
	hint: Standard unit suffix properties don't need a type $ref
	from schema $id: http://devicetree.org/meta-schemas/core.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/qcom,spmi-haptics.example.dtb: haptics@f000 (qcom,spmi-haptics): qcom,vmax-microvolt: 1300000 is not of type 'array'
	from schema $id: http://devicetree.org/schemas/property-units.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260624-qcom-spmi-haptics-v2-2-b9118e60f3e3@oss.qualcomm.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

