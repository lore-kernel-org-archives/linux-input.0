Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322223D565B
	for <linux-input@vger.kernel.org>; Thu,  6 Aug 2026 08:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786003326; cv=none; b=isrUz7mfKMxa/6rCfPt9ajDVzd/A/HrYk1HHRV/ayP7A4K/mNAx0O/RKXNArjW4ayuHV0xH+Oeu5qMyyM0u5TFKf3krIXYdKAMFs30hTrBtRTGEzAljoja6EXjjnAATdPXor7Yg00Ytg0p9LKE59nMU/Riq2RzKCfVEmx9LpCAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786003326; c=relaxed/simple;
	bh=Sp51I9A4HwmjWLoiwlhtt51aWNWATeMNcpphqPPpb6Q=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hUCcNv6Sc/ampLAsqw70og5bWV8AJzPfun1VyHOnJWjdvPYAKK68/Jbtyp3Eb/mvR52ZtYRflrUHPdfyD30/AS3JKebOKrrtHpHJLSNUP63otFMRDaIhxi66adkD1OjrXi6QjWUOpruF6bEUfRrxbC6uZj4MEnVJioogjTxHVdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readahead.eu; spf=pass smtp.mailfrom=readahead.eu; dkim=pass (2048-bit key) header.d=readahead.eu header.i=@readahead.eu header.b=Dvbkxlji; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HLMa1piu; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readahead.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=readahead.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readahead.eu header.i=@readahead.eu header.b="Dvbkxlji";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HLMa1piu"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.phl.internal (Postfix) with ESMTP id 3C5EBEC00A7;
	Thu,  6 Aug 2026 04:02:01 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Thu, 06 Aug 2026 04:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=readahead.eu; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786003320;
	 x=1786089720; bh=RiCfBmytWb9lovh9XW3KP3nmJXbNXW4d6cDXCURF6RA=; b=
	DvbkxljiTZrdj0WpmctrXjQEj3OB0/0Gyz6T8fyYPOqSbVyGRHRWykQe5+XmNs6i
	AXHctFz9vkpOj1cevK3TsGhx83YQBwX0du1SHiJfUMiJtPd2WsU5TJC9oxJr3qG3
	FoK6/NpPgXtnoC+7R82cODy/Fd8JJAhr2/FWq4NXn/w0pX2cbO+p8d7SKHx9m5Uw
	aNZ9SDVPk3TmRRGiq4SoPvBPaIgg0bYdpx8B+YVCDWeJxD9XR6BUq0XGVSHP+ICS
	09qO/8RWJQX7blgs3ElgiAvEL7gv/2BlQ95IELaaGNRtDCYT0rPyVfO7uX+gddxd
	HBEDoMA4vmJ+W9b1Ddty6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786003320; x=
	1786089720; bh=RiCfBmytWb9lovh9XW3KP3nmJXbNXW4d6cDXCURF6RA=; b=H
	LMa1piuz2G1rsxUgcdDYqJhf0NL7WOTKdPp1TzWyBirkuhiaauVjnZ9VUGg7CHbx
	9Er/XP+kSn1e+9LjxiR+X36QkP1bV80CR1lCG4TMC8A7bRa8IjTUJqYIvbVaEF1K
	szK1Nz6hVyMUIP4RyK+E+75IXzPrGs1BtaqdKZdlqI161COBkEt/Px6Ck7pncgCU
	/DZe9ge/KFqOxbwV/o02zM3N8YUSlTq/DGTFAJepVdD8fi/lhyZ4movyQleeRVyn
	+qcAUCCa0GRHPJ+54s//FzgQBzB8DnOmcNOFny0a6fiA9GOS7vyXbjQ+axDCgsQW
	IqspXJahSlZLeZlDgNaXw==
X-ME-Sender: <xms:cz90akLuUWjsSOmP1gmT6hqb49MKS0zd5SDlT_pct4Voki1VKv_9Sw>
    <xme:cz90au-RWMM9X8vPTakH0nDhGblGZXukC6JCyys8RsLwWXP8qCUvsf2H_JvHzGjEE
    evccvjyNraFmUYmWGAfUKlhgSBFhg8W42fTB1j_heDGZheOlikHSL58>
X-ME-Proxy-Cause: dmFkZTFTUREjfTQWEoN6uWg/HZUP/g1GkQFXjSOEfg2gEnK/h9T8L39pAswAea5bQOmy6e
    8CZx7RqcziDd7M2u3KHaAp5qSQiDevSeKOPz0ewfr13XKGCsd3KF0IoqWAs+9NaTcUd3jt
    sc7zPE32l3mijFDNDeiLPLGS4D7x7qC3PCir0M2vrMfRGrQ8TPRxErpJTlOXU8d7KaqIH5
    PHrc+KAfVSYRGZ9naYmbdU5OHoJluv0JB/sH1i3xtjx99gBs5v9o/sJvhL6bTUdHyvVFZW
    SwAkkCb63C+AfES2+a6cSmLuC9LJAcNHak0w5drTTl74lTK0SFDYUdUZAgK51SUDJXuJiL
    NOpQM+ak9rSHZorw1vMhXqYMaIkLznjweJT75cnpyLIw2zZrEwpEudtebfjDxHLfBdLfHb
    NNmCLZZ14vx84fy9syG9EiY06YepYLbERUesgqraMEMZFczHfxgWEFcS2K9frzGMzzFLzM
    qH53e1vL/3Rg0BMp2sBKzUlJnrxKfKSer6l8+/6KUKRRtZ7va21TpMBPiEs+8wzhqUs52e
    ddTKNT1LOlLlAgTa8YdJyY7D0K/rL2bU/cnKVuh3t5InAcq+8mDBezZVDzwHBrkdEmY5aW
    86ILanSS3gYhZXaQJntJ/1rvDSO5d1WqIaN6KdKN5hFupFumt4WHzzLQEEyw
X-ME-Proxy: <xmx:dD90agBcDpM-PF_Z-ySmKf27znb8L3XZJ57cSas96JDbtQoDljG0aw>
    <xmx:dD90ajOadOJCq_N0GlQNpJbXqouIsiGHQjXPWxPPJVeAOpm2OspgxA>
    <xmx:dD90ahxO6NZ9ZVARy8Qu2nUniEDpx4z8oqBRAHOloR2tiS2xRgX3nA>
    <xmx:dD90arXJM9NCyskwMwsxP0Gt2JFeoZy_JtNrn1Ys7AZKZ-kDCkta5w>
    <xmx:eD90al2HfJdBeWJ1a63_0cz5VgFV2EzqkRNxjOLOmwFZ2svp5UwY0k7w>
Feedback-ID: id2994666:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 0D29332A0066; Thu,  6 Aug 2026 04:01:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A_FoBlbN4D9R
Date: Thu, 06 Aug 2026 10:01:34 +0200
From: "David Rheinsberg" <david@readahead.eu>
To: "Rafael Passos" <rafael@rcpassos.me>, "Jiri Kosina" <jikos@kernel.org>,
 "Benjamin Tissoires" <bentiss@kernel.org>
Cc: "Shuah Khan" <skhan@linuxfoundation.org>,
 "Brigham Campbell" <me@brighamcampbell.com>,
 "Jori Koolstra" <jkoolstra@xs4all.nl>, linux-input@vger.kernel.org
Message-Id: <c444d532-0aa0-4978-8629-7578e8b90bcb@app.fastmail.com>
In-Reply-To: <DKE11FVZYDCW.1UEUU1GSXHP3B@rcpassos.me>
References: <20260729164928.1138468-1-rafael@rcpassos.me>
 <20260729164928.1138468-2-rafael@rcpassos.me>
 <6ffe2879-5d76-42b3-bd65-2180967d1498@app.fastmail.com>
 <DKE11FVZYDCW.1UEUU1GSXHP3B@rcpassos.me>
Subject: Re: [PATCH v3 1/4] HID: wiimote: turn on the LEDs indicating the controller id
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi

On Sun, Aug 2, 2026, at 2:21 AM, Rafael Passos wrote:
> On Fri Jul 31, 2026 at 6:02 AM -03, David Rheinsberg wrote:
>>> -	hid_info(hdev, "New device registered\n");
>>> +	player_id = ida_alloc_min(&wiimote_ida, 1, GFP_KERNEL);
>>> +	if (player_id < 1) {
>>> +		hid_err(hdev, "cannot allocate controller id\n");
>>> +		ret = player_id;
>>> +		goto err_free;
>>> +	}
>>> +
>>> +	wdata->player_id = player_id;
>>> +
>>> +	hid_info(hdev, "New device registered (Wiimote %d)\n", player_id);
>>
>> `wiimote_create()` should initialize `wdata->player_id` to -1, so `ida_free()` is a no-op in the `err_free` path. Right now it is implicitly initialized to 0, and thus ida_free() will warn about an unallocated ID.
>>
>> Also: Why not just use IDs starting from 0?
>
> I chose to start from 1 to avoid "id 0 = player 1".

I think this would be perfectly fine, but I don't insist on changing this.

> Wouldn't setting an u8 to -1 result into 255 ? If so,
> this would not be a no-op. Also, comparing player_id < 0 would never be
> true. If the IDA starts from 0, there is no usable "empty value" in a u8
> when deciding if I should call ida_free.
> If I let "failure" to be 0, I can just use this in destroy:
>
> if (wdata->player_id)
> 	ida_free(&wiimote_ida, wdata->player_id);

Whatever you decide on using as invalid value, you need to check it before calling into ida_free(). If you reserve 0, use what you suggested. If you put -1 in, check for -1 / 255 (even though technically you should then also limit the allocations to 254). Or change the type to s8 or int, or whatever works.

Thanks
David
