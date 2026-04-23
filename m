Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7742BEFF6;
	Thu, 23 Apr 2026 14:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776955894; cv=none; b=NuwqvkCeL1vU42sTAmiOdBXeXzwpn9ZtaICLQuGKRJXsZJm7fKepdINNIayoYPI8IXyQMfwaOuI3pVoj5Prh3cRSNdVjnU5Kgfpc2l89onBI+NQ16V/B8Suav/xkQEo1HOL+Yv8QU66rLZWzMNEAocFxZCRdLQOBw1u0pj/xfpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776955894; c=relaxed/simple;
	bh=8mRkjM6sam1GdGJIiXLLI6wEWQZjkXKEM3iaeCeGlIQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qqEJ6Eu3P2DdebwYiOQYG3JNOw9Ta3ML+avIsc5PN3VJCf8ASRej/mViKWl1neMqnGhFyQ71h7j2RWqHgIAReB/njRjiqldaCFfvaDBG0JZ/KhaV8yDYRiamuQkBvJTFxjxhCTIt9uFIVPccClhbn+YyMfsp0FqbgnOcYIEwf0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=LfATiour; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o3g/DEt3; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="LfATiour";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o3g/DEt3"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 5379AEC0067;
	Thu, 23 Apr 2026 10:51:31 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-02.internal (MEProxy); Thu, 23 Apr 2026 10:51:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1776955891;
	 x=1777042291; bh=bJ4d1WO3HoGEbW97dFBkrOUcLA8Iem6+F+Rj76t5ZeQ=; b=
	LfATiourL5RycngzAR03StJra4+TcYA8J+gP2ZaA+j8UOpPiJRKOXl3d9oOUsUQ8
	0JVER2o0qmXREp3vxyWnAGBDfDbdrnm6QFmFpsx1snYkh92hGE2yhpbfnZn9L3D7
	9/zyO+jlyj1GmUmfodfkWxFFqo1Exu3v8Y1vaPs5dm0wzmjPc6hCdB44YHvu/jUY
	D15rp9casM9LdvtznvalwZ7tg7JCpfZgnIFueEYwbdEMQoeeRodbAOn9w27uTkHN
	U2tOdU0Z+YuGO+8dLmhcYuOXFlEYoBd8CZxtCaxqSyK/INC6DyB8rqpxD1Vzm7cJ
	EJ8t2hcuDfPlbUP73z/NCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776955891; x=
	1777042291; bh=bJ4d1WO3HoGEbW97dFBkrOUcLA8Iem6+F+Rj76t5ZeQ=; b=o
	3g/DEt3rNCU04BJIn0rbHT9GMRdk6PxP7jk9XEPiDTjRNeVXCWqC4ylBa2HFTojX
	rxyWP6RkPpuUX4JsPDYz+Ix2wn4SebOmCH+aAOANq5Oe4dE6dW72TXOnIckOUiSl
	WI7tpRn96nJOTJyrxQatcgSaVUtktaHEONZpVylSO1uXIQwZB6NMAwCmBzFwp8yC
	LNPr9zTazoPkHPVvk/C7RA1sb2giyQNvqLV/de26jhig9LQAwms5kbW0cVbk9l+M
	bxG5DgfsKp/nADWMpfXQqYn52jE9TsEf4yckGKS8faOHtUhunY0Z4vZi5cAi9yCq
	a0BCiavpj5r0xqBxKYgZA==
X-ME-Sender: <xms:8zHqaWeqGA0eQo7ZOjRrKKbiu1PfO2PWdRYH3X9Dryr823FfH3NJ0A>
    <xme:8zHqabDrGwG02tD4GDmFghFDN5eBsxaSTBKg3JMZxe_govNBJp7b8_TDz1jN0gNhp
    sl6u64TFFu1Gt7B7VqYwsB8ghFGtQfKYToNfM6Ws0frrQTIH0WiIr8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeijeeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdforghrkhcu
    rfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrg
    eqnecuggftrfgrthhtvghrnhephfeuvdehteeghedthedtveehuddvjeejgffgieejvdeg
    kefhfeelheekhedvffehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepmhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrgdpnhgs
    pghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvghrrhhorh
    dvjeesghhmrghilhdrtghomhdprhgtphhtthhopegvvhgvnhdrgihusehinhhtvghlrdgt
    ohhmpdhrtghpthhtohepgihinhhpvghnghdrshhunhesihhnthgvlhdrtghomhdprhgtph
    htthhopegsvghnthhishhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjihhkohhs
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvh
    gruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepkhgvrhhnvghlqdhj
    rghnihhtohhrshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuh
    igqdhinhhpuhhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhu
    gidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:8zHqaR8NFYNw7iIPSB_iAy-I7rfuFcR1bAIat0xtH95Gm10ETwEq7A>
    <xmx:8zHqaYxxyeQR92ffnDCFVH_YKJOvFuMbDgnhw08UAmEwBSpBOx2k9A>
    <xmx:8zHqaZr49tbGcoTV_uaMXKI3SR7tg6GKcAIu5mE0rmNLILrkTmcI9g>
    <xmx:8zHqaRqtfP0r0Oy3QkFJCdJc_IcsEm6InXOR7LXYnQwxjZYmzbyRaA>
    <xmx:8zHqafMpBTxCzTq2ByzjLjFlSS7k5J0yV7B6F3YIOIYZeuEEC7ZhkzXa>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E8E282CE3F95; Thu, 23 Apr 2026 10:51:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AywJIOr1D2cJ
Date: Thu, 23 Apr 2026 10:51:10 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Dan Carpenter" <error27@gmail.com>, "Even Xu" <even.xu@intel.com>
Cc: "Xinpeng Sun" <xinpeng.sun@intel.com>, "Jiri Kosina" <jikos@kernel.org>,
 "Benjamin Tissoires" <bentiss@kernel.org>,
 "Srinivas Pandruvada" <srinivas.pandruvada@linux.intel.com>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Message-Id: <7e6c43e6-7896-4504-bc13-5f12025596b1@app.fastmail.com>
In-Reply-To: <aenFyk36rTnrD9s3@stanley.mountain>
References: <aenFyk36rTnrD9s3@stanley.mountain>
Subject: Re: [PATCH] HID: intel-thc-hid: Intel-quickspi: Fix some error codes
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Dan,

On Thu, Apr 23, 2026, at 3:10 AM, Dan Carpenter wrote:
> If we have a partial read that is supposed to be treated as failure but
> in this code we forgot to set the error code.  Return -EINVAL.
>
> Fixes: 9d8d51735a3a ("HID: intel-thc-hid: intel-quickspi: Add HIDSPI 
> protocol implementation")
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---
>  drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git 
> a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c 
> b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
> index 16f780bc879b..cb19057f1191 100644
> --- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
> +++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
> @@ -94,7 +94,7 @@ static int quickspi_get_device_descriptor(struct 
> quickspi_device *qsdev)
>  		dev_err_once(qsdev->dev, "Read DEVICE_DESCRIPTOR failed, ret = 
> %d\n", ret);
>  		dev_err_once(qsdev->dev, "DEVICE_DESCRIPTOR expected len = %u, 
> actual read = %u\n",
>  			     input_len, read_len);
> -		return ret;
> +		return ret ?: -EINVAL;
>  	}
> 
>  	input_rep_type = ((struct input_report_body_header 
> *)read_buf)->input_report_type;
> @@ -318,7 +318,7 @@ int reset_tic(struct quickspi_device *qsdev)
>  		dev_err_once(qsdev->dev, "Read RESET_RESPONSE body failed, ret = 
> %d\n", ret);
>  		dev_err_once(qsdev->dev, "RESET_RESPONSE body expected len = %u, 
> actual = %u\n",
>  			     read_len, actual_read_len);
> -		return ret;
> +		return ret ?: -EINVAL;
>  	}
> 
>  	input_rep_type = FIELD_GET(HIDSPI_IN_REP_BDY_HDR_REP_TYPE, reset_response);
> -- 
> 2.53.0

I think this would be throwing away other possible different return values from thc_tic_pio_read?
You'd be losing the -EINTR,-EBUSY, -ETIMEDOUT conditions that might be useful to the upper layers.

Should that block be split into two separate error conditions?

Mark
