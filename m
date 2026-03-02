Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E288A430BAA;
	Mon,  2 Mar 2026 01:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772415277; cv=none; b=Sphb2RH1VzB/6OjWLn+9rDn9+P+tJmkrvsB4FrTZAMLYyO9m4VWpBtK41Hhxm1OoBxy7Spx2Vtt+Ur4CQjQp6eSjxgBH43x5UeOO1CxHtnIsMP/WJpFjviZo/LHmHt8RiahgxDsqiX1pVSCHuenlc34NoN0nl+35WsboEP1xSKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772415277; c=relaxed/simple;
	bh=0vWmCoJrQzldWWeztRJY2TIVFKyE+H8Dlc/ptEGiuEU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=HzwDJiu3RZHztqykq0dFTo4+iSs8aSxLCSu9dU0tLYAyFlr+/kwqPoy6q9+NPtvLt/NOE6LWHPzGrBP11i3mBGQjjAm0CQdh95ZcdJ8c9TyY80XmO+uWqdORLI+grZxTOYYBYLSiMlldu2V+xSPiKB3r4WipltjLTDJMp7fvbn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=NNkZkCU/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bH+TOzzH; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="NNkZkCU/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bH+TOzzH"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 39157EC009D;
	Sun,  1 Mar 2026 20:34:35 -0500 (EST)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-02.internal (MEProxy); Sun, 01 Mar 2026 20:34:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1772415275;
	 x=1772501675; bh=h2o6XFufitq9L91ADmN9mLCvCTcKAFQMvDnnllZdt28=; b=
	NNkZkCU/KoHfG2w7sEFA586qdDtoXZLmKhf4mJqI+bqIY8HbysXVIz+QK6tqxZ7Z
	OLrzVktDgEKuMss8fPBASps0e9sWuMm72xqXXZGc5XDc5FbAKxFB3MUK1MNVjVzw
	WuCpG2BHsP/8bUb9rI6o/94X/kFncwP1RkC4i/fGv7fTMAKuafpPthX8IyKL/YyM
	EuKrImDNxtF0lO/ZCnqsMC4ivbNiGRZSFPkfx3gnOUQ22TKWCU2jJkzZQlJ89Oen
	pw+TxvX390hWrtpUxVCZ1Oueuii9xT0ug+r2WBctdNurxEksu/jRQ9kIp0d9jAW0
	Hu+qatPLj85MVIivOvpayg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772415275; x=
	1772501675; bh=h2o6XFufitq9L91ADmN9mLCvCTcKAFQMvDnnllZdt28=; b=b
	H+TOzzH1FNQUJw5lM+5uc77jQOIGPjWg0Gmm20wdyFBOauLmzgfnZuYhLM2gevRe
	TgdKykdjo57EvOdc3SdgEP0P0FBImtr4OzHXMz28srvMP03ohAc8dwVNx9JSWXxh
	XH6ynnzvVyyzNrX+TzYAq5C4LqGOA/BNwgBYotxmu5q6bSODlUVPX11NAl/Kro25
	UjFl9ef0HXwwk0EVAZ2hK6Xlhwh7Nv9l8HRKyyKxOT9cBV4zLbbRleW6u5v2ZWRx
	HaX5pc7tJpzpHy1xoM1RjvihsgiqNZdkZlMuFiZD3EVB9WPYPx6FjqwHpSo3O4yc
	ElA0aCmzgM9VL5cXQDwdg==
X-ME-Sender: <xms:K-mkaeYqZSW-lUk3zt-vfaoXmPDUxdE2yj8K_PM4n7RWmC-wskyHqA>
    <xme:K-mkacO7NKz439snsrGkpZq2gy1madVUVoZ6nzww5QYRPiQGTE3dqZr2_epSK6Xa9
    XJPUPhYY2gcyBcIXHcIyZNoSDRh25Qm1IU0eA4KKEdIOregBypZzlU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheeifeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfofgrrhhk
    ucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtg
    grqeenucggtffrrghtthgvrhhnpeejgeejkeevleeileevhefgteehteetieefgeelleeg
    uddvvedtueevieffkeeugfenucffohhmrghinheplhgvuggptgguvghvrdguvghvnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhpvggrrhhs
    ohhnqdhlvghnohhvohesshhquhgvsggsrdgtrgdpnhgspghrtghpthhtohepjedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtoheptgholhhinhdrihdrkhhinhhgsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepuggvrhgvkhhjohhhnhdrtghlrghrkhesghhmrghilhdrtg
    homhdprhgtphhtthhopegsvghnthhishhssehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehjihhkohhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlhdqjhgrnh
    hithhorhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidq
    ihhnphhuthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqd
    hkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:K-mkafftd4AjmU1FHHL088ad1id8Mu8A_sD8m7Hmh81h_4Nw35d29A>
    <xmx:K-mkaUQ3-ZIBicvjlNyOgpuYhmHgj-SUIM2tvzgzPXpbAzhjxpOR3A>
    <xmx:K-mkaetdAPoSTPyEb4y-MrbAfbLwG2rQft_oJEW1zTzGEeOXM_P_jA>
    <xmx:K-mkadc8FprvDpcZQJxrllER4bMxzjc7QRV_3ScDJNNmrFif4GPJUA>
    <xmx:K-mkaWpHaHWBcVI7dzswjUMaU15HuMFLZQA0tSe0-ADYpMuMWLgxJfTM>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0B9FD2CE0072; Sun,  1 Mar 2026 20:34:35 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Asf2JMYkFHio
Date: Sun, 01 Mar 2026 20:34:14 -0500
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Colin Ian King" <colin.i.king@gmail.com>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
 "Jiri Kosina" <jikos@kernel.org>, "Benjamin Tissoires" <bentiss@kernel.org>,
 linux-input@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <d4369de6-cf80-46a9-b3ae-a80377d5df94@app.fastmail.com>
In-Reply-To: <20260227231606.421263-1-colin.i.king@gmail.com>
References: <20260227231606.421263-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] HID: hid-lenovo-go-s: Fix spelling mistake "configuratiion"
 -> "configuration"
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Feb 27, 2026, at 6:16 PM, Colin Ian King wrote:
> There is a spelling mistake in a dev_err_probe message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/hid/hid-lenovo-go-s.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
> index cacc5bd5ed2b..dbb88492fbba 100644
> --- a/drivers/hid/hid-lenovo-go-s.c
> +++ b/drivers/hid/hid-lenovo-go-s.c
> @@ -1401,7 +1401,7 @@ static int hid_gos_cfg_probe(struct hid_device *hdev,
>  	ret = devm_device_add_group(gos_cdev_rgb.led_cdev.dev, &rgb_attr_group);
>  	if (ret) {
>  		dev_err_probe(&hdev->dev, ret,
> -			      "Failed to create RGB configuratiion attributes\n");
> +			      "Failed to create RGB configuration attributes\n");
>  		return ret;
>  	}
> 
> -- 
> 2.51.0

Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
