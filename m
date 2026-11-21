Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795256760;
	b=at07YH76s90JE9CFf8ZXLgFa9dM7NVUiQcOUqsOlgeRR4NdpvYlYubv0S411TVhUAkhv
	 gDPfUvMyw45Rz9KfQi0WwnxJsGxYdKLdwqm5aZYDK2YVZa5L4wEo+ejY5LZ4AFZ2HD0Cz
	 JZtUAbuF5dx75jRbXCSgMd+H5ukwq1IBSKnITYFmDW9l/PahZn/YEMiOyJG9K/5nqPw9F
	 SqliecwYMlBZvvOULi30XXp/lE2K1W8nQORmBMbiTQV6XrS01AWG+KqjQh18EnHKpZUao
	 C+xVrdyM9cObgXx5EGlSzP0hfoybv3PSAgAZKM2LM46xWfpZxaklBtqc/IPT9wNZp9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795256760;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=MSk/uVkQyfUVhAgt2eCEE3LaDy/K+jEkqGBhIcy+lD8=;
	b=rVZp5NS5HvTs4nC6DqpqVEWYwP7hgw7SJmljOWUPjjlf7zK8WMLrL3JvEyv5FRtlcALM
	 WsaIk6pk+3Plds53awua9HkInnI2zQiXBVyNGPVPq9eU8sfhGVySIDXsNjVCWv8nwDQKh
	 Vv/+5oawQYZotrNU1TgoTUygAR5+wJt+hdBldXlgod35J01wT7HDub3oWSrjUXfP5lw4P
	 JNaRNR3/7SfeFlai0IeqyyW9y6XT1dxHuJqSv5SxdzbUwjFcT5On5BcVYLHTOwoeScjZd
	 Jg6IdCNgfqlTGF53t5SR5/YLpz7c0yMsXYBMG2neeF9yimti5jO6dmEtpc4TQNhwlwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BsS0fMdx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1629E606A320;
	Sat, 21 Nov 2026 10:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BsS0fMdx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D49771F000CF;
	Sat, 21 Nov 2026 10:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795256759;
	bh=MSk/uVkQyfUVhAgt2eCEE3LaDy/K+jEkqGBhIcy+lD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BsS0fMdxleqFnsJwCTuV2102PxgMUABBW/PoBag/xS1dCc9qRqKeiEwMMM27QJC35
	 fhqO0urH6WPxMpgo8mcsAi71SXrWZomy726Qy4r39DfWvhZCoqvFfHUk8F4wqXC9RN
	 nPHmEwypNKXSpJ/f0GN1xrP3CE82MrlmNTQvLtJXkuj7XijFZSPn0m3ZaCK+6lgorp
	 ieA//znJ7F1UW1SuHgZO3NHGeo3UxsApZ2dDasrm3iZ1R1jORq4cNOTB43reuxGASK
	 PMMCsO52sgeVTpIgzRTGHnMupkSYA9BTYEcmmeg2WwBkDO9th9+OK1MujuVhWHqBiM
	 7JDEdAvorECPw==
Date: Sat, 21 Nov 2026 11:25:56 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Abdur Rofik <rofikcoga@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	phone-devel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 10/10] arm64: dts: qcom: sm8250-lg-timelm: add QCA6390
 Bluetooth
Message-ID: <20261121-glorious-apricot-bird-4dfd91@quoll>
References: <20261120155450.7719-1-rofikcoga@gmail.com>
 <20261120155450.7719-11-rofikcoga@gmail.com>
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
In-Reply-To: <20261120155450.7719-11-rofikcoga@gmail.com>

On Fri, Nov 20, 2026 at 04:54:49PM +0100, Abdur Rofik wrote:
> Describe the QCA6390 power sequencer with properly voltaged supplies
> and enable Bluetooth HCI on GENI UART6.
> 
> Signed-off-by: Abdur Rofik <rofikcoga@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts | 92 +++++++++++++++++++
>  1 file changed, 92 insertions(+)
> 

Not a separate commit.

Best regards,
Krzysztof

