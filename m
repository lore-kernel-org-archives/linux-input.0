Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CCC2DCBEC;
	Tue, 11 Aug 2026 07:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786431808; cv=none; b=HobMqBXOma7RZcBhFMU4GTtZbgoMxNECxMqYynYTLCO4Q6z9/HeCm+gyx2X5HN9ZnC1/PrJBmGJ8PcVsgyiA3yKbs6wbREOr8Yzn36qZZQ8JCX+wiVKzDfKnz5VemFva8eo/BLdczAdsI0DEPqXGBX9uv4N2cBX2+/rQiGKHKPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786431808; c=relaxed/simple;
	bh=Bf9bJCNAnk4h2Ig02ppQHOliP0VWTaKGW6IqI494eYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6BdgzAAEGsUTB6oeACT7lhjL99Vydo5Kyrc5YODZcTF/XMHdytDwJ7cizQVnG8eKbKqbNiHxZwHOoerl16S5ijzdopeNatv8FbOS31aS2/Y71NaHdODe4EPe8vDJlWiTIjISr8cHE2kEgk6cy7nuU3WQE9weWzi7p1+qaeKjpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXj7YKtJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXj7YKtJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C93ED1F00A3A;
	Tue, 11 Aug 2026 07:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786431806;
	bh=wx53Ap3mrvChep95/lU+75w+ogUAiLoztEeouw6F2LQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QXj7YKtJ1ISP/nOGFp1MkHFIYyMUMD8gVgJnzdfT6sRYsTZ+MrwZun590xJA/je/W
	 oV9DukkOEYE+l8++aPoZ0pdZxVSYX+RdU+JxTOjUtEND7bfsMqTGLSLaNaoRwmL2HI
	 WobQNpyywlXbsGTUFAjVbUzTyRsJ4WSWbySu7ds6XHEp+oxNaZtTvNSJrKtHeVYIYF
	 ZkTbfbrefFzn/45riO0XmmXTow4+HYV9jbaEraODjtVgc8Ep711eE6M33d5ydoqHBA
	 vLlyepjS7FRbAddd7UKWQKOvpUo9H/w9gq9AuNbxlVrMnaBx7FwPFbUn4ex8sIkss4
	 +f/nTygUtAkpA==
Date: Tue, 11 Aug 2026 09:03:23 +0200
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
Subject: Re: [PATCH v5 1/3] dt-bindings: input: touchscreen: st,stmfts:
 Introduce STM FTS5
Message-ID: <20260811-inescapable-indigo-pig-0a5c3f@quoll>
References: <20260810-stmfts5-v5-0-0c737d929976@ixit.cz>
 <20260810-stmfts5-v5-1-0c737d929976@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260810-stmfts5-v5-1-0c737d929976@ixit.cz>

On Mon, Aug 10, 2026 at 05:21:40PM +0200, David Heidelberg wrote:
>          touchscreen@49 {
>              compatible = "st,stmfts";
>              reg = <0x49>;
> -            interrupt-parent = <&gpa1>;
> -            interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
> -            touchscreen-size-x = <1599>;
> -            touchscreen-size-y = <2559>;
> +            interrupts-extended = <&gpa1 1 IRQ_TYPE_LEVEL_LOW>;
> +            touchscreen-size-x = <1600>;
> +            touchscreen-size-y = <2560>;

This is not explained in the commit msg.

>              touch-key-connected;
>              avdd-supply = <&ldo30_reg>;
>              vdd-supply = <&ldo31_reg>;
>              ledvdd-supply = <&ldo33_reg>;
>          };
>      };
> 
> -- 
> 2.55.0
> 
