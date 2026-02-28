Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E311DF258;
	Sat, 28 Feb 2026 11:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772277809; cv=none; b=N/Lk7H8JbVXuKJyBWXfz4V1a+S/QCDka15HzjDgjx7/Os3QOJ/cxwFrNynjO8f89vBVvYRGY2t4noMd+nGpJqBwUB5qSUR59l28G9epdF43VWSyp33P+0LBSoIKO9PK2pf1IZPUffBgigMujWoYm+JdAaRez406XAS+TKiPKwWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772277809; c=relaxed/simple;
	bh=Ls9Pq9hUIqEe6xD9d0PXw3VoiEEfRlOXlemOfB1MxqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AWNeehytTfGD4Bimjig7IIpcyeRNZ3yeoJo00hc8Kg66Blp3hByfEKDlOQnBP71l76lBeWLm2LA34mY31Wi1tetzTJ40aq1SaIimOJ7cgJdm7Ifa3gn9j0UWshTf02u0VnOOaKjdaLuqZ5qPhveBnVaAcbFtvF20FqYP24q5nvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGbphPbT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGbphPbT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0113AC116D0;
	Sat, 28 Feb 2026 11:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772277808;
	bh=Ls9Pq9hUIqEe6xD9d0PXw3VoiEEfRlOXlemOfB1MxqE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oGbphPbTclCJxctrQSS9vvXkBcKa5yfK48hNjgI9hedFWN4ooIx4ElyunFzuUTYEq
	 6VJem7+ZnEbd82rnaT7Hq12nn8lw/rLZcoOugL98mMdJCagWS/xXwk9UHfberzfnpw
	 om6MM29n6pVY11zgR8zq0j18oLZ9wtbhDIqH8h2PbZtWSEC33e3jt56U6mATB5Fvv1
	 p2OUIJxC/fFAWCI4amw5Ml4dzCsXSYP+8WBxqog5E7jBHnNH9bUbnMtseUTCKg2ZKI
	 GbZ7awukIefvcQ/RTu9UNiV7F476hOsMhxvnQR7MFVZKV890vqGeSV0iZ6yNwcBaek
	 A2TxVIDbnpoFA==
Message-ID: <a8ebfb42-52ae-4f4a-ac34-f33d82f11a31@kernel.org>
Date: Sat, 28 Feb 2026 12:23:23 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Input: add initial support for Goodix GTX8
 touchscreen ICs
To: Aelin Reidel <aelin@mainlining.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Henrik Rydberg <rydberg@bitmath.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux@mainlining.org,
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 Piyush Raj Chouhan <pc1598@mainlining.org>,
 Alexander Koskovich <AKoskovich@pm.me>
References: <20260228-gtx8-v2-0-3a408c365f6c@mainlining.org>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20260228-gtx8-v2-0-3a408c365f6c@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 28-Feb-26 02:56, Aelin Reidel wrote:
> These ICs support SPI and I2C interfaces, up to 10 finger touch, stylus
> and gesture events.
> 
> This driver is derived from the Goodix gtx8_driver_linux available at
> [1] and only supports the GT9886 and GT9896 ICs present in the Xiaomi
> Mi 9T and Xiaomi Redmi Note 10 Pro smartphones.
> 
> The current implementation only supports Normandy and Yellowstone type
> ICs, aka only GT9886 and GT9896. It is also limited to I2C only, since I
> don't have a device with GTX8 over SPI at hand. Adding support for SPI
> should be fairly easy in the future, since the code uses a regmap.
> 
> Support for advanced features like:
> - Firmware updates
> - Stylus events
> - Gesture events
> - Nanjing IC support
> is not included in current version.
> 
> The current support requires a previously flashed firmware to be
> present.
> 
> As I did not have access to datasheets for these ICs, I extracted the
> addresses from a couple of config files using a small tool [2]. The
> addresses are identical for the same IC families in all configs I
> observed, however not all of them make sense and I stubbed out firmware
> request support due to this.
> 
> I've taken a lot of inspiration from the goodix_berlin driver, but the 
> Berlin and GTX8 series of touchscreen ICs differ quite a bit. The driver 
> architecture is the same overall, i.e. the power-up sequence and general 
> concepts are the mostly same, but it is very clear that they are 
> different generations when looking at it in more detail.

Right, this answers my main question about this driver which was:
"why another goodix driver?" (this would be the third one).

I've also compared this driver with the original goodix.c touchscreen
driver (which I know well) and the protocol is somewhat closer
to the original goodix.c driver then it is to goodix_berlin, but still
different enough that having a separate driver is the best option IMHO.

...

> From what I can tell, the evolution seems to be:
> Normandy -> Yellowstone -> Berlin
> since Normandy and Yellowstone are already quite different (especially 
> with the way checksums work) and Yellowstone has a couple of things 
> (checksum, fw_version) that appear similar to Berlin series ICs.

You forgot the original goodix.c driver, adding that it seems
the evolution is:

GTx1/GTx2/GTx6 -> Normandy -> Yellowstone -> Berlin

With GTx1/GTx2/GTx6 having no checksum at all (and 16 bit
registers) and some of the original GTx1/GTx2/GTx6 don't have
nvram for the firmware, so Linux must upload firmware every boot.

Anyways I agree that these are different enough from the existing
goodix and goodix_berlin drivers, so based on that (and only on that):

Acked-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Regards,

Hans



