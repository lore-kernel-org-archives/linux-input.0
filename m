Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793780985;
	b=gsQWsutk4s4FBR1QOZO17gMRn3hw8f0siEPrCRJlMGEJswXcvQ/lRh2Oi0kGqoh2EYFu
	 3Biw9684pRTx1/n5Mw2ccESp2X9JZFoeLbjjBg0yPpF9piqXmSPddCRxL90JHwI+CViXh
	 74t98M3i/QTGJJUep+ur7ayFlySsjQJut1/mfFlhDjIEbBJI+Q/xhvnqAM/3MP7fiIVNN
	 UQ/Qq6V0y8sVkjHdETrESwtOOImLO732XSHbBt8h3OFt+xVBFN8ARZ/qdJEGSvftOXgZ9
	 JOCT7yo0HD8DPtNUGy7h5cZZxTdALqYNL3iGRFBOUcz8EH1hZNbRSbhwSoHnlLYkUJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793780985;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=nl6L06sqARkCo9XfmcWkLtOVIWivO+RI/ww+WDQcc7o=;
	b=VV3kzHv4oLKDPYKxuHyIBAJMFT4g6EtuV9DCPo6IJwp5kn8mS5EKXDLo/DO7iR2gCq49
	 a4vknSEpZhESDyiKHVzIl/I7QNVTf6ClQaDzTh3Vbu2dmLM9N1TNemAHYWFJLb1B+lLyf
	 /8Wmb/BbPAYtDDEbMgj8jgWD+k8v9RuyXIYCYl9ktCT9Oc9/eGRblJ+MLwFu74+VaXfEu
	 pBejXmJeyeVJDBSx0XUlVScPhQpHq3viKqf8Cg5eejXAiD7U4DhzDL/jkLcpuOyBwS4zr
	 OyJ3cf68iuX82TT9NKGLzKHaP/AjBgJf6SIKxtEQUEkMjA9pV7xKIbtH05AAT4/Vksg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X5NfFabq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BB9606A326;
	Wed,  4 Nov 2026 08:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X5NfFabq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61E61F000C1;
	Wed,  4 Nov 2026 08:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793780984;
	bh=nl6L06sqARkCo9XfmcWkLtOVIWivO+RI/ww+WDQcc7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X5NfFabqJs1yLbIpwZ1BMB4i5++b4fZVhrVcNkqVsx7Ps4xGRbgkcSj/GCCExf2dx
	 wsU3HCQ6GJQBCxHb53FVItzAXNWM99dZkd9d1B5looPxNRs4ceys9AG0eRZwnLbr7o
	 qkwhznfcEzbpWZtc+n1PBcozE67Lb3r9IBoYlF7gpOYwh7vLIX6ue/aEmQAy5eU5eQ
	 o7adtdVkQKbEbkl116ApyqyHaC83s1nBABrGSBNyrQlIA8eFsrZgZeG5Ezjjak3aK9
	 jHpAv0tqkptkH/kURbX9tDv09wsPhDQMY50kBNxrREG+MJbcw3kqbk4eJqJ43vUH2X
	 ioJYBm6L5makQ==
Date: Wed, 4 Nov 2026 09:29:41 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, David Collins <david.collins@oss.qualcomm.com>, 
	Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>, Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Heidelberg <david@ixit.cz>, Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH RESEND v7 1/2] dt-bindings: input: Add Qualcomm SPMI PMIC
 haptics
Message-ID: <20261104-myrtle-kelpie-of-chemistry-de43cf@quoll>
References: <20261103-qcom-spmi-haptics-v7-0-418de67ef84a@oss.qualcomm.com>
 <20261103-qcom-spmi-haptics-v7-1-418de67ef84a@oss.qualcomm.com>
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
In-Reply-To: <20261103-qcom-spmi-haptics-v7-1-418de67ef84a@oss.qualcomm.com>

On Tue, Nov 03, 2026 at 08:51:17PM -0800, Fenglin Wu wrote:
> Add binding document for the haptics module inside Qualcomm PMIC
> PMIH0108.
> 

Why are you ending this? On what sort of ancient, downstream fork are
you working?


NAK


Best regards,
Krzysztof

