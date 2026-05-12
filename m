Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB383CDBD0;
	Tue, 12 May 2026 16:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778602620; cv=none; b=oQt9ETJmFEWk5sKaELRpZouW0oVhfs+hGbkNgUGI+9weG9bG2OcfXMK/xJb0AU6VMvo4Q6aDbmEp/eRA1R9wjp/lf7Qjk8bIH5iT3zmiP0r5Pj1Js/rPoN2oAK4mii8zk+ONNMKD7+VGSN8RmViJVtQfN6Qq0b+jDNW6t5mjKNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778602620; c=relaxed/simple;
	bh=gHDAWMpHyHTKSTzONNPbab/Z7G8nlVd8T0Y5EqVrmO8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=S4wAMjAbAY5Jyk/jVSAXtVKnBrvmA9xivisVcMK438ZKyCvpx0otkm0llt0fyTDU1+KQMlIRUgKs8WQrRufTcNV6GLhOfw0kjixP0tdvf9joqST2c2y/+MFijDTtH6juPdXsloItEbtGLYzLGM3O+K7Uwa+03hcHziqpDNRfuAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odT8rMHF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odT8rMHF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB8BC2BCB0;
	Tue, 12 May 2026 16:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778602619;
	bh=gHDAWMpHyHTKSTzONNPbab/Z7G8nlVd8T0Y5EqVrmO8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=odT8rMHFXl6oHFl9os6nHa6dvfCW2BbI4GYEWcK54GGPiRZSz58t9BQtxAmwHPRRm
	 qYliMDMjYyV42Xsh8I9y5BTeWx2hfFzz1evDrCQiWuvq+BlX2R6pLr1QOCiPUd5NyJ
	 H6fxh4pbY5GzGQctAp8uWzv4ykvvVobF62VaD4ptJUgDSCAn+u7POi9tB6VWjydzW/
	 5FxlSllsC3i6IPTjxHx1awXEp6IYuW112f2Dx2bNYgosoi8pKDoJPpQaRsIxxVqqwy
	 K585n+sz5jJQFY49mjYj+7Z8QDtXtwKc9bDm/Cj+rBvilHsqrynTjtGnpcROW+k2kD
	 0Fv+xmAF8gSlA==
Date: Tue, 12 May 2026 18:16:57 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Alain Michaud <alainmichaud@google.com>
cc: bentiss@kernel.org, lains@riseup.net, hadess@hadess.net, ogay@logitech.com, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: logitech-hidpp: Add support for newer Bluetooth
 keyboards
In-Reply-To: <20260512132244.2194556-1-alainmichaud@google.com>
Message-ID: <2697o725-qp83-qs87-o747-nr03q3s485r9@xreary.bet>
References: <20260512132244.2194556-1-alainmichaud@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 12 May 2026, Alain Michaud wrote:

> Add product IDs (PIDs) for several newer Logitech Bluetooth keyboards
> to the hidpp_devices matching table, enabling full HID++ support for
> them.
> 
> The added keyboards are:
> - Logitech Signature K650 & B2B
> - Logitech Pebble Keys 2 K380S
> - Logitech Casa Pop-Up Desk & B2B
> - Logitech Wave Keys & B2B
> - Logitech Signature Slim K950 & B2B
> - Logitech MX Keys S & B2B
> - Logitech Keys-To-Go 2
> - Logitech Pop Icon Keys
> - Logitech MX Keys Mini & B2B
> - Logitech Signature Slim Solar+ K980 B2B
> - Logitech Bluetooth Keyboard K250/K251
> - Logitech Signature Comfort K880 & B2B
> 
> Signed-off-by: Alain Michaud <alainmichaud@google.com>
> Reviewed-by: Olivier Gay <ogay@logitech.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

