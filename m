Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795452940;
	b=LkhmetUTVhQ7ttFyudiR68N6h3TavTdd2oNFUDJA8tA8/TgTv4beHhzKqISKo9wxhhJu
	 FPF+D+RZIOd/z1paP4cOEmvLmIh6/QHidJymkc9KBineAToyN49D4A91TnjSEJtggIFof
	 dlAv8fP1OaLe8q9JOjpBAdcLTFvpJcNzTaTW9s60pPG8mDFmIYdv3/GykSVfABVQ3DdNQ
	 2v5cyxlIy7TVb+U72ZnAoAeexVQFGC9k4tp1tveOVtuz+BQN/F+D3e20lFxW0aL5kRxUT
	 zQkszVGQHvvdhpZmcp3FvoLdH0fP6yBPOTw4hTmaKmn9gIDWauqcfMDK9Ci6zyX++8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795452940;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=EGhE/gTVVw4lTmadtgJvAW92ULGYgs84JT341auV/S8=;
	b=mAy9Bx453KPeGkDLQFLNfhUJoPFVc232bU21/Ov+SHH4jr9ZH1nFKKs3HS2PEN/YKYqw
	 2uHo0jlkjp9Os7CZt9AyqErO/OVehEpJPHgMCZ4vXlEGrU8pB0J1uTXOyg+YqhLIWWKpl
	 oxm3tDS6tDzVZofy62J16lC4FOq/9yMvwPi2xCalXuid+U1dImoG7h8xxl6CpGmUSbLpa
	 xclPxlER5BaBsAfzTHxSXyNfJiWSj39acgXHxt7dpEFFz/jzUE1SR67FHr3nGv/jp1JiH
	 FKIfs2wgMspHFHo2Z1tdJUvA6IPiKOpwnXo+X4evQKcryMN0M/lC+NJpyOuM9A81HfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=squebb.ca;
	spf=pass smtp.mailfrom=squebb.ca;
	dkim=pass header.d=squebb.ca header.i=@squebb.ca header.a=rsa-sha256 header.s=fm1 header.b=elYMQWEy;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=5ZOoJdC2;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDF3606A31A
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 16:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DDF3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=squebb.ca header.i=@squebb.ca header.a=rsa-sha256 header.s=fm1 header.b=elYMQWEy;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=5ZOoJdC2
Received: from stl-compute-04.internal (stl-compute-04.internal [10.204.2.64])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7E9157A064C
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 11:55:38 -0500 (EST)
Received: from stl-imap-02 ([10.204.2.93])
  by stl-compute-04.internal (MEProxy); Mon, 23 Nov 2026 11:55:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1795452938;
	 x=1795539338; bh=EGhE/gTVVw4lTmadtgJvAW92ULGYgs84JT341auV/S8=; b=
	elYMQWEyfR9KGiach80Lz6BTNBAI7NKE6z/QS9NN+Yqdj7r16vBt77WplqHsn5WS
	lNXzCMyxEoOoeQmDqBg55L6FDg7/PFSeo9T2c2LZdAklZpg6KuyZtNEgg+rWC6Mf
	qYIP7y+/cOyMUHIxVh2Ans7Ooj+j9a/2xg3WcOaRuyOZT4mHtY5aKqm6WGdi0JTL
	Lj4TBT2Sd89hI64JVjd+NwXjXLe+OCRp8mKiZZCLLsB/iBW1GppwWlfzXXd/Eor6
	h669SPIQtM381VUSZPn7VjpAy1VhvIhLPvn1YjdGJjUOMtsKOa1But78XyJgxxJk
	t8UFQe9foZ/bG6+WkHbrBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795452938; x=
	1795539338; bh=EGhE/gTVVw4lTmadtgJvAW92ULGYgs84JT341auV/S8=; b=5
	ZOoJdC2dOLJ1GCWFKw07n9Px/srJBXbLiNmX47rwTwLLiGnxGGvhAMRvJjyoCBij
	wGPvRveDsjNEJ14NgDpsgGKA3B5FRzaK121rPb/4jDxOQnsiygJ8Ov9IBverM/Fk
	gyIxh6TnD0w3fO80SBBdmEEM7+toCIXw/tNHUZdWZzdtyzRu7IFVCceBmtVFbVEi
	OTa05PiT2+KtP3cJJsqzEkpLivEVLZ5OJYs6C2vxu8DPdZ6atZ3EqNIcmHuKdvWS
	Icmz/MXCDH11/bd5MK6wsd5Oo25xUN6ik6HjctNaay/KQSYGzUs5WoqCvMd3ibC2
	iqQF+lN9KFliGskVhz9fA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=squebb.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795452938; d=squebb.ca;
	mf=PG1wZWFyc29uLWxlbm92b0BzcXVlYmIuY2E+;
	rt=PGxpbnV4LWlucHV0QHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:BMgunnN5NfwEeN/nnJEePsRi+sqZpgKYV65meOoc7QLWtv6
	taZX/XB99s5QDboDAu27Ifr1RWfAiav27oOj8KR68uRO25bnPLdKPf6oh1T8isLK
	nxHbc5VskEp1SF9F/ziKUfsWP4I1nl68Dmb/FCT1GfSp0EnozXoF5FE+u/7t8UAY
	9FkfNd1/Nf0/5hbW36NMym8PHZ7DDQECeKkCuqPvLyhEHf51gHrzQ7bjJFFk/vn/
	S0Fo6OySVRkOqjH5yGqOzHcVNs/r0+5FlJ3pgjqZGEuZ0ddmesTR8pX2Hija8F1V
	hHxpW5DdQtp4VteZnh1dgL2x+ZRKFrJBnyh4U3g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:dSW+OMkbNCxjoFjhHHWk3AKHq+umtctzOqH+qKfxWCM=:zy8hdcS9wb/JeVx80DsolvH5LLt3fQ5I2MrylWqERYk=;
X-ME-Sender: <xms:CXAEa64yS_bOTmuYzRo0-dKq2x9LgmdByEiOQv29QjvBJzsWessfEw>
    <xme:CXAEa-u7g-U2QBpVgcIyUdOxKpqWbrncl-DtG2wDWuMSosiRlmxSGsxaUZt9Qj0mJ
    phQWhnYw6mjHHuVo1Ek0629TIuAEqmtQuGCvZfnZoaa_XpkeKPg3cc>
X-ME-Proxy-Cause: dmFkZTFbBuGazmSMDqiQ60nYW9W2/+xzdu6zocl6ygoBHLTNpQgk3r7adcD/4+8L2WH6gJ
    3QLKol2/a47Scu68GFM0mdcYT3MNhEzj2OnRPR5pVAmggcSD1pk0P70Ln6nbact3OzF7mS
    6IhKmqgG7I5++OZAG2xiOOozI4S75KbuNOSiCnHmP6Ho/BqmH2DFSs1pSU5GAUOW6JHus8
    dvzx7osH+KzZmy4pEsqWMlCiaIMSJ1H078Cogm5y4LFUzpeHXJNrVfAA2JGes/sRlK4faz
    ULggQBXPLczjU1jdIK0WxqT382BqksJVqcnzRT2EveYzBeHj10M52FEdq6Fvl9Po9yMAbS
    zrRQFhKJhBvKtF0K5/42QVm09Ru2LjOl0YdKJ16J4B2BcNvVSANmgiPYvXB5eJoo6HcDPd
    hfMw9xX5BZpj8G8TmrJXEBbA35POvBkbknEcZIB/bJimtWgqhsVaHDDbtEV8o5yDN73gjX
    Wfs8+uB7tCAYOaMG0CwePrmiXno1f/+zU938zi/ibItEUGTfeq6MKmjSzBv488/uRfdXdZ
    dWHZxciFQ3M6Or80LI1zv/Oky/5zWyHmRFndSEqAwQJvFzQAwHXXTCuNpUGlaqF1CGaihQ
    Kd5ZzvVlyyAr8hoCxF2YaUZLSgR3MoeaCZzajPzsRhAv4++RjKQM8gExavZw
X-ME-Proxy: <xmx:CnAEa5q5Zv_o0ZdX7B9M99sDeVInArT4Y0Uy3ISennewifLUFRF7Og>
    <xmx:CnAEa-NCKeL7G1CqfvKub-LZacKrxP-FME2oiOHh5l_YlFmKFbIgog>
    <xmx:CnAEa51BC2hHdGuwTDfTn3a2lf8ZhtxiBFp4F2FAf8eWA7rztRRbVw>
    <xmx:CnAEa1CzBhpWI8s1v71DJah79YVv6bBH3JM_2l97GxBtD7cX95EYjA>
    <xmx:CnAEa9OFzMNcrqUc-G_7p0tEC2k5ruWV5ffROZVu9-blu2InH-hp2PPz>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.stl.internal (Postfix, from userid 501)
	id C6C0D2C00085; Mon, 23 Nov 2026 11:55:37 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: ANys3X3_Nnt7
Date: Mon, 23 Nov 2026 11:55:17 -0500
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Ian Rogers" <irogers@google.com>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
 "Jiri Kosina" <jikos@kernel.org>, "Benjamin Tissoires" <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, "Elkin Cruz" <elkin@google.com>
Message-Id: <3e9ccb31-6c81-47a4-a441-e7cfb786b2c5@app.fastmail.com>
In-Reply-To: <20261119170418.1511770-1-irogers@google.com>
References: <20261119170418.1511770-1-irogers@google.com>
Subject: Re: [PATCH] HID: lenovo-go: Fix reset_tx_dongle sysfs attribute to be
 write-only
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Thu, Nov 19, 2026, at 12:04 PM, Ian Rogers wrote:
> reset_tx_dongle is defined with LEGO_DEVICE_ATTR_RO(), whereas all other
> FEATURE_RESET_GAMEPAD attributes in hid-lenovo-go.c (reset_mcu,
> reset_left, and reset_right) use LEGO_DEVICE_ATTR_WO().
>
> Because feature_status_show() has no case for FEATURE_RESET_GAMEPAD
> (which is only handled in feature_status_store()), exposing tx_dongle's
> reset attribute as read-only makes reading it always fail with -EINVAL
> while preventing userspace from writing to it to reset the TX dongle.
>
> Change reset_tx_dongle to LEGO_DEVICE_ATTR_WO().
>
> Found by enabling Clang's -Wswitch-enum on an x86_64 allyesconfig build,
> with AI coding assistant help to audit the warning and prepare the fix.
> Build-tested with Clang; not runtime-tested on Lenovo Legion Go hardware.
>
> Fixes: 82cd9bc866e1 ("HID: hid-lenovo-go: Add Feature Status Attributes")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  drivers/hid/hid-lenovo-go.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
> index 318b1152ff8b..8a2aa2b4825d 100644
> --- a/drivers/hid/hid-lenovo-go.c
> +++ b/drivers/hid/hid-lenovo-go.c
> @@ -1848,7 +1848,7 @@ static struct go_cfg_attr version_gen_tx_dongle = 
> { HARDWARE_GENERATION };
>  LEGO_DEVICE_ATTR_RO(version_gen_tx_dongle, "hardware_generation", 
> TX_DONGLE, version);
> 
>  static struct go_cfg_attr reset_tx_dongle = { FEATURE_RESET_GAMEPAD };
> -LEGO_DEVICE_ATTR_RO(reset_tx_dongle, "reset", TX_DONGLE, feature_status);
> +LEGO_DEVICE_ATTR_WO(reset_tx_dongle, "reset", TX_DONGLE, feature_status);
> 
>  static struct attribute *tx_dongle_attrs[] = {
>  	&dev_attr_reset_tx_dongle.attr,
> -- 
> 2.56.1.708.g77570a6a1d-goog

This looks good to me

Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Mark
