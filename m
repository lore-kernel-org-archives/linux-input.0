Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70BF292B2E;
	Thu, 24 Sep 2026 12:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790251256; cv=none; b=Aw6UgEksPJ8juL6i1qIFKwZ2rNGBY3tTlHCkVqNKwgIGNFxf2plzgjMPlc9Th77DyibBkfIb0wrW0DNoDnkNa/c2t/ny7GNYAZRYjQzo/lKO93aAhYvyfReLVNdaCgsZTMeaWxbGXCuny9oLwtONPNzXGSDYTM8BXK/NtgkiD+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790251256; c=relaxed/simple;
	bh=ocyIUkRejGonrqNNXLNErNChpud8SRd1V8ljDXGQre4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=h3g9z7hdNXz20S+VJbd4Bk0bZhdFbE+/Z1DTYXzDno2FI6v52QsexX3gajpOwYANHlYJvNbcqf5qWPgKmfyF0bbTVaKfbBwo1ePG3lQoM2avah9p6rLeXIHNL9tezhWo8QsqshX+ymoicgImGvTyT4qtRcGpDJttliaHXulhd6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JyIqMTG0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JyIqMTG0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA681F00893;
	Thu, 24 Sep 2026 12:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790251254;
	bh=L8yZ373mum5/nUoW2QrJhJt+T06mJJBXnoxDaavWLrc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=JyIqMTG0c+Qx44TSmFM6uBHznOQz60lST1bfV6ZbhDjC0llBs4dW7dl4EzULPK143
	 lpVL63bcedXvMo9zswn6vGdN7agE+XZBTYbA9x/H+m+3fL5KVn1Ejjmy8HHr/Mafbl
	 A4VwOjQmEqd373jC8MSPyjtDB5ZwbKz2pxjg/fzVt5Tt0/QH6Q8clOAGBWHSUXp+7u
	 EPfH2+qjEOBDD2CocoZRsJsa3MTMOK27j+YRv9nTsh6AInq1ltdsae+oJsjqNqVAUf
	 PF8I1mwmFIQ/mmNoqPFg5dd5V/0gdKKeTzYb8e4EW7er74tZ/0jySxjsvJcm3FADqR
	 x5s+2UX+uCpmg==
From: Lee Jones <lee@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
In-Reply-To: <20260721095654.429346-1-clamor95@gmail.com>
References: <20260721095654.429346-1-clamor95@gmail.com>
Subject: Re: (subset) [PATCH v7 0/6] mfd: cpcap: convert documentation to
 schema and add Mot board support
Message-Id: <179025125217.476152.9697106280920245262.b4-ty@b4>
Date: Thu, 24 Sep 2026 13:00:52 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Tue, 21 Jul 2026 12:56:47 +0300, Svyatoslav Ryhel wrote:
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
> [...]

Applied, thanks!

[2/6] dt-bindings: input: cpcap-pwrbutton: convert to DT schema
      commit: ae30468a4934028adaaf5525f6f7bcda26371607
[3/6] dt-bindings: mfd: motorola-cpcap: convert to DT schema
      commit: 6f58e93a2e2f199df32d963d01ad5e1ec0a96387
[4/6] dt-bindings: mfd: motorola-cpcap: document Mapphone and Mot CPCAP
      commit: e968cfb307587a6a3fe9d591fa92d4f5d57e19a5
[5/6] mfd: motorola-cpcap: diverge configuration per-board
      commit: 4436f6aba79e10e2b447b8a0f874c13964518747
[6/6] mfd: motorola-cpcap: add support for Mot CPCAP composition
      commit: 008fc93904285ec99e3d5dac5fa5d5aaab1e9ff6

--
Lee Jones [李琼斯]

