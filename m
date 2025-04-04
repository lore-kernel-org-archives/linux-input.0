Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892FA8F40;
	Fri,  4 Apr 2025 16:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743782599; cv=none; b=gOC1h4XyaPiPaaDvMpiFZXoAJ22rNLBErj/vdxHdvRtpE83CHZldp0Q+MaQdp7tRtyxASvrAmSAGp1TfvMnpV31Dkaht6isQPAUs8sgupQWhBiwheorrJ/ag7q6AJ7pa+A6NZJDK2VvTFsb1Ns7EGSrYiSOUGK2D8U3XdkDuMvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743782599; c=relaxed/simple;
	bh=ZeKtbccKAfskNRA51l4MhLz7OC60VEzIqp0CWNxqyYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HAYq4dl0PZiUHBQ/I5e2XO1OHSTv5uiTXULEsfpO1mFYbSt73N5EO5MDoG/Iba0gTt4eeIwDUO77UJxK7yljxl9DLO/qfb28TtIwcHvrUYtz/7MFfhUgR3/invVbkL5hgG/QcNs73G9uABRp9KYqXxR66BI6zPmZnMEH/a672z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHMecoa0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHMecoa0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C565FC4CEDD;
	Fri,  4 Apr 2025 16:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743782596;
	bh=ZeKtbccKAfskNRA51l4MhLz7OC60VEzIqp0CWNxqyYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dHMecoa01reZDsWeYeRFKDoHvfVdjbITR0YQzM9FrxVMiEBb8fao+AwhSbaSskVdY
	 tn0O84nyZ8Ca2Fex9WdB6BYhFs2swRBStq71ki/yVyokwEFe8WlW4tLe/B4GvwuKkW
	 KXiBsNQb/KGDDsUE2NUCLFgwPjTmc5ROnyzx8piq1J95K4PXQ2/Zzd28jVcs5UON0V
	 T0QAhQ2musAtZT4tcLK3iUVLfqepa3x8C0c+HemmeScwze3y2i1GvvF/zsJhiKb+1X
	 cncYm1oRwoWq06MZTqN+5Mr8AjHFD+nof9k3F4euGkmwVE4n80vfvjQTMjO09HT8Q5
	 WfvYqpksKft6Q==
Date: Fri, 4 Apr 2025 11:03:14 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: devicetree@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Mattijs Korpershoek <mkorpershoek@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-input@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mediatek,mt6779-keypad: Update Mattijs'
 email address
Message-ID: <174378259415.1509225.11221231406789658607.robh@kernel.org>
References: <20250401-mattijs-dts-korg-v1-1-0f8d96bf8a99@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401-mattijs-dts-korg-v1-1-0f8d96bf8a99@kernel.org>


On Tue, 01 Apr 2025 15:30:37 +0200, Mattijs Korpershoek wrote:
> Update Mattijs Korpershoek's email address to @kernel.org.
> 
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> ---
>  Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

