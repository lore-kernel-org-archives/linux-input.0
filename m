Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9398339099E;
	Fri,  5 Jun 2026 01:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780623016; cv=none; b=iUhf6qSmimVD0jgqFsSXCqYwN6hX5r5fAJYqDO903FhjwFN7PioK6hEYuy/HgFVBLi453bNkjCXH3DN5L3sGa302DLNpKmQfExi8V0I6281jpl+IXSM8qLc/RoCQdkoxSzSZPYoazXTusp5peL5+oxQr98xkwiP9vvF9zBdiQ+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780623016; c=relaxed/simple;
	bh=KXlwYjqKVSUou60rpLkA1iL5cirORHeMbS0KbckVvy8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nLFBIZXWVkcgLShWDnU/Y3jxBGfciZ5hrwPHys/EIi9UlGA0/gb3Kga8Qaf7q+7p0RHZOORmgII+zWeCVByHdNQcd7yo5LgUiA8KxlQ8g7ahvaMMAivjAlS2x3JiORVxSP0u6hUPPOAfZJUH4cia5y/p/ZVCBtOl0WQM0sBSsEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2XccfvB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2XccfvB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED8AB1F00893;
	Fri,  5 Jun 2026 01:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780623011;
	bh=ehZCtSynk3bTn44G6PMr36RiMYbFetcFDvaiFCTYQUo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=c2XccfvBptzHz55v6NBJeU76o0cvge5jJdtMPa9/lePBC2+4eSf9Ck+7nHbj1/idL
	 SkZB4ajriFpKhqucuZJZsrTGzz/W8T4GAmJ3g809fg+SwkDHRT0ERPQ71H3DyhivHK
	 ahBzevah02Devlifsi/Ixo1HOPZ4n6DsKSAmebn9EbA6JbjCY01uDFOSQ/Em2n7ei3
	 oTtu+6r2F1VcwiHfitR147yOw+9dtBPA8uCZ8SAzCVUWi2Lmq+vWZwtzYU5CWPmVSb
	 FPivH01aaoMCVgbpjeyqvWa4EEFgac6RiFaG4WZw/hqaiZDgDdzVf/tY48Ulc3z82f
	 6pwMmyTrmmzMQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B243930A8A;
	Fri,  5 Jun 2026 01:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/4] dt-bindings: remove redundant .txt redirect stubs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178062301139.3093327.8247260042998931357.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jun 2026 01:30:11 +0000
References: <20260603-b4-remove-redirect-stubs-v2-0-c8c19876ab64@gmail.com>
In-Reply-To: <20260603-b4-remove-redirect-stubs-v2-0-c8c19876ab64@gmail.com>
To: Akash Sukhavasi <akash.sukhavasi@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, mchehab@kernel.org,
 olteanv@gmail.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, dmitry.torokhov@gmail.com,
 thierry.reding@kernel.org, jonathanh@nvidia.com, lee@kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-input@vger.kernel.org,
 linux-tegra@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 03 Jun 2026 15:42:17 -0500 you wrote:
> Several .txt files under Documentation/devicetree/bindings/ contain
> only a redirect notice pointing to a .yaml schema with the same base
> filename in the same directory. These stubs were useful during the
> .txt to .yaml transition but are now redundant, since the .yaml is
> discoverable by name. Meanwhile, other documentation still references
> some of these stubs, forcing readers through an unnecessary extra hop
> to reach the actual schema.
> 
> [...]

Here is the summary with links:
  - [v2,1/4] dt-bindings: net: remove obsolete mdio.txt
    https://git.kernel.org/netdev/net-next/c/ed2b921b542b
  - [v2,2/4] dt-bindings: media: remove obsolete rc.txt
    (no matching commit)
  - [v2,3/4] dt-bindings: net: dsa: remove obsolete dsa.txt
    https://git.kernel.org/netdev/net-next/c/0fbbc19482bd
  - [v2,4/4] dt-bindings: input: remove obsolete matrix-keymap.txt
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


