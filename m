Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EFF3368BA;
	Wed,  1 Jul 2026 00:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782864031; cv=none; b=kAmhrsAfXa2uhnckYz5DNAchoVcC3xbZzLhkn6nxhmDPK6bBDWEXxfUFe0ZDA47Heq8kqNbOLRsdcUc7xTbVtpsJSkrIQ/06q+SfbotZ/FDDfkYp52qMRAYdU404cIIPotnJqgaDhpmxqbC07i8hpbnr7Ey1epy98vAZl6tegTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782864031; c=relaxed/simple;
	bh=aDd6xnbNXHwGM13+mfbTZqc1/QPJzS5RFcPsKU4bTP0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ON6lalgqWpigkeE+34eEtYwKoVpDjGEUwiMsQRde93WjmswqazBCrM1J4s+KxX+dd3BGVI0ohp0yBXBq93Bof4kdff6g57vS78uAfBt91dTUu0HIs3A7fCNN8d+LrSdz6mvMCeyUjLAAkOjm00+L39weykoIsAzKOversISGP0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2aridIB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2aridIB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A0A91F000E9;
	Wed,  1 Jul 2026 00:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782864029;
	bh=/q/M4iftPwXwOXkuB442nTPnYH/p2eAZGJdhwDTouz8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=D2aridIB3ZeNJJR3QUrliEur8twz15o6NHQ3r4VfEqZ4ETR7iR4Pcmpw5QOls9KWg
	 ltdTxZYZRZUW7G04XshPf1tQrDKzMzGzkUSCpoRrq01HHBFl6KI1ZNg+A0EihUDQ85
	 Nn9/j5cFtBd93A8542gMmvRvLNPhVlsZlGm/unA5oSqjRfx0Sssw6SyErZ08s5sS0r
	 wdXiV9NryfEhhimef0etZQj0seb/z8TTI9ZjY0OFngTzUGWG5UiWq5EZlaVgH5tvzo
	 7uagUhv9ei4cRcZc7VrB0c2q7hSjQx6n5p1nbz8XvvSHDY8gNuo7YLSf228yTJeONP
	 M3PWol6eIbbXA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939E5393A963;
	Wed,  1 Jul 2026 00:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 00/13] treewide: replace linux/gpio.h
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178286401313.341356.16335263979724856348.git-patchwork-notify@kernel.org>
Date: Wed, 01 Jul 2026 00:00:13 +0000
References: <20260629132633.1300009-1-arnd@kernel.org>
In-Reply-To: <20260629132633.1300009-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-gpio@vger.kernel.org, arnd@arndb.de, brgl@kernel.org,
 andrew@lunn.ch, sebastian.hesselbarth@gmail.com, gregory.clement@bootlin.com,
 Frank.Li@nxp.com, robert.jarzmik@free.fr, krzk@kernel.org,
 gerg@linux-m68k.org, tsbogend@alpha.franken.de, hauke@hauke-m.de,
 zajec5@gmail.com, ysato@users.sourceforge.jp, glaubitz@physik.fu-berlin.de,
 linusw@kernel.org, dmitry.torokhov@gmail.com, kuba@kernel.org,
 pabeni@redhat.com, linux@dominikbrodowski.net, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 patches@opensource.cirrus.com, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-input@vger.kernel.org, linux-media@vger.kernel.org,
 netdev@vger.kernel.org, linux-sunxi@lists.linux.dev,
 linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-sound@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Jun 2026 15:26:20 +0200 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The linux/gpio.h header used to be the global definition for the gpio
> interfaces, with 1100 users back in linux-3.17. In linux-7.2, only about
> 130 of those remain, so this series cleans out the rest.
> 
> In each subsystem, we can replace the header either with
> linux/gpio/consumer.h for users of the modern gpio descriptor interface,
> or linux/gpio/legacy.h for the few remaining users of the old number
> based interface.
> 
> [...]

Here is the summary with links:
  - [01/13] ARM: replace linux/gpio.h inclusions
    (no matching commit)
  - [02/13] m68k/coldfire: replace linux/gpio.h inclusions
    (no matching commit)
  - [03/13] mips: replace linux/gpio.h inclusions
    (no matching commit)
  - [04/13] sh: replace linux/gpio.h inclusions
    (no matching commit)
  - [05/13] mfd: replace linux/gpio.h inclusions
    (no matching commit)
  - [06/13,net-next] net: replace linux/gpio.h inclusions
    https://git.kernel.org/netdev/net-next/c/a53d1872f2be
  - [07/13] ASoC: replace linux/gpio.h inclusions
    (no matching commit)
  - [08/13] pcmcia: replace linux/gpio.h inclusions
    (no matching commit)
  - [09/13] phy: replace linux/gpio.h inclusions
    (no matching commit)
  - [10/13] media: replace linux/gpio.h inclusions
    (no matching commit)
  - [11/13] Input: matrix_keyboard - replace linux/gpio.h inclusion
    (no matching commit)
  - [12/13] gpib: gpio: replace linux/gpio.h inclusion
    (no matching commit)
  - [13/13] gpiolib: remove linux/gpio.h
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


