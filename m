Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6C744102A;
	Wed,  3 Jun 2026 22:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780525208; cv=none; b=sXtOTG8FXL3qN+QTIr4XRuVNiRZpF/reVXshj4ogBld8qe1OwifFertxwOOTQBu0p00Y3E9DRCze7ncFtE6cIwiJnzXlnSmPtS6mrXqFeeWeASWyBy9cEPmw/SQLqeRks4g8OLT+7bghMrjvooB4IO8IDz9fYKozlBijUf13uTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780525208; c=relaxed/simple;
	bh=KIPD2k4KC841fZrtnLM0e3w75FpgOpVojJjT05J4mw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIcBJqSO1RddINJjHNYar9uo9ozZ0pMQLisUog833BdWDL46fARglOUCjQyZr0757ZxPokTO0sA1D0QqMUcjFXqpD1EV0aoQLMI9aHdzk7fN9/LHim+SHJWCMoT8J9ANMPkV/rv8MVsng3m+Rwlj3yoZelXPXdEZxubiRWP8Y3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9gQ/xod; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9gQ/xod"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A38F21F00893;
	Wed,  3 Jun 2026 22:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780525206;
	bh=v8sHDp4ONRrp+Yvm4SPIIbT9oKkONNFZofdrX7Tp+oY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R9gQ/xodrJUI1h4vSNfSeWebqK1i1UeRekDQpBvmQOGXqpTdKBXi7WiJeFmuublS4
	 AtmN19IRbF9/IgZMylKffAef3HOJ/b98eCqn0bYLSwr4ZJt6KBesSpxaKj6vO89OdZ
	 xl2tlaj4p1RFhrVL0DJtok6K1UGMy6jVMQBgAjOcM6Bi0IqgypRnhTHbuUZT+4WZH6
	 F/j7RVkUnJ/WaqMp/NygcPDIalRJDT71CcLIAlcBfECrEgh2n+kE7beQWM9j2t6hnw
	 9f81hZGzZQTS3NVh4ljltou7wn3xUqAHXQK5OmezEi9t01tF/oKiso+exCqgNBLfRO
	 5o2HfXLPcbmaA==
Date: Wed, 3 Jun 2026 17:20:05 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Akash Sukhavasi <akash.sukhavasi@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Eric Dumazet <edumazet@google.com>, devicetree@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>, linux-doc@vger.kernel.org,
	netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Thierry Reding <thierry.reding@kernel.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: media: remove obsolete rc.txt
Message-ID: <178052520503.2279647.12293343206224505400.robh@kernel.org>
References: <20260603-b4-remove-redirect-stubs-v2-0-c8c19876ab64@gmail.com>
 <20260603-b4-remove-redirect-stubs-v2-2-c8c19876ab64@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603-b4-remove-redirect-stubs-v2-2-c8c19876ab64@gmail.com>


On Wed, 03 Jun 2026 15:42:19 -0500, Akash Sukhavasi wrote:
> rc.txt has been a single-line redirect to rc.yaml since
> commit 7c31b9d67342 ("media: dt-bindings: media: Add YAML schemas for
> the generic RC bindings"), which introduced the .yaml schema and
> reduced the .txt to a stub in the same change. The .yaml has the same
> filename in the same directory, making this redirect unnecessary
> for discoverability.
> 
> One file still references rc.txt, forcing readers through an extra
> hop to reach the .yaml. The stub has not been touched since August
> 2019. Update the reference in hix5hd2-ir.txt to point directly to
> rc.yaml and remove the stub.
> 
> Signed-off-by: Akash Sukhavasi <akash.sukhavasi@gmail.com>
> ---
>  Documentation/devicetree/bindings/media/hix5hd2-ir.txt | 2 +-
>  Documentation/devicetree/bindings/media/rc.txt         | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

