Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C833D668F;
	Mon, 11 May 2026 17:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778521951; cv=none; b=YPvcGysWfGZKiN8X966ckV60ah79ojISGXRhwcQtdA+TvQP+eUu3/mefGYlPZtArXafrP4jkMLbTh/LwZSiMVJeaEeCFuithh7YwVSJrHdt8XCp6GZwij4hTlsbosXBfoiB6V8q+hRDCkjSa1c68a8M1FLxH4UBdzOAKHbkOFWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778521951; c=relaxed/simple;
	bh=P2M9kC7dfCYcl0fH7TVoJfePFD+Xss7dQLkvfpE1sGA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=XvFHH4P+89lBUhLN5Pk1cPiBsLVKVHYH+grXDHDAbWHTVU9Erhl0Rm1BEdKgvhLsUJrnVltumiH2J+GKIp9jem6GjtonaduMIEaJCuj2Ye8G2AXad5nrxwBDOh4MPSrheWypO7TDkav86tbGlhbUcgCRgFUefkjudG9imCGllvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=oL3awfkP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kH8G0SwV; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="oL3awfkP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kH8G0SwV"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 470831D0012F;
	Mon, 11 May 2026 13:52:28 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-02.internal (MEProxy); Mon, 11 May 2026 13:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1778521948;
	 x=1778608348; bh=1ZEzGlSGV3X8L5C6Pp6iwnokD52N6xJudmj7StvWvg8=; b=
	oL3awfkPQ29rPXl2cLrpdyiWjoo1lajssYWKy5RmnXtBXID5OtqCWH93VvilVJ7p
	EvNaNx0ZcSNty5gmDkCGSLse62+kfoNk2XSpCaKYWulKwPF4DOVv7q8ZgoCSvusM
	elrGcjUFRdQOP5STeIJrN7uMRYBePx1aBYROxccoX/S6N68I+XxBrC1qT28rEUm+
	rx841chpqmGSuSfBx7GEYAD6UqT3Or8DwXXAkv5w2CS9Yh8bD1Ba14+zn5mxZPhf
	4V3ZYfROY9EYPHLDbbmZfrEWBBGtxM303YzBSa2SGsIDYLDUO0AHCZJEBc6WAgW3
	fxuXiSZyN83/TuKNJp0vnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778521948; x=
	1778608348; bh=1ZEzGlSGV3X8L5C6Pp6iwnokD52N6xJudmj7StvWvg8=; b=k
	H8G0SwVG/oOikI3X5uOCIsD+is1SNG7eG4EWg7+fAYo2sLPHRNNPsuefV2TkbD5Y
	n4Oi67a7R5OU3mWwxQZjxAyWj63l3crP3lIxiUi10gMgGmbQ9LNVaZa1/vTJzscw
	sYrejDIsh1P7NqPpMllbMRaYPBC1KwVOXn/Yr0NMx8frOUAwsO17iaO7ttliYYCf
	deEUvSHSCiWl/BWEzaWsZwdChoRlW9kF/wO+ywRlt2+l4Yz54oX5+hFTxPKJpsD5
	Mk6aAxDNyGdP+q4U+bLGpsKvLTXfSibyF0LPVrEOhBCxgecly0f2LUmnL/l8iAeO
	JEI/KUA5W0m0UtaRpnQIg==
X-ME-Sender: <xms:WxcCatEAG2-u7Prf6PO8QtrZG0zjIgjfluurWhJDTUGt6kYb1YGdLA>
    <xme:WxcCatLydWvdN8oS5ZVfpXbIKfmW1dpgPZkFnBUs6FjQ2zvp0dZnQHTQU04mm0kCx
    7h7IwOZAGXx5Hf9wdQCmqiTvIc-B1fQEG5qEzU0SFrR6YmZfgpmf9fj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudelheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfofgrrhhk
    ucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtg
    grqeenucggtffrrghtthgvrhhnpefhuedvheetgeehtdehtdevheduvdejjefggfeijedv
    geekhfefleehkeehvdffheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrpdhn
    sggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrhhgpkh
    hinhhgseduieefrdgtohhmpdhrtghpthhtohepuggvrhgvkhhjohhhnhdrtghlrghrkhes
    ghhmrghilhdrtghomhdprhgtphhtthhopegsvghnthhishhssehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehjihhkohhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhinhhpuhhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:WxcCarlNeVMU2CS8Kq4Z0dtws5Ujxwmf92E3KABVRkQLumrTiEv-FA>
    <xmx:WxcCapxsNioyJEtc-eqt3HY3HIrcnUzYY7Yqpnr0pNg8_NB1bpw4KQ>
    <xmx:WxcCagrdmFRTcIoK1reivaR49ftWHzN6KZjMOfT5ApOex9G5NMLiCQ>
    <xmx:WxcCao4ds8sefu1u5_CGaW7XQd59blaeqoA1uqhhTIWLOphsaxFXTg>
    <xmx:XBcCarVuMmAPrrmTcw2S8XwSypHmJ419MeNuVOxr1BpRHK6BOEpXP2t9>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CB9442CE0072; Mon, 11 May 2026 13:52:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A4BKOgYad8Wg
Date: Mon, 11 May 2026 13:52:07 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: Kean <rh_king@163.com>, "Derek J . Clark" <derekjohn.clark@gmail.com>
Cc: "Jiri Kosina" <jikos@kernel.org>,
 "Benjamin Tissoires" <bentiss@kernel.org>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <19802211-e3dd-423d-8c4a-477d64dda187@app.fastmail.com>
In-Reply-To: <20260511132854.1351379-1-rh_king@163.com>
References: <20260511132854.1351379-1-rh_king@163.com>
Subject: Re: [PATCH] HID: lenovo: Fix buffer over-read in X12 Tab raw_event  handler
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, May 11, 2026, at 9:28 AM, Kean wrote:
> In lenovo_raw_event(), the X12 Tab keyboard handler reads a 4-byte
> little-endian value via *(__le32 *)data but only guards the access
> with a size >= 3 check.  If a 3-byte report with ID 0x03 is received,
> the code reads one byte beyond the end of the buffer.
>
> Change the size check to >= 4 to match the actual access width.
>
> Signed-off-by: Kean <rh_king@163.com>
> ---
>  drivers/hid/hid-lenovo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
> index a6b73e03c16b..4686ecb6cfa8 100644
> --- a/drivers/hid/hid-lenovo.c
> +++ b/drivers/hid/hid-lenovo.c
> @@ -793,7 +793,7 @@ static int lenovo_raw_event(struct hid_device *hdev,
>  	 */
>  	if (unlikely((hdev->product == USB_DEVICE_ID_LENOVO_X12_TAB
>  			|| hdev->product == USB_DEVICE_ID_LENOVO_X12_TAB2)
> -			&& size >= 3 && report->id == 0x03))
> +			&& size >= 4 && report->id == 0x03))
>  		return lenovo_raw_event_TP_X12_tab(hdev, le32_to_cpu(*(__le32 *)data));
> 
>  	return 0;
> -- 
> 2.53.0

Looks good to me. Thanks!
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Mark
