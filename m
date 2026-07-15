Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B86332ED6;
	Wed, 15 Jul 2026 11:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784114274; cv=none; b=MNYeHwSUpmYA6oIBZIb62SeOhppgal8nyq0D9XJcsb4lusFSMjvqhHLhqYUHjAvmFOXEltEe2W+9QceamPwzShYsMquzQ+bYzfqrA4P1oAJejNiRUHTnz1zeoyEvm5YjmRr3kOnSi7xqgsMH05Csmjxbc4cqIbbBUmQF0nymk5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784114274; c=relaxed/simple;
	bh=o59DV7NlPJNOYRMNRStcd1mNLKM5Tpl/xDZ1cMVm+pE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ii8jDMxkG8jLzKWCX/YNVj1x6/kdh6h4uogom3hucRFoFJ1xpBrRLd3++lduNMmeuubl2c/ZGGLFLXJsmRgLHS+KyM01n5gx3zgDEG9nSpip6D+N3WU+JmwrdgZHtbkimAiHV2qF3R/QKWgNe2huq5Y3sYGN1vtcyL/z6/RrJ9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5RAbJ3R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5RAbJ3R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C2A1F000E9;
	Wed, 15 Jul 2026 11:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784114273;
	bh=Cdu6wwz6rudS510ZJ4MJcK3D8KgJ3DzFM8xwBo1f8to=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R5RAbJ3Rrna8A1+fhfmEfdtacUfgib9DlGERoRKxjcEGQH5Pa7vDPAunQd7gmufjB
	 us8nK9T7iIPFBD7haYinaRImXXN4PG+5oJtzaoPLEWrUO4KCq9+TRgq5XP5ToB47xf
	 gdAg+6iYMbyAE99DpH0L85nAXQuQz1Z2QF3F0rbQ/9zyiJxIx89U1PE50uDeiNGCCs
	 kjn1eMgSnXsKgrPDwNz92IEtoO/BlqRof0PZdsx7NmoTUlRzsuhdfkABsl9SH8IZcN
	 uNDroStU+4hAXHwi7ActICfjUJBCokJdSCq7F1O1rkmLey3bsaRu22XhJCNY/P0S1S
	 QFOLy3PPqJMqg==
Date: Wed, 15 Jul 2026 13:17:49 +0200
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
Subject: Re: [PATCH v3 2/3] dt-bindings: mfd: qcom,spmi-pmic: Document
 haptics device
Message-ID: <20260715-unique-secret-mackerel-e3ee26@quoll>
References: <20260713-qcom-spmi-haptics-v3-0-c931bb7cb94f@oss.qualcomm.com>
 <20260713-qcom-spmi-haptics-v3-2-c931bb7cb94f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260713-qcom-spmi-haptics-v3-2-c931bb7cb94f@oss.qualcomm.com>

On Mon, Jul 13, 2026 at 10:22:55PM -0700, Fenglin Wu wrote:
> Some of the Qualcomm SPMI PMIC has haptics device in it, add it in the
> device list.
> 
> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

