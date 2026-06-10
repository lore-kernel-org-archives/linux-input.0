Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AAE322B8F;
	Wed, 10 Jun 2026 16:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781109126; cv=none; b=Scp8zNPJJH+d7pR8rmRIteA3Rs/ydmPqN226K683UMf/xvJiI8VtgI6OdPgwsa6xlZKoVocp4mljk+oXXQkIFb2drykFicTEtG0rUh2ovr7juW/yOY8+P+x+z505GzOgR1m6cfsCYCEMKNl4Kk6D4o8KdZTcbDAMdaCj/pdFjDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781109126; c=relaxed/simple;
	bh=0hjmq5a2qPxjMXO0q/gIvMfJQsWMhkEBPakNZ6wtbxU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=p9HNBnGBsOd8n+B0ntbulKD1a4hA8c0xi2WnbcQDfrNRtB9jW5phkHlLOSQel3Rto8fuxwapdCtt/CLB+VgdhiOCfb/wUDe3+a6EF6gVqnS7GV3pJOFsDzZ/OpPEja/vAWtghniGhcpIS1rZLD61/QMQznrhNR5UT6RKIyKRkA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0bHncSv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0bHncSv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D755F1F00893;
	Wed, 10 Jun 2026 16:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781109124;
	bh=1V/xQvCdRNw8X1Muow7BUhL70XghFLLlux87NlMpLCk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=R0bHncSv1L2LuS+c5MPmV7vajNcSyRx3fWq/AOrW8ZUowccJGy9qCuOmcZmQgYLT4
	 5quKWmKeuSVS1qTiRPiugThO5iXToUE6+uzHzesXJJ357E8WtCb8dVLtoUImXO1xs4
	 VpIO9r3kdnsLMQ+QJVq2DG3WRU5/kvzgzgqieIboKXYJUvvo8v3hJArY6WGTSTbagc
	 RRNa3qsh0iUoe7efKQsz+FVgpyFzN2x1rDq3uOCMbW5+e9XcnwCB4onoM5U8rbGhZa
	 h+w/NRSYsN8e1r/v6DMvl92oLupCA7UZg/zQLt6gWySg0Mff7w/vhJXoWXAP+RMMER
	 BPNyUvNTbtgLA==
Date: Wed, 10 Jun 2026 18:32:01 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Hector Zelaya <hector@hectorzelaya.dev>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    "Daniel J. Ogorchock" <djogorchock@gmail.com>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, Joshua Peisach <jpeisach@ubuntu.com>
Subject: Re: [PATCH v2] HID: nintendo: add support for HORI Wireless Switch
 Pad
In-Reply-To: <20260527-hori-support-v2-1-195c2f832112@hectorzelaya.dev>
Message-ID: <6r8p081r-n43o-040r-2n79-4547689273s8@xreary.bet>
References: <20260527-hori-support-v2-1-195c2f832112@hectorzelaya.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 27 May 2026, Hector Zelaya wrote:

> Add support for the HORI Wireless Switch Pad (vendor 0x0f0d, product
> 0x00f6), a licensed third-party Nintendo Switch Pro Controller.
> 
> The controller reports controller type 0x06 (vs 0x03 for first-party
> Pro Controllers) and has the following quirks:
> 
>  - SPI flash calibration data is incompatible; use default stick
>    calibration values instead.
>  - X and Y button bits are swapped compared to first-party controllers;
>    add a dedicated button mapping table.
>  - Rumble and IMU enable may timeout (no vibration motor in hardware);
>    treat as non-fatal for licensed controllers.
> 
> Tested over Bluetooth on NixOS with kernel 7.0.5 and 7.0.10:
>  - All 14 buttons map correctly
>  - Player LED sets on connect
>  - Sticks report correctly with default calibration
>  - IMU/gyro data streams at 60Hz
>  - D-pad reports on ABS_HAT0X/HAT0Y
> 
> Device information:
>   Bluetooth name: Lic Pro Controller
>   Bluetooth HID:  0005:0F0D:00F6
> 
> Assisted-by: Kiro:Auto [Amazon Kiro IDE]
> Signed-off-by: Hector Zelaya <hector@hectorzelaya.dev>
> Reviewed-by: Joshua Peisach <jpeisach@ubuntu.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

