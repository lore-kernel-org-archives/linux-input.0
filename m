Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCDB2D7DC1
	for <linux-input@vger.kernel.org>; Fri, 23 Jan 2026 12:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769172876; cv=none; b=IBWZSa0lhaJKamQLESz2uESR8kqEWygOrpRlxAznDY30bECZxDXy6V6CTRGMKk6e4x0/TXBlCTCqlCgD89S3R8jhN0erEQlf1gjUjWG922c8N4xPG7ZGf7qqGZKiGxFRjwZ5v3Z4ETaR+kFIIJPzVwV9/flCCVoMOnzpjKubLOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769172876; c=relaxed/simple;
	bh=MlIKa/PaLkD+jORDC6dESybA5Tb5i9t6RjIWQEzrE9A=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aZXc7F2D2JCeFOLTVCfPxHCdXawRYjmZ58Ps6im4ZC2LIormkjGswDnJA3IeWE1tMCqdHrha/xpZUhSyqhScfWEMEoOd8zH4TbmQUs5RWv+/YaQoT+LlQ8THnWYSzyD72maeEGNFWSiTxykZJFm97RfatW0Mzl+NBMhcA6k81Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkC51W0K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkC51W0K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD046C4CEF1;
	Fri, 23 Jan 2026 12:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769172876;
	bh=MlIKa/PaLkD+jORDC6dESybA5Tb5i9t6RjIWQEzrE9A=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=JkC51W0KVO3H1GvBskGRVAuv072//b2UsPwfbcrB1r++CFhhGplpftjIlQyOZDfBf
	 EbR/U8iUTF4Ep2sW6cuR2KUTf6+5Nifeho/z5skYfHDHUTOOMjI4BNNxFE17f7oNuF
	 Kki7+J+P+mi8bkp1VDNFBoJF2TJOsOym8GyhxYkGP5IVBbIKyFWhOZDl75/7SULXTt
	 wncRkxOyKnKK4OhKuzbf17VwGAcLdh/vdl1ZCePRyfVV1h7gVZfbKMWpH8Zt1V85jV
	 S2wy/ItqK9xcg1zSYtkWhN2siu+V8ZfeVmSz+LZuXKhtVJpZAeUapthlayF4zEqd71
	 Pue823a6KLjcg==
Date: Fri, 23 Jan 2026 13:54:33 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Michael Tretter <m.tretter@pengutronix.de>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    kernel@pengutronix.de, Thorsten Schmelzer <tschmelzer@topcon.com>
Subject: Re: [PATCH] HID: multitouch: add eGalaxTouch EXC3188 support
In-Reply-To: <20260123-egalax-exc3188-v1-1-3f62d06d554d@pengutronix.de>
Message-ID: <2r61n986-q115-rro5-3p10-8159qnp4r29o@xreary.bet>
References: <20260123-egalax-exc3188-v1-1-3f62d06d554d@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 23 Jan 2026, Michael Tretter wrote:

> From: Thorsten Schmelzer <tschmelzer@topcon.com>
> 
> Add support for the for the EXC3188 touchscreen from eGalaxy.
> 
> Signed-off-by: Thorsten Schmelzer <tschmelzer@topcon.com>
> Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

