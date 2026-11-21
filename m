Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795256710;
	b=TgvPDHPygQNh4s64Pf5wPIuzXqMOTtI89EHsa1WyvHnkrkedk8K4Glvusm9Lt74yyAMj
	 F/8zmHfhwF83xZ92EfSwWv9VvcxQ8JWbO5COsDZ8+vbDm9o+/R91S7+qfxQ7OSnqR9BJI
	 WKsgJxEzp+lPx2ZeYUbIUWwJYi0+WDE3jbuY9wJ2N7CAULjB9YXKBi99TZnGpB9Mye4Ig
	 ex/StkhhB+2dkObsi0TFIMKQipkUsuNrW4NzIzzxblGj0nHxn9kIgxCbev7PhbSdSyg4F
	 tWJsk7JOqjOblrBeUaf5ZfBZLkaedHd1qUteLFXpHz6UoetAKPrTO1kx4p0Vv4NLsyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795256710;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=FS0SGY45488KZrZ0atpu54dpxNlj/6wagsa2k03gJzU=;
	b=5bCqJrmw+ZSygteuTXSYGpepQgoIb8VbVfSyW5YR0TkNFQsqRMwx7v1Rjo8opYGPIP2d
	 qVJJ3aHdFPKms2SYCyd5SAJccw+IRc8x1F74JXys94GzOTKVKcs3mG5wP25EHB5bpr42S
	 1V7zYcZpRk6+GRObmrGLO0i7AzQ2usMwcYxIKhv0Iar4EzGdirUCKSxv7jRde3BuTJQ8Z
	 RZM+mW9GderuOHFyJI/RXlg6O8lfSlW/IIZKSpiiy0BfSNGdVnEZQdllleVOi371rosta
	 sUX8ybAHvqwtAyZF4HsdJAA7GByzYZRtxT0ntz20o+bQxADsBk7XZ1a0e2AKOXv0XTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hBz7WbYY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0089606A32A;
	Sat, 21 Nov 2026 10:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hBz7WbYY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909A51F000C4;
	Sat, 21 Nov 2026 10:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795256710;
	bh=FS0SGY45488KZrZ0atpu54dpxNlj/6wagsa2k03gJzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hBz7WbYYrXorJK9xAFL6eIh9ORLC89FZ2RPxREuoxuc1sLOgkxrwxEmX2vcMO8Tdw
	 8raUF4itO4NSXzGm7nNsI6d8gaqXSi0K/0o2ak1bWJ17UR7TXWYUKJUQVGY9nR3WyB
	 MYq3c3m/+W8/AFGUFk0sy+EdcMIuAI7UwGqGOVWP0BkBgefRFWoLMggMuh85L87C7E
	 jmh0BoFMn2lPWbcZ8EI4aBOFq7UD/i/DcLgXGN8D4CpWYslU99+0h3SzjZUDDBqD1F
	 qZ3HwE8ONVRDd2qSVXATjiBNPkPRxLbScjsEI7cI7GF2cRJLEsX92+GaoEwb5dCy9J
	 ju+GmBRSv5+yQ==
Date: Sat, 21 Nov 2026 11:25:07 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Abdur Rofik <rofikcoga@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	phone-devel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 07/10] arm64: dts: qcom: sm8250-lg-timelm: enable
 SW43103 panel
Message-ID: <20261121-furious-turquoise-zebra-28c6ed@quoll>
References: <20261120155450.7719-1-rofikcoga@gmail.com>
 <20261120155450.7719-8-rofikcoga@gmail.com>
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
In-Reply-To: <20261120155450.7719-8-rofikcoga@gmail.com>

On Fri, Nov 20, 2026 at 04:54:46PM +0100, Abdur Rofik wrote:
> Enable MDSS, DSI0, and its PHY. Attach the SW43103 panel with its power
> rails, enable and reset GPIOs, and four-lane DSI link.
> 
> Signed-off-by: Abdur Rofik <rofikcoga@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts | 36 +++++++++++++++++++

Why is this separate? When you have your new board DTS ready, and you do
have, posting a new board is one commit.

Best regards,
Krzysztof

