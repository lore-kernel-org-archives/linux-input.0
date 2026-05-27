Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDE63F39E7;
	Wed, 27 May 2026 15:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779894879; cv=none; b=m4hn5kM6ixIJc+lj00uBw5TjhZQKLntPW7iyeiCU8VnRKYQruFL00OVIXUNOI9T9rDPTLki61beq98piUzJrZCCmMWZbfgA+CzOkRFkSLX36SDhyf/ZsXyar1dZkWEmr//4jkojncTtaaEImUQrnd/Lk0NaOsVxkFqTQ+F+8l1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779894879; c=relaxed/simple;
	bh=CkVRDl7JtrPlhtOWqW/TdSHfBpEh9uwbVkQ7lTHRIWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3xi2f7hp2aUBM0VZQCa+oowk58xaEZKQE4kwO11qd8V/QxWNgP0kA6UdLFLAcNfXGb6ioK7M9WMvSQQFcL7LFzLo/LsCkOpBPdipZtTkHP65K9hTTEE+rL6+3WcD8qQacfYKl3ewBfqQOK65ttafQ9wE4lNvcfE/tCLWTqevCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+vEE9UK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+vEE9UK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C621F00ADB;
	Wed, 27 May 2026 15:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779894876;
	bh=mR/wkWNLtDH1OpyIumZcTTvKwUNdOx63byGpFa1s3N0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=b+vEE9UKPVuxsmdYPXO1kQiQ0Y13bXC1BsMgxdYEX9FxlG+zD8wxpCKuBXzkpw1zj
	 gcM6C07g5V2qI9Mx7qc4KW3IMnaLQAXHALW0GUZ/mz+ujRPe5YKIe1RVY2p5yT24JP
	 Mu/9lF75LbF3AWUPURDliyIa9OJtdS+Q97YKY3C9kPdvxOHgRGivMS1deXSk8YVklt
	 /vU8c0u1DyaCtHXVvyTRQEDCtqBQjlNgZV+8DmKRvC/4y6RKLJS7cmC/o6AtupPzVl
	 2vduvxajYFZj8tTFeYq+sV+XHEMVluGiRM9zsO6iM3xhiZJTb0iTkBetg2gWPQ7z4g
	 +gO/UEV0DcQ4w==
Date: Wed, 27 May 2026 16:14:32 +0100
From: Lee Jones <lee@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Pavel Machek <pavel@kernel.org>,
	linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v6 0/6] mfd: cpcap: convert documentation to schema and
 add Mot board support
Message-ID: <20260527151432.GE671544@google.com>
References: <20260520182124.117863-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520182124.117863-1-clamor95@gmail.com>

On Wed, 20 May 2026, Svyatoslav Ryhel wrote:

> The initial goal was only to add support for the CPCAP used in the Mot
> Tegra20 board; however, since the documentation was already partially
> converted, I decided to complete the conversion to schema too.
> 
> The CPCAP regulator, leds, rtc, pwrbutton and core files were converted
> from TXT to YAML while preserving the original structure. Mot board
> compatibility was added to the regulator and core schema. Since these
> were one-line patches, they were not separated into dedicated commits;
> however, the commit message notes this for both cases.
> 
> Finally, the CPCAP MFD was slightly refactored to improve support for
> multiple subcell compositions.

Once you've fixed the DT issues that Rob pointed out, I'll merge the set.

-- 
Lee Jones
