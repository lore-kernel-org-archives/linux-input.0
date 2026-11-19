Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795123418;
	b=lkPP2tOjFot14rMUtThGpTNemvE7CA8p2IWvQHhqNRun5wOOpm7ogYKAtV/s6aBxtowA
	 ru1rK8E3YUKW+t2rRmpzkXP6Ebxp5y0c8F+lo7goweAbVZHxReMWF5DSNJ26HxtcShlHt
	 co8DQUNCTLpYSRpqtftmR10pteW/C5FdtmN1t/xk9CoKyUBRmH3kpelcQcWwtUgNrReGT
	 //S4dZOk+N4IZBIdlb210eu56mWPmtoFtkF8jvtwAY+RypUoDQKYEZ1/okQUnY0Rv4Pqv
	 5a1d/KgOF1viBK5k0kiUkZ+37EgUkiu3mlw26xEsJ1XC60t2NU3Ivo1VGN8mxH59Q6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795123418;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=9hC298kvaNwIoqRFGSmPMN0PmbB2jrTkYIuTQfk1QsQ=;
	b=1Ni0HQAhHX3HwM4oLTAuhKe0Ffg8xZUnOCKk+W3hP2Kiex+buumPgmyq3UZHqfEt2flx
	 2Wf47v4TPYO2CwR50p2KjHULaJNWbr4z8RThAMnII3zLDmGXOe2TFLLoYvM3egZge/9nG
	 2oUopry1wAMlbhc9xRtWiPGDYZhqsmzNCtn/LBJM1P8QHZgVbuj6Qsdz/4ig/wZ8unoa9
	 SfaYLiIn2Ev1yjNPwP2l7VycX0AjINKfmWA3eIFDR/SuAJiJtoMTOk9HRKMzNrkcH5716
	 w+eqDxMw9867Sg+6go8KQ7Tl9gol/pYCsope2+qq3yOptbWvxElfouw8JOAcgQEKH0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kavndllo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5178E606A324;
	Thu, 19 Nov 2026 21:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kavndllo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5740E1F000C0;
	Thu, 19 Nov 2026 21:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795123418;
	bh=9hC298kvaNwIoqRFGSmPMN0PmbB2jrTkYIuTQfk1QsQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=kavndllokLSJnNhobZsxY4Sj6r/i7fAOnUuI5wEoyw6al+Xn0tn0o5k4AG69AGyMR
	 3RnAejUSeVn2aTnkR4ZLY81/NQbabiwy1jJys/rcLMM/t0uXdoL8FIX6jlnMvnH0r2
	 uPFr3fiqRGsQ+keMxpfNij9FmCv0+YTHv/hNtx53WhK2Zighd16HvZjJPr2JadKyPZ
	 Db0De2h4Qxo00aEmCJhASntRqEqRdB4MqwC9EMBUKQesFvLpYZl58tHoW5/dnxsvZA
	 nMbWx1ziiBqOemVyEMA8jsq/0cbvkhHxy5YW5bItjYrnD889KVjl4zoE5rQ01tWVhz
	 /g+2+7y2efIlg==
Date: Thu, 19 Nov 2026 22:23:35 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Jianjun Lang <jianjun.lang@ntu.edu.sg>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, David Glushkov <david.glushkov@sntiq.com>
Subject: Re: [PATCH] HID: steelseries: Add MSI Raider A18 HX A7VHG to RGB
 DMI table
In-Reply-To: <20261103-b4-a7vhg-dmi-v1-1-f57c90da16a9@ntu.edu.sg>
Message-ID: <81n25q38-45oq-3q6q-prq3-244qo78n15o9@xreary.bet>
References: <20261103-b4-a7vhg-dmi-v1-1-f57c90da16a9@ntu.edu.sg>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 3 Nov 2026, Jianjun Lang via B4 Relay wrote:

> From: Jianjun Lang <jianjun.lang@ntu.edu.sg>
> 
> The MSI Raider A18 HX A7VHG (board MS-182K) uses the same internal
> SteelSeries KLC (1038:1122) and ALC (1038:1161) RGB controllers as the
> A9WJG, with the same 524-byte feature report layout and the same ALC
> LED IDs (0x00-0x02 lightbar segments, 0x03 lid logo).
> 
> Add it to the DMI allow-list so the keyboard backlight and lightbar
> LED class devices are registered on this model as well.
> 
> Tested on MSI Raider A18 HX A7VHG (BIOS E182KAMS.10D). Both devices
> bind on interface 0 and create steelseries::kbd_backlight and
> steelseries::lightbar. Writing multi_intensity and brightness changes
> the keyboard, lightbar and logo colors and brightness as expected.
> 
> Signed-off-by: Jianjun Lang <jianjun.lang@ntu.edu.sg>
> ---
> This extends the MSI KLC/ALC RGB support added for the Raider A18 HX
> A9WJG to the A7VHG variant, which uses the same controllers and
> protocol.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

