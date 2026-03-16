Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5163C1996;
	Mon, 16 Mar 2026 16:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773676835; cv=none; b=chQ60SlNYEeqx5V1soLCFXZ91hAT5PyTS/Dne0+QJIwEJumEdal+r9GR+VRxnvsJt1lMlFVP4LCWqNN9mTCLbBZ3NvkBsvRHlDckcNmIVMsoP/MSxo3TVwJF79RyWTdgc7NoaFZyTu1b9uBfjqvpzosWviUlaKHpVSe4Bn9xVw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773676835; c=relaxed/simple;
	bh=KSKqfxy8eNqY41RWCDVdOYdEp5lq3JM41DGB1zdM43Y=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bSgAoGFAFE9UHBRJ6mXF366RqSp/dsRlyJDXcmTSjrOiPAbqG7FdE4wXTIkWAsbFRKBaqheybUmaqRoC1ULmrTkOcvSvSOJnRepUhIWAm42/tiCMGQdHmGRYpGgMddDZtdxJ+QXJIVS4cdJ2NFGG/rmbs8P8rymu9aW3DZ9zJoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1g1W9iu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1g1W9iu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9380BC19421;
	Mon, 16 Mar 2026 16:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773676835;
	bh=KSKqfxy8eNqY41RWCDVdOYdEp5lq3JM41DGB1zdM43Y=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=J1g1W9iuokuRh3jnG/rQZBo3DmrSYZaF37xLYX/LCWsGWOs0ToYDwNRHg56d8M6uD
	 F03yI/o/HoMnOt1/j+yn5D6KWP5HsTsm/bT+mvz+m/cA+aodOK68byIeD08vS/5b8u
	 x647/V6DrG3l8/Bv2JbxpS2pzYiRmMeLcvH1RjX62AwYjbySGOxlprdwD9wvfmFJb8
	 n/pkiEJJLnMwgKL838ILmKGtniGMlwPDxTkmjLp+4/xPpv4krMthqonvlKf94K7PsN
	 R+FGUoMiAR/T3XMTKo3mdnSywt79YneR3vhSglXzJ7Y7F5Igpu2wDUTLkH3QiUCKBy
	 xVWU0ZxNfBdtA==
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>
In-Reply-To: <20260309145942.1496072-1-lee@kernel.org>
References: <20260309145942.1496072-1-lee@kernel.org>
Subject: Re: (subset) [RFC v3 1/2] HID: core: Mitigate potential OOB by
 removing bogus memset()
Message-Id: <177367679237.2580085.4886533819894692916.b4-ty@kernel.org>
Date: Mon, 16 Mar 2026 16:59:52 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 09 Mar 2026 14:59:29 +0000, Lee Jones wrote:
> The memset() in hid_report_raw_event() has the good intention of
> clearing out bogus data by zeroing the area from the end of the incoming
> data string to the assumed end of the buffer.  However, as we have
> previously seen, doing so can easily result in OOB reads and writes in
> the subsequent thread of execution.
> 
> The current suggestion from one of the HID maintainers is to remove the
> memset() and simply return if the incoming event buffer size is not
> large enough to fill the associated report.
> 
> [...]

Applied, thanks!

[1/2] HID: core: Mitigate potential OOB by removing bogus memset()
      commit: 0a3fe972a7cb1404f693d6f1711f32bc1d244b1c

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>

