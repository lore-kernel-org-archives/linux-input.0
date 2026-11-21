Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795256743;
	b=mNMPKd4GHnYBjQdzrjzli1mML5bTADOdxrC5lL0TpzZrVyP1JQZJEiEo5/JjxbBGsCxp
	 a5N5qAPVZG9XrARqKMZUfUzE31vFbWEal1asr/1UROOgR3awOw2nbO8zZveNY3zvcwOna
	 n0A7geh5rh8bEO6+P10s36XaiAC9UvobwOgRy7on44zey0Qwxw154SarQZEYbIsWNtTFp
	 sEHMYqdXp65kl2DgUbUPNMWNuhTmGhk0yzYrXecJ5vSjBCLR6Fo4W88MTDzI8o/00dhQE
	 CTzWdlZk9+vfSY9GOvkvE0yIJ/Fo2sv1nyoP+G5dOv9K6ZxCDUAk7EI0luMUGdJ+pag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795256743;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=mNDeg6YvrsPOdQUVy67PCCRbJ3kSBV3g3A++Aptm3nQ=;
	b=Cjl7qFVLAw64NEdyiabBSeDcj7SxuUbprOmap+mYJnL6MiZRt8JnOySpys+EfllEn8VU
	 DiOOoCQodaOCG1o1IzBI7m6IGS4CeoRW4Db6+FYDzD87l6XBJ85y22czpvXVi0RZzqOj+
	 HJVNn3974FIRGmc2fMb0UsIoiDmdTzN4nsvEAoxBdXwsy7PWLwZTP2QwKue4pFGrfacKL
	 2PS0JWjPRK1YSIIbpKzp9H6Tj1CtxOE0AoKuXk3Q+cuLzG2+2iM/RMkBOwla1nh+n5+L/
	 LTNQ6CbEqM4GjoZzL6V05intwZoq8WvifRsPaqbgjLBRez9+Lb5VErOdRlX4Hc+vTSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="c40YX/h+";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946A3606A320;
	Sat, 21 Nov 2026 10:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c40YX/h+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F651F000C0;
	Sat, 21 Nov 2026 10:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795256743;
	bh=mNDeg6YvrsPOdQUVy67PCCRbJ3kSBV3g3A++Aptm3nQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c40YX/h+QhmxT+ESd/lYr6t8a3wmgjO1B3Xs1PwVa2Hto18FliHI+37+AhOaCezWh
	 /4urgXF5XKeOgtSiinX+02kGcEIJZLz9dxBORg4STpJBLpLZnUHKq8JSiyoGTIJTeH
	 GgDcjWnYCAbTBGrwoVYu3X4td8GIBSDatDvsXpmZ8+BDttJq/LC2RX7n3WCUQYkeqJ
	 6niQ+VwzZfaM/X74RHECES8SVCxj8IW5U/qAmsksrJJQgyyb0kTKNimMaPQ80mndod
	 c6mgLaVbyLWsaZtNZzHFf4+T1zOjY9cizGrLW8Vvg2yZeWdSIZQC7W51od5XNYtbBk
	 cGHlDq/zRUcMw==
Date: Sat, 21 Nov 2026 11:25:39 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Abdur Rofik <rofikcoga@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	phone-devel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 09/10] arm64: dts: qcom: sm8250-lg-timelm: enable USB
 Type-C
Message-ID: <20261121-vegan-okapi-of-karma-9b4ce1@quoll>
References: <20261120155450.7719-1-rofikcoga@gmail.com>
 <20261120155450.7719-10-rofikcoga@gmail.com>
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
In-Reply-To: <20261120155450.7719-10-rofikcoga@gmail.com>

On Fri, Nov 20, 2026 at 04:54:48PM +0100, Abdur Rofik wrote:
> Enable the PM8150B Type-C controller in sink mode with PDO_VAR up to
> 9V/3A, and connect the OF graph endpoints for USB DWC3 and SuperSpeed
> QMP PHY orientation switching.
> 
> Signed-off-by: Abdur Rofik <rofikcoga@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 

Don't split logical patches into multiple chunks.

Best regards,
Krzysztof

