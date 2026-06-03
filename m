Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EABF438FEF;
	Wed,  3 Jun 2026 22:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780525237; cv=none; b=m3flSFx1lvvcW9HJxc7BZP50GuSea9xW7VPR35Owcingd+sOxVvhYhU3mm0gKcZkdvcTYzlrzCph7CX4Z0bEkuDRCFK2R+WqgtGtQ6/dNgAInjhCsTPj1YlDdSXlK/DqUXM4Lp/IWP8UshW2dqUqBet9ykjquIkLK8qW4OMOxe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780525237; c=relaxed/simple;
	bh=+tqJ7VvjI0EpIZ4rEOJSSD0tYpFIFV80Tae3omoKZ04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QqitJRqqPWG4L2dGyTpW5Dno9MqDhXIQAFSqA/LZLjfENOstofAMhBkn5UFjaJS88vE9oIzFJPoRUR6ECdUgyZNCxqINReh0j2L8VxfeL7Gk5gtyqYapToLrDadsCzyF85oRCc/MKAwxXipN6PoL4RL4K5+2f+Hp9vdlf3u0Xyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BeAvQ7WQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BeAvQ7WQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A683E1F00893;
	Wed,  3 Jun 2026 22:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780525235;
	bh=JGNHTQ73RJVqb1W0KyxoFGA1Bc+H2MChRkwAq6lU+c8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BeAvQ7WQY/o5EULWLEjuO8FLWOpB3WvIY9XeUH7PumxbW7XSJPDxJWSfdF1A791l4
	 oqDPA0yekJZxdqPprxK4B/EFVYHsNc41fGRSODAtOxZB+anpRYMRitraeCPeXSxs+k
	 VdpAtUQJDJQoAIwHSCczuBWSP6tVnVuk/mfdXyupMAs5MvxauinnqEm9f4eZTlQ2M/
	 PoFH6qHkcp7wTBae4D6iQ1PfQsuzlV9ohOz4XT6pXJvatnHYK69YHkfCTozdZ9HGmd
	 gZcZrbuKqGoqqw3MGOAYEmJNFBAYoeimCL0zjC/DGJ/tp9xJww6y8R1crMRG37fr75
	 aEuoMh31nhfUg==
Date: Wed, 3 Jun 2026 17:20:34 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Akash Sukhavasi <akash.sukhavasi@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-media@vger.kernel.org,
	Thierry Reding <thierry.reding@kernel.org>,
	linux-input@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	linux-tegra@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Hunter <jonathanh@nvidia.com>, Lee Jones <lee@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 3/4] dt-bindings: net: dsa: remove obsolete dsa.txt
Message-ID: <178052523336.2284212.2212106139200660430.robh@kernel.org>
References: <20260603-b4-remove-redirect-stubs-v2-0-c8c19876ab64@gmail.com>
 <20260603-b4-remove-redirect-stubs-v2-3-c8c19876ab64@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603-b4-remove-redirect-stubs-v2-3-c8c19876ab64@gmail.com>


On Wed, 03 Jun 2026 15:42:20 -0500, Akash Sukhavasi wrote:
> dsa.txt has been a redirect to dsa.yaml since commit bce58590d1bd
> ("dt-bindings: net: dsa: Add DSA yaml binding") introduced the .yaml
> schema. The .yaml has the same filename in the same directory, making
> this redirect unnecessary for discoverability.
> 
> Two files still reference dsa.txt, forcing readers through an extra
> hop to reach the .yaml. The stub has not been touched since August
> 2020. Update references in lan9303.txt and
> Documentation/networking/dsa/dsa.rst to point directly to dsa.yaml
> and remove the stub.
> 
> Signed-off-by: Akash Sukhavasi <akash.sukhavasi@gmail.com>
> ---
>  Documentation/devicetree/bindings/net/dsa/dsa.txt     | 4 ----
>  Documentation/devicetree/bindings/net/dsa/lan9303.txt | 2 +-
>  Documentation/networking/dsa/dsa.rst                  | 2 +-
>  3 files changed, 2 insertions(+), 6 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

