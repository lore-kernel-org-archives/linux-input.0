Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795256729;
	b=P8JYJeLoQWBFsK6gpcr43A9Dic2jEj3EOYUnkkLYb3L6ujacjd7g/Km/njubgQT/I3Ti
	 PfSuKUAkkxK620NdeLoPyLGOqaPm8ELicQn4bGfGJSwjoUTJ1wvwtd54BMVp3Y+N+7XW2
	 qsEPOTMIX0qv3KqAbiPZgtsx5FAAsFGB0pw1yZQyUNv1Y4OU3PLYk+vVnQdDsJSXpqzZP
	 NUOvpCDvXFUD4ULcEWEY6BrjQdAG6eiey1j7EMUhmVxQ+RXHQpmwM/Io1VxSW2Aaq1I23
	 nKRV3d1ZQXI9lUL1z+F7wmzbo6upPFGFCxTSAeDfkwyq5QhuITClLQNMLGlg9bRe1kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795256729;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=zcYwiYMgwHPQSKRl9NzBw2LKspoM6b+H+dLztCd23Cg=;
	b=HOgTzwIxPu3kJgliAZzYHDIo1iijmVQi91NzQJdtsOMiOYZ41JeWfJZfZlAbbmldhRJ8
	 CL3LeMWAAqERIKeFGS1uzQrL/ZcKB5ZGVChpCAy+d905PBoL3/Qii8KUwtoxDeVVtvdvf
	 O9/3nJpezh3El9zD2iKVIDC//EPDnedSk3lrghH0pqSurC9LYiAYm5pY1rusQR85KJBdA
	 /cBWF9F5XFxR+wv/SsNQ3XkFd3Khp+XOaWKbCIg314rRYB6XRZf+EtBpbV/M4soNXH2FN
	 X6DWEwcJCKzR4fX/avSQ5qwVMx0/P+icrBe5H/6dtfKfx0NM4/uITeKqK14RIe1Yz6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mb94tnCW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97924606A33A;
	Sat, 21 Nov 2026 10:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mb94tnCW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50DA11F000C0;
	Sat, 21 Nov 2026 10:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795256729;
	bh=zcYwiYMgwHPQSKRl9NzBw2LKspoM6b+H+dLztCd23Cg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Mb94tnCWX/iYDn9bt0VqQnsMIk2qoUIRC14x9VjZlMkPCi/+ubRWhQ9kq/WIXwV6h
	 YMlLbsqBU467I2LaNg3KvLo8R0fSLbaKmjo9aaC7vaMFsomO7P8f1I2yB6ROoNsOaa
	 924v6loVFKQBJP0psU7EfhB24rlH9Ab5uDdFV/w7AH8ZxfMutfLEyzvC9YBp0flGJH
	 cLkqYiKyKo8DDomEwCcbvLTg5qcobNTuIVo1OLMGjILjmyAfB0cWVQX2LafKqV/O/4
	 b3hstB0e1qvpmyEdF2EakNa8jAvm/eKJJE+s0FIK/merQPOwZ8J7XV2DQ7ZH1jiSw7
	 hJwq6mSHlUIAg==
Date: Sat, 21 Nov 2026 11:25:25 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Abdur Rofik <rofikcoga@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	phone-devel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 08/10] arm64: dts: qcom: sm8250-lg-timelm: add SW42902
 touchscreen
Message-ID: <20261121-skilled-boisterous-antelope-0ca5ef@quoll>
References: <20261120155450.7719-1-rofikcoga@gmail.com>
 <20261120155450.7719-9-rofikcoga@gmail.com>
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
In-Reply-To: <20261120155450.7719-9-rofikcoga@gmail.com>

On Fri, Nov 20, 2026 at 04:54:47PM +0100, Abdur Rofik wrote:
> Describe the SW42902 touchscreen on GENI I2C13 with its interrupt,
> reset, regulator supplies, pinctrl, and native 1080x2460 touch area.
> 
> Signed-off-by: Abdur Rofik <rofikcoga@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)

Don't split logical patches into multiple chunks.

Best regards,
Krzysztof

