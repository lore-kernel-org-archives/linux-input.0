Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE2B375AAB;
	Fri, 20 Mar 2026 08:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773996536; cv=none; b=l7wcpqelfA+v2FDOIqc//D8HPPA4i4xvDOlVWO/KvRnNAKkqhi6y72LrHKITubRS3F0ugFqpV6/oalcO1eTzq/dWmx1gCMvFqXV7dCld1leWYgLvW1JtBfGFPcvObUh24p3pMIkbRqNuSuNP5mYhLyRZRvw6CxaO+BhVurMxs6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773996536; c=relaxed/simple;
	bh=CcWtuwy5d105Ga+h47FeGEGluN12EFYgVHYVFCjj1es=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=DN1ZaC3tz+3MFXvs7Z1CwQMyMqK0pEgW99GMTYtnOxkYP2VcegqApmrAcqEOvpHbGQTMkxjcIRMPeAXZU/0aXs2y3IqKe8sSCzVklVADJl22H7LQMVdZG2pTwLxl9EO563qExiAmhhgiB4+lqeauuNxi+eqJ0lYWmO156cVeucA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readahead.eu; spf=pass smtp.mailfrom=readahead.eu; dkim=pass (2048-bit key) header.d=readahead.eu header.i=@readahead.eu header.b=jZESYtCh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=falCgqNv; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readahead.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=readahead.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readahead.eu header.i=@readahead.eu header.b="jZESYtCh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="falCgqNv"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id C405FEC01C2;
	Fri, 20 Mar 2026 04:48:53 -0400 (EDT)
Received: from phl-imap-18 ([10.202.2.89])
  by phl-compute-12.internal (MEProxy); Fri, 20 Mar 2026 04:48:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=readahead.eu; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773996533;
	 x=1774082933; bh=gfkGiv5jSDsOg8yuhwOGC9hA4cOClMMXL0KFYL7anlM=; b=
	jZESYtChwJx5u6h9SJIUfJf5UNRbiTU/PaX+0SJZytXtt1IpTcg69pv58PgWYtNo
	pd3WOw5hTF4B/F5HIaiQ9eEOQWN4l1D0yvbCAaPuKVkqyVoKczANzzhI77m/Yhy0
	WDPp7bzuTrye0UlxGKcjbT/KE+XTJ2Hi+RFzl6B3L5c9xuA9MoS5Ku5laY6yhB7r
	/84qnu89ezR0kSqVjH9WeBEiId+AgGFD0IvcPhoWJ0Zci/Mxghu+MIYdLJZcKGbY
	2m27sBfRDbPsxq95SCeGi2hwwVrIVokgZaxB1tzhv4fDffZdcPXGclLjyMLQmzZ4
	VqVM3VX5vNjHT6LEXg7kkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773996533; x=
	1774082933; bh=gfkGiv5jSDsOg8yuhwOGC9hA4cOClMMXL0KFYL7anlM=; b=f
	alCgqNvE6eutfWCKUSFjZJpx8QrDGldAfdq6Pw6CJZIENEgJA3TztnH3ZqPAS32A
	7rkSvbUWiJEaRorBbVkniOTl6jn66JshtUeUQSdHuswSY/VRlYe1QX9vOf7A5HeI
	m7L5MTCkeWH241vI/uLn/wp42o8WLPs3YWHIEYEE5gEt/pAhLr3IYFhOvKDYg00Y
	K2XzNMQ5Uwn/nAxoSstZp9TEmQpEWus/ewaUnrQSdbHfVw6ubSDN70KBiFTW2UX3
	jVbYg9kMrj754AldDNR2Y/FWd36EvRq1ZeMvy9spY9lpA6ZpF/xu/N/ys7LDL49a
	AGZ57rGfICOqnl+tKCYfA==
X-ME-Sender: <xms:9Qm9abHSz8xDBkyHszt4LSGsIgHc6_Yq33gwftdwZwAQFyhuN2MVVw>
    <xme:9Qm9aTKPgoDbAsGYK11tCtQv4T0wUHGeNjGwLginUoq1KZ_q8VpKZATczeHICFrl5
    eQgwZ6_b84lNs5MMdny-LaR0NVbPZDxDt7zLot_98mx6IZtDPg5M0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdelgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfffgrvhhi
    ugcutfhhvghinhhssggvrhhgfdcuoegurghvihgusehrvggruggrhhgvrggurdgvuheqne
    cuggftrfgrthhtvghrnhepgfeftddvgefgtdejvdefvddutefgvdeiuefgudffkeelhfek
    veegieehtddvueegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepuggrvhhiugesrhgvrggurghhvggrugdrvghupdhnsggprhgtphhtthhopeeh
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghnthhishhssehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehjihhkohhssehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehjrdhnvgesphhoshhtvghordhnvghtpdhrtghpthhtoheplhhinhhugidqihhnphhuth
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgv
    lhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:9Qm9abSCYwfCgoBTTrBWMH9mPVtwFloIYKvVbrjueEgUnYu8h1lLYA>
    <xmx:9Qm9aVu4uCZekcouQkYXka0xnY0-1TeNtir9z9FIz8vDNFAQOHTqDA>
    <xmx:9Qm9acaIZabUgGoYSInTqI655hjW1DG5BaZhohykB-ZT_EVdkYiOwQ>
    <xmx:9Qm9abFhFtTZmU89V2X0yrJrvkj7ouQ5mID-XVY0vAmwxle0b2oNOA>
    <xmx:9Qm9aYWGcLTS1tDj4B_CH9H4FLqJW9SCyLeOC_bdjcpyDV9-YwpGqPRv>
Feedback-ID: id2994666:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8A9D615C0090; Fri, 20 Mar 2026 04:48:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AFPiiCyebvRw
Date: Fri, 20 Mar 2026 09:48:33 +0100
From: "David Rheinsberg" <david@readahead.eu>
To: j.ne@posteo.net, "Jiri Kosina" <jikos@kernel.org>,
 "Benjamin Tissoires" <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <ca7114b1-f19f-4627-a370-7835f67120ea@app.fastmail.com>
In-Reply-To: <20260316-wiimod-table-v1-1-c1f91be05137@posteo.net>
References: <20260316-wiimod-table-v1-1-c1f91be05137@posteo.net>
Subject: Re: [PATCH] HID: wiimote: Fix table layout in comment
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

On Mon, Mar 16, 2026, at 3:45 PM, J. Neusch=C3=A4fer via B4 Relay wrote:
> From: "J. Neusch=C3=A4fer" <j.ne@posteo.net>
>
> Some tab characters snuck into the data layout table for turntable
> extensions, which resulted in the table only looking right at a tabstop
> of 4, which is uncommon in the kernel. Change them to the equivalent
> amount of spaces, which should look correct in any editor.
>
> Signed-off-by: J. Neusch=C3=A4fer <j.ne@posteo.net>

Reviewed-by: David Rheinsberg <david@readahead.eu>

This came in via 05086f3db530, which, looking at it, also left some trai=
ling whitespace. Feel free to include those as well.

Thanks a lot!

> ---
>  drivers/hid/hid-wiimote-modules.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/hid/hid-wiimote-modules.c=20
> b/drivers/hid/hid-wiimote-modules.c
> index dbccdfa6391672..d9e1b4313d6465 100644
> --- a/drivers/hid/hid-wiimote-modules.c
> +++ b/drivers/hid/hid-wiimote-modules.c
> @@ -2442,12 +2442,12 @@ static void wiimod_turntable_in_ext(struct=20
> wiimote_data *wdata, const __u8 *ext)
>  	/*=20
>  	 * Byte |  7   |  6  |  5  |  4  |  3  |  2   |  1   |  0     |
>  	 *------+------+-----+-----+-----+-----+------+------+--------+
> -	 *   0  | RTT<4:3>   | 		      	  SX <5:0> 			      |
> -	 *   1  | RTT<2:1>   |				  SY <5:0>			      |
> +	 *   0  | RTT<4:3>   |                SX <5:0>                |
> +	 *   1  | RTT<2:1>   |                SY <5:0>                |
>  	 *------+------+-----+-----+-----+-----+------+------+--------+
>  	 *   2  |RTT<0>|  ED<4:3>  |          CS<3:0>        | RTT<5> |
>  	 *------+------+-----+-----+-----+-----+------+------+--------+
> -	 *   3  |     ED<2:0> 	   | 			 LTT<4:0>			  |
> +	 *   3  |     ED<2:0>      |             LTT<4:0>             |
>  	 *------+------+-----+-----+-----+-----+------+------+--------+
>  	 *   4  |  0   |  0  | LBR |  B- |  0  |  B+  |  RBR | LTT<5> |
>  	 *------+------+-----+-----+-----+-----+------+------+--------+
> @@ -2458,12 +2458,12 @@ static void wiimod_turntable_in_ext(struct=20
> wiimote_data *wdata, const __u8 *ext)
>  	 * With Motion+ enabled, it will look like this:
>  	 * Byte |  8   |  7  |  6  |  5  |  4  |  3   |  2   |  1     |
>  	 *------+------+-----+-----+-----+-----+------+------+--------+
> -	 *   1  | RTT<4:3>   | 		      	  SX <5:1> 		 |	  0   |
> -	 *   2  | RTT<2:1>   |				  SY <5:1>		 |	  0   |
> +	 *   1  | RTT<4:3>   |                SX <5:1>       |    0   |
> +	 *   2  | RTT<2:1>   |                SY <5:1>       |    0   |
>  	 *------+------+-----+-----+-----+-----+------+------+--------+
>  	 *   3  |RTT<0>|  ED<4:3>  |          CS<3:0>        | RTT<5> |
>  	 *------+------+-----+-----+-----+-----+------+------+--------+
> -	 *   4  |     ED<2:0> 	   | 			 LTT<4:0>			  |
> +	 *   4  |     ED<2:0>      |             LTT<4:0>             |
>  	 *------+------+-----+-----+-----+-----+------+------+--------+
>  	 *   5  |  0   |  0  | LBR |  B- |  0  |  B+  | RBR  |  XXXX  |
>  	 *------+------+-----+-----+-----+-----+------+------+--------+
>
> ---
> base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
> change-id: 20260316-wiimod-table-cd9abc0a2a98
>
> Best regards,
> --=20
> J. Neusch=C3=A4fer <j.ne@posteo.net>
