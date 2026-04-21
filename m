Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E223E3161A4;
	Tue, 21 Apr 2026 18:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776796877; cv=none; b=VeQTQ6DlkfyGtJOHGcr6hd61BrJOlaWVePgrKU60btTMP81qJ8i6Y4wmBHJE/HhewSHPyrUy5FJrJCTPIgyqoosXgfcganqupX+JtZ8Oc8zrHyMcx14BPSOLfsDBdmIqwlGuFYHoHgtRnBU3o4FiOJndBprCuf/OHh/bukLbFDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776796877; c=relaxed/simple;
	bh=WmLDMZY8Fs/D6ms3lQZ51G85APn6XwDQ0bHb7WGQMtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KbL2GBeYCqLajLyMt21E4SDAWzEARKyKDSyVz6sOR53xmUPoUBnLkgobLk4ZCFBjVmmWI95br0AQasPi+PEkP5LFiiuzoMnENdXti6cSkoi0Ypr54ZQwXKIUUJPyoRz5gtvMe0JyWukizX04d0bCq7Szwq0oo5J8Ve0/kojVe5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vl6MydIB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vl6MydIB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A28C2BCB0;
	Tue, 21 Apr 2026 18:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776796876;
	bh=WmLDMZY8Fs/D6ms3lQZ51G85APn6XwDQ0bHb7WGQMtw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vl6MydIBmRXOWI6gO82+W92SbFvzyUct8kx8Fc1L3MUHDcpDnwunrXg44pZuCe3WG
	 NYiXfH6Z3CpegcT9B8ogQqsSJmTgB0XExoldo/cAl+yXzpOxRxMrIH4+w4qAaJ96Jz
	 xmnu8x32Gnkqwy+0CewQKNsjZKtTj9lzejquXJA6JgKXWthx7rLvLptgENQ9pbGn1u
	 2pku7qf5L3AEVa6BJPVYi4hYYTUfF2lXMONiGb4YLwgi7BE6/Co325Qx7N174jSclz
	 +bP4O5IdGecscrkpB93coiehJ10KAxVEWqx5nuSSvnGOcXdCUI8Ml6VwzoBUiMsHhg
	 RaXNfYNTKby0Q==
Date: Tue, 21 Apr 2026 13:41:13 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: phucduc.bui@gmail.com
Cc: linusw@kernel.org, zyw@rock-chips.com, zhangqing@rock-chips.com,
	devicetree@vger.kernel.org, alexandre.belloni@bootlin.com,
	heiko@sntech.de, gene_chen@richtek.com, linux-input@vger.kernel.org,
	nick@shmanahar.org, dmitry.torokhov@gmail.com,
	gregkh@linuxfoundation.org, claudiu.beznea@tuxon.dev,
	linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
	nicolas.ferre@microchip.com, conor+dt@kernel.org,
	krzk+dt@kernel.org, lee@kernel.org
Subject: Re: [PATCH] dt-bindings: Remove the redundant 'type: boolean'
Message-ID: <177679687272.1458365.1328485324673928433.robh@kernel.org>
References: <20260417021858.6582-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417021858.6582-1-phucduc.bui@gmail.com>


On Fri, 17 Apr 2026 09:18:58 +0700, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> The 'wakeup-source' property already has its type defined in the core
> schema. Remove the redundant 'type: boolean' from the binding file to
> clean up the binding files.
> 
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> ---
>  Documentation/devicetree/bindings/input/atmel,maxtouch.yaml | 3 +--
>  Documentation/devicetree/bindings/mfd/rockchip,rk816.yaml   | 3 +--
>  Documentation/devicetree/bindings/usb/richtek,rt1711h.yaml  | 3 +--
>  3 files changed, 3 insertions(+), 6 deletions(-)
> 

Applied, thanks!

