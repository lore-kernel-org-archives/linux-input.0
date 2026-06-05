Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2705637F007;
	Fri,  5 Jun 2026 12:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780662692; cv=none; b=vBtcW0U5KJo3OKSP6kuB6K9sdxb6pDVNoHeuecly2/OAcm6xayC6TuAJN1iXkMZwevpkPkWlg7WCIoU3QNyCjgTa0fSlis+Jh6blS7Ezo/8IGrB4WZTIcja86bIbguAlGAuOfjF+9WS0mz+wZQYME/WnpRTta+kxGkaNHMtlhoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780662692; c=relaxed/simple;
	bh=fO9wtBW34zAhi+8wiHSQWjzftFASSQxglIFCsTNCjPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGYhQUsUDEUDI1osUWsf2/ocyS8CVpwgVgIPjUkh5jlg+5hm7r+E1TDNYtZV9thSy73zgGaPzAfJcC/zamK0G1ez5r0CZ+9sBdJ84ECQC/E4M3PgCovIXlmiU+ozbAmtzNmot/kQLO9FB8Tp4UQO2Ymd4t+qsg5pQj4+nRxacpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2yKP9WO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2yKP9WO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55851F00893;
	Fri,  5 Jun 2026 12:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780662690;
	bh=1/9XIyAmBr9yE+f68gnbonN9RBC7Y5W3Z/rBU7vyY7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G2yKP9WO8CK2fuTkuaGpQ+EU3zov3AOFnWB5EHFJekn4oeOO2sbVEwsdtokXY6+H/
	 XJ1oIPbOvo5m0lMJRqtqNPXA9KAfgxhbGRBrB9KeCVINjGxYNTgDXRZqvFNTm5OFrQ
	 SCKceYXMVPsUM3KKROt1Y4EuAHGlIkAmRl7R6DiHhvjZHfByselrkzPuKj1W1Dh7x+
	 EaMJiv33dNweCmSUBph0PZ7cfGcw8fXFene5YWXM3GqL8dJMaIkIj/yIB4D60xhNYX
	 xpgMhBC1YmdfKkhwRU6o2CZbdxwCMe+2xWnsdtyGw5QSG9cadG5XnN9P8R28lmdGYp
	 PK8Ut/Q17InPw==
Date: Fri, 5 Jun 2026 14:31:26 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Pradyot Kumar Nayak <pradyot.nayak@oss.qualcomm.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Daniel Peng <Daniel_Peng@pegatron.corp-partner.google.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Abel Vesa <abel.vesa@oss.qualcomm.com>, 
	linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: input: focaltech,ft8112: Add
 focaltech,ft3d81 compatible
Message-ID: <20260605-ruddy-angelfish-of-speed-ed1415@quoll>
References: <20260603-arm64-dts-glymur-crd-add-reset-gpio-to-v3-0-3453ef577bcf@oss.qualcomm.com>
 <20260603-arm64-dts-glymur-crd-add-reset-gpio-to-v3-1-3453ef577bcf@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260603-arm64-dts-glymur-crd-add-reset-gpio-to-v3-1-3453ef577bcf@oss.qualcomm.com>

On Wed, Jun 03, 2026 at 08:41:19AM +0530, Pradyot Kumar Nayak wrote:
> The Focaltech ft3d81 is fully compatible with the ft8112 i.e.
> it uses the same I2C-HID protocol and the same power-on/reset sequencing,
> DT nodes for boards carrying an ft3d81,can therefore bind to the existing
> ft8112 driver without any additional changes.
> 
> Signed-off-by: Pradyot Kumar Nayak <pradyot.nayak@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/input/focaltech,ft8112.yaml | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

