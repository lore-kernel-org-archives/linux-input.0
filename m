Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F634430BAA;
	Mon,  2 Mar 2026 01:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772415181; cv=none; b=Qy4854X6sbWj/yTjIAlLIXT+dNTwnEk9YNx1+3joy1knnnSxv7K/ONmntfrtWN3q8XdtXmHIijbBihJpGPU4m/ngPoCYcwuEddKJZ4JyH1SMUWQHGjlfWqxRY18TkXCdA9Q07r2bA002Dl1SvdZO1EO8CKhNDyssklUAKJSNzfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772415181; c=relaxed/simple;
	bh=4P4/RxqZ1LF2gtXpVqMi3k9pd1YaaIOkbHRDqq41FHk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=PP6djf8bfmurHcWsHrMPCFnCnJfvX/8KawKz2jDoGwaag4cehnRDzIg1mnTQNj0ODpY/9eFtXHrXuqDUL4tYV0eXra9AGV1NXVsMtCi8VyuziuXUKelCQk2OU5LifkYOUGqJJdasLz3WWgWY6RE+px4PLZrkNknS46bHm2bNlxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=AX9T+Ie6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=neDGrbNu; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="AX9T+Ie6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="neDGrbNu"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 27BB2EC00AE;
	Sun,  1 Mar 2026 20:32:58 -0500 (EST)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-02.internal (MEProxy); Sun, 01 Mar 2026 20:32:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1772415178;
	 x=1772501578; bh=YTjHHARIhd2VYNbyrwML7HFZeizpUtpAhO6tYKvGf2U=; b=
	AX9T+Ie6gExfAkF6wGV/0oMLrxiUwOUeShbkHHPfBnadJGZdADf4xd9XJhEwir84
	1BjcWVqfF38zp60HLV6RWLlJtWCyRTsZnf0dMgull6UV9AaWQhsr29imryL6KmS1
	lXNlk9UxIY2wSY2ypZzJFpmfoE7aALjVdrH9a6a3DK2ur1mhIF35M5Vhh+1L2SUg
	B1Iu0+UkBj0Kohus5eG2NLgYSd0LL2CPGZ0ugQ2FZuw0kVScmhLK/lZGmsKWQtNN
	rK5OFSVkc0tNUKcBCs64ES6pMdrP0HTFFJ9I2o0xRF00x9nvW5OQeh6jQCClHDUZ
	3I7fB+cSCpxPi70ksJlMbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772415178; x=
	1772501578; bh=YTjHHARIhd2VYNbyrwML7HFZeizpUtpAhO6tYKvGf2U=; b=n
	eDGrbNuQ2sIz7FP8jdF6r08Lwq7pGIDIIXlY3upSE47yDnuwaor1MYJ7kMvnUZtQ
	Q1P60KUxcmDj2QJHSMFkxNUdjgp4XMSffqB+nDSfilclW6LLXqr4DcqLbB5KOkmW
	KPIRT0KWQW0ZGs1FfTOWIlM8lbMD3I65bY6b/oYBW6ozvmVyKA8nTGu2u703eALn
	/ph7uZrS2T7DUaCHFGbEhLVm8leQcsM2CWRX8L6QtXsTo5SltPnrf6YiWk+pnUZ4
	/kuA/OlHVSRiPM3XrxOT/YggrHhY7yJOphpcu+YLG/WQhE/Y0D4V//7dxEVF67z8
	PBL1hre4I4I3yG9tEmRfA==
X-ME-Sender: <xms:yeikaa1am3mYlByKblK915WaMhseyi2-VK8RJUU4_7Skb51FGDQ8-A>
    <xme:yeikaX7dp9PSoCoRJCEvRdq8Sq9D90ovy99F5kKFkfEQKr0z-OK4kWnRWiuatyBzM
    PLB2qavXaW7ZZFLLPhDEUDKMqeM1y7CVZAmJQShvnjguZ7oZjjiTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheeifeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfofgrrhhk
    ucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtg
    grqeenucggtffrrghtthgvrhhnpefhuedvheetgeehtdehtdevheduvdejjefggfeijedv
    geekhfefleehkeehvdffheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrpdhn
    sggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghrvg
    hkjhhohhhnrdgtlhgrrhhksehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhhitghhvghn
    sehishgtrghsrdgrtgdrtghnpdhrtghpthhtohepsggvnhhtihhssheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepjhhikhhosheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqihhnphhuthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:yeikaSaOMHraVHIhQkiEmDF0E75WZ7Xd_89auota1ss_BoKAqYTDnw>
    <xmx:yeikaXquOKT-HLmeU85KNKbxvozedhBnnPf92gOGcVxT4TTHdDK69g>
    <xmx:yeikafPBn2hl1XXX2s6qWnKIPoZzZaM-VjfWvcvfomGsyzlPCiDqWg>
    <xmx:yeikaapU-SjOq2eQVV7Q3l9di_8shVJq91tkC_XMw724SdKEt2WbXQ>
    <xmx:yuikaXum0L2HaiBKqRs5yNgNj9rwpY6pr3l2KDbHUtwHK8HGSCL2FMif>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8262A2CE0072; Sun,  1 Mar 2026 20:32:57 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AN0SM8ysf2Rc
Date: Sun, 01 Mar 2026 20:32:37 -0500
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Chen Ni" <nichen@iscas.ac.cn>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>
Cc: "Jiri Kosina" <jikos@kernel.org>,
 "Benjamin Tissoires" <bentiss@kernel.org>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <d2daaf11-6f70-491a-95c3-cc59e7c78adc@app.fastmail.com>
In-Reply-To: <20260228034343.286005-1-nichen@iscas.ac.cn>
References: <20260228034343.286005-1-nichen@iscas.ac.cn>
Subject: Re: [PATCH] HID: hid-lenovo-go-s: Remove unneeded semicolon
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Feb 27, 2026, at 10:43 PM, Chen Ni wrote:
> Remove unnecessary semicolons reported by Coccinelle/coccicheck and the
> semantic patch at scripts/coccinelle/misc/semicolon.cocci.
>
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  drivers/hid/hid-lenovo-go-s.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-lenovo-go-s.c 
> b/drivers/hid/hid-lenovo-go-s.c
> index cacc5bd5ed2b..d1eb067509f6 100644
> --- a/drivers/hid/hid-lenovo-go-s.c
> +++ b/drivers/hid/hid-lenovo-go-s.c
> @@ -1102,7 +1102,7 @@ static void hid_gos_brightness_set(struct 
> led_classdev *led_cdev,
>  	default:
>  		dev_err(led_cdev->dev, "Failed to write RGB profile: %i\n",
>  			ret);
> -	};
> +	}
>  }
> 
>  #define LEGOS_DEVICE_ATTR_RW(_name, _attrname, _rtype, _group)         
>         \
> -- 
> 2.25.1

Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
