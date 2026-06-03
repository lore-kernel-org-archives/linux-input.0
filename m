Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A8F472776;
	Wed,  3 Jun 2026 22:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780525309; cv=none; b=PANItH5NSuLYbkDMYx+CGV+Wvik8KMrb2VBlciIWhzkDC6hC/mw5nqxXXZ560BTNPFg4JoW+cs8tr1erFo82Dn+Bi0yfRsqXEMcRzP+06Gbew6cXyrXeRUqNYzk3OkrKsebC/BKv4tS2+HgJ+7GqqcSdpzDuhUGRTsIIwktS/hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780525309; c=relaxed/simple;
	bh=cbcrkyAVo7R7YIrTwCIYoGljOff0/0nntSX8Png87Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0QdAR5rMQQriTq5kIovZ3AWrZVOuZSXBMmv+8ytCdvgZFOwEsRC1oZS0yclYt1jQ0xm0zy/MZ0Sf2Ve7dGyupolSdSCzA9eg6XlFW0goGVGoxkBeQEZ/4gHAJpR3xLRYj71tMr3/+dy0GS0kWwj43xi26p4c9KAwMaaPGXz7Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3GeO6pF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3GeO6pF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B12131F00893;
	Wed,  3 Jun 2026 22:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780525307;
	bh=7ZiwdJjSjUT++FcwvQEJub8dg8X972gmC/QxoFtYMik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=k3GeO6pF8HGEGNPckQC1LsicotRrfZ8rR3azmj32PCdJJi25UETIuUML2Hht2ZgPS
	 LgDOPrcq3YUmSrhnM/6GjnAuiQEhX+URjgP21JQUA+uRj6a8At9wlNZO0TBhjzMfWh
	 Z06ruTT0zhUahfnNGh0LMCT4UqNGE+r4kl/fkmOHUc+uoomDMOKsoKmzbN58jJobKE
	 w6rGUKLwlZ0PvxN29EtFjscE2AHw4hSdainVuv3+Kw0Twh823/ftcD5ZEybLUDBekR
	 rfkf7i/MXw/FYLUwTExMyqgjhathkdaj2eV3BSvESev2uMM/LEqQYspWplk6Rb7Vjs
	 qeRhayafgEQNg==
Date: Wed, 3 Jun 2026 17:21:46 -0500
From: Rob Herring <robh@kernel.org>
To: Akash Sukhavasi <akash.sukhavasi@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>, Lee Jones <lee@kernel.org>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-input@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 0/4] dt-bindings: remove redundant .txt redirect stubs
Message-ID: <20260603222146.GA2285556-robh@kernel.org>
References: <20260603-b4-remove-redirect-stubs-v2-0-c8c19876ab64@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603-b4-remove-redirect-stubs-v2-0-c8c19876ab64@gmail.com>

On Wed, Jun 03, 2026 at 03:42:17PM -0500, Akash Sukhavasi wrote:
> Several .txt files under Documentation/devicetree/bindings/ contain
> only a redirect notice pointing to a .yaml schema with the same base
> filename in the same directory. These stubs were useful during the
> .txt to .yaml transition but are now redundant, since the .yaml is
> discoverable by name. Meanwhile, other documentation still references
> some of these stubs, forcing readers through an unnecessary extra hop
> to reach the actual schema.
> 
> This series removes four such stubs and updates all remaining
> cross-references to point directly to the .yaml schemas.
> 
> Other redirect stubs in the tree were evaluated and intentionally
> kept:
> 
>  - Stubs pointing to .yaml files with different names (e.g.,
>    spi-bus.txt -> spi-controller.yaml) serve as breadcrumbs for
>    the renamed schema.
> 
>  - Stubs pointing to multiple .yaml files (e.g., nvmem.txt ->
>    nvmem.yaml and nvmem-consumer.yaml) convey that the content
>    was split.
> 
>  - Stubs pointing to .yaml files in a different directory (e.g.,
>    reset/st,stm32-rcc.txt -> clock/st,stm32-rcc.yaml) serve as
>    cross-directory pointers.
> 
> Two additional same-name, same-directory stubs (leds/common.txt,
> regulator/regulator.txt) have significantly more cross references
> and will be addressed in a follow-up series.
> 
> v2:
> - Patch 4/4: corrected commit message (eight references in six files, not
>   eight files), Sashiko review.
>   https://sashiko.dev/#/patchset/20260529052246.4934-1-akash.sukhavasi@gmail.com?part=4
> 
> v1: https://lore.kernel.org/all/20260529052246.4934-1-akash.sukhavasi@gmail.com/
> 
> Patch 1 supersedes my earlier standalone submission:
> https://lore.kernel.org/all/20260523004223.3045-1-akash.sukhavasi@gmail.com/
> 
> Signed-off-by: Akash Sukhavasi <akash.sukhavasi@gmail.com>
> ---
> Akash Sukhavasi (4):
>       dt-bindings: net: remove obsolete mdio.txt
>       dt-bindings: media: remove obsolete rc.txt
>       dt-bindings: net: dsa: remove obsolete dsa.txt
>       dt-bindings: input: remove obsolete matrix-keymap.txt

This goes to 3 different subsystems, so it should be 3 different series. 
No need to resend just for that.

Rob
