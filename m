Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185AB41A903;
	Wed, 15 Jul 2026 11:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784114264; cv=none; b=SKUyks26rm56RGu0O7+THXgVFqDBN47/2ZVJsVpn8rG8SlBDEblkk6lwtGPUkIsmcS9v6yjrgZb8hYzHR9WucPefAscfQJ4Uj21FAflqc7WTTK/uwR+1KV9W1ClHBUfwTby2hDfrMWc4O2cAk1tPbwO+nU3+LcB4iJ2OSCSzMhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784114264; c=relaxed/simple;
	bh=FV4Zl+RiARqDVKp+ZFBvAbY3AlKqaOkB1RwkDwpbmjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5Ci0naUVG5iupLv/oczJhhOZC51CQcDXndmYS1vqf9YYYYM4TPKl0OYQ55zSh5uxO2VLgnvvM9WB30a5IBWsWneswBQWd8sW28DNuTeLKIwRtxUvKUIURQftJh24uo1Hzta/hsABGGXA1Qf3i+V+A939MdoWhn+TxyYkQHpT8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XULpsIfW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XULpsIfW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C6D1F00A3A;
	Wed, 15 Jul 2026 11:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784114262;
	bh=RsqWOU1WwFv9CnGftjfPyR1zNkZAjwDTkCcX3vvrDv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XULpsIfWcCf8FHvH1E1FkQcYzYOCYatqFboUcLAuTLPBTA7iNSjKgXpyt+ktkRJ0i
	 Bt2CJVRqF7DcDQuOm/6KEibHMdcGV+bQcmM9hmmKegqvQ2rY6nFU3f17N1FBJ6n2CQ
	 BGh0qulgz1e1n0UG4ZyTAvLAA3Wk+dM2ZD7j5zJwvBLyeFTPxGeVwdOsq5bsjGbo1F
	 LSK+W2BB90BK1Z4UiF5r5+CDRxCa6E4FVjSMmgox+BVN8xvjlXUMbiFyD0ab0vMnFx
	 y6FDohC1pM+TItcL0MBPGGo29vjPgRW93zJWXZNrFet9I0V5y4V7MuKvxVGnRyz7Yv
	 rVm6uLhcuIkJg==
Date: Wed, 15 Jul 2026 13:17:39 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, David Collins <david.collins@oss.qualcomm.com>, 
	Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>, Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>, 
	kernel@oss.qualcomm.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: input: Add Qualcomm SPMI PMIC haptics
Message-ID: <20260715-skinny-seagull-of-art-befa42@quoll>
References: <20260713-qcom-spmi-haptics-v3-0-c931bb7cb94f@oss.qualcomm.com>
 <20260713-qcom-spmi-haptics-v3-1-c931bb7cb94f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260713-qcom-spmi-haptics-v3-1-c931bb7cb94f@oss.qualcomm.com>

On Mon, Jul 13, 2026 at 10:22:54PM -0700, Fenglin Wu wrote:
> Add binding document for the haptics module inside Qualcomm PMIC
> PMIH0108.
> 
> Assisted-by: Claude:claude-4-8-opus
> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> ---
>  .../bindings/input/qcom,spmi-haptics.yaml          | 136 +++++++++++++++++++++
>  1 file changed, 136 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/qcom,spmi-haptics.yaml b/Documentation/devicetree/bindings/input/qcom,spmi-haptics.yaml
> new file mode 100644
> index 000000000000..b1a69e9886ee
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/qcom,spmi-haptics.yaml
> @@ -0,0 +1,136 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

