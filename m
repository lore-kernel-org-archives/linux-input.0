Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCCC2C21F7;
	Fri, 11 Sep 2026 14:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789136627; cv=none; b=krrAwhZX8kL/oZL7E4sUQfAGUIbHijTlV3I1OTWx3G2tF+52AoaV0stNoXxwI3JdRtvSfSUlk6cg2PUOQXTjpaYsK2tuwSqAJGqdQJgaC/KbiAGtLM6UoWhIrQmhOy1yLSd/gZ3X5eWI2vBnvUN1ytnj4RR8Fkw5Tkcb4EEo6i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789136627; c=relaxed/simple;
	bh=V2ZMJLNfXgR8cXIw/7k85WrPHgLA6hgqlErb2u9P+hw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sZgKaG2que9P90FvgRF+6MU+Cje1meTihU7ss2NNah27xHu2F9Wqj7+bfP3MQZ+ueQnO0PyevvR8maqaJUaqu4yi6zgAXZFs6KIeaVkePpNNNfjEdrDe21obzfo/gTNqUUuprIVmQZunZMLGPHwEeWdNTmrsZdKHL2tu57CreLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1bHyCoc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1bHyCoc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EDEF1F000FF;
	Fri, 11 Sep 2026 14:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789136626;
	bh=iW97g2oezRZy8jsjnd8R+bBsXBFnGkQfypuXbhNGoVc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=W1bHyCocKbaHvwUiKbObR/J92sOWhN2yzK9E8ihSeSVqoMe6pbhMHsCvvPgz3DNP+
	 YdNfZuVl26jMNiUCsBxHV4+2Kf80zb3yoFf59JsTEnNvJfCRY63GE0yHvCcd5aCR8a
	 ZNU+durDqxy8grWqWz0uqmSj1d/YGplOUnPOjeV6zcfFRsbhx7GjNhGR30OkPnEf3m
	 FEOCXzyiBtVAVYn6En1FGqwDVD2FKeNci2Makn6k00Y8A//eYzhXeybG4Np9IDjILu
	 R14q7ygcpcZJIz6PBZ1KWfmrzqo1hKcITnG0yYf1Imraqn1UsgxGITyPfbUcr9XKqR
	 VIjQGq/Z+vSiA==
Date: Fri, 11 Sep 2026 16:23:43 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Aiman Najjar <aiman.najjar@hurranet.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    "Daniel J. Ogorchock" <djogorchock@gmail.com>, 
    Hector Zelaya <hector@hectorzelaya.dev>, 
    Joshua Peisach <jpeisach@ubuntu.com>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: nintendo: add support for PDP Afterglow
 controller
In-Reply-To: <20260815-hid-nintendo-driver-pdp-v1-1-0f5917acb89c@hurranet.com>
Message-ID: <n6n09o42-2669-7p0r-7794-6r365o03p330@xreary.bet>
References: <20260815-hid-nintendo-driver-pdp-v1-1-0f5917acb89c@hurranet.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 15 Aug 2026, Aiman Najjar wrote:

> Add support for the PDP Afterglow (0e6f:018c), a licensed pro controller.
> 
> Commit 9146038120a6 ("HID: nintendo: add support for HORI Wireless Switch
> Pad") applied X/Y button swap to all Licensed Pro controllers which caused
> the North/West buttons to come up swapped for PDP Afterflow. The swapped
> layout seems to be specific to HORI, so restrict the quirk to HORI devices
> and use the standard mapping for all other licensed pro controllers.
> 
> Fixes: 9146038120a6 ("HID: nintendo: add support for HORI Wireless Switch Pad")
> Link: https://lore.kernel.org/all/20260527-hori-support-v2-1-195c2f832112@hectorzelaya.dev/
> Signed-off-by: Aiman Najjar <aiman.najjar@hurranet.com>
> ---
> Tested on PDP Afterglow.
> 
> Tested over Bluetooth on NixOS kernel 7.1.3 and QEMU kernel 7.2.0-rc2:
>  - All 14 buttons map correctly
>  - Player LED sets on connect
>  - Sticks report correctly with default calibration
>  - IMU/gyro data streams at consistent 15ms avg delta
>  - D-pad reports on ABS_HAT0X/HAT0Y
> 
> Device information:
>   Bluetooth name: Lic Pro Controller
>   Bluetooth HID:  0005:0E6F:018C
> ---
>  drivers/hid/hid-ids.h      |  1 +
>  drivers/hid/hid-nintendo.c | 14 ++++++++------
>  2 files changed, 9 insertions(+), 6 deletions(-)

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

