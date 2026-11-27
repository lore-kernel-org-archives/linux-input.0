Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795765772;
	b=lg5txL3HKqkWqKR6v+gSfzEFY4+zLDA6pfvOMHdC1eXzkne8f+Fwf5CIxsvXHgpenayL
	 JOro1o8YOpiUdCQ0Hr+4j2ZNe+cNZ1di2VPj7uG80OEJBgDjPFrHouTAo7G7KyDJFjdir
	 aV/sEncDQ1dtPGQ+Z8ghepjqYl2hO5IGOeIn3z+tcqDkwJv3IVFwgAP0YkJOqbnLEzxO2
	 dFLcRw0SIY+Wxrc0rRi8FwFTX8S517ecLxr+wbVSgFEt/5GezxJiH7cCLV/Em02Kw0Vqh
	 49AOcGmE/sngNgZWpugk7/UnO6grO5rEnHRrN2nJr0lKgYsQthJNM0p4ElhdQCD5cLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795765772;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=HLxEAQ2ZpD9AVoD4htgJV7McL6Yosfy0Q3R44XAubYo=;
	b=l3gFlwOGbfgwx5UNX0VP13S51FKl4ZwOZMGax2fe38Vq/HrLNHnhwcc8L9U8OPdXWAsS
	 AF8uqREmDzFT/HOH6s2JtLr2biZkFRQZ8Bk5OQDHWRJC9OInO3v2dZH7tvInt5VrpwIUa
	 ZGgGwgtwlUbL3MvTCqFkJAi8rGJnNvs8sEjZubLD3OjX6pQW6ieNrww7TdlSCh9KvLzgW
	 BWQdwcMW8lBVK3p1WgNobjIfXS54RiNq7VE44pSTxD2k+TXpEFjizuFIs3uOYU5VgU9aN
	 WFCgGhlEwXTmo4Wof3809aU1VjS5GXAel7h1cA42cGqxjc68/YRzAY3NfRYpm/V6DqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AVZ6rRBR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD617606A329;
	Fri, 27 Nov 2026 07:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AVZ6rRBR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AFD11F00893;
	Fri, 27 Nov 2026 07:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795765772;
	bh=HLxEAQ2ZpD9AVoD4htgJV7McL6Yosfy0Q3R44XAubYo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=AVZ6rRBRqFT7KqYkhinecAMjeI0Rd2kSA0Z81nHLykVG3qsdfvG+djQJhVLYoenIn
	 rWElr3UQsb/BLFxB4AqiJVVPG7IwL7Fsn9gqiUrV8176XJnnm1d/CPk7vVvrrXEvM2
	 +5lA4t2AMAFj76LV5HNjhBuga74+X8H1larn0MkLn12V7dR9W/6h8Op24cDJ6j1sm6
	 7u0hnNOoAIYTOPs0aVSLXByJYSwxh1e6hvTS17urxXSsAqo1dntATwRSQ/8XbRhcum
	 /KQSUj6PMGwbLaLi8o3SoqlSJjHtzUvnKJ30h6RcE4tZDebTO3qOdzQNUFj5QKOvho
	 Mb6at62l92JjQ==
Date: Fri, 27 Nov 2026 08:49:29 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Yicong Hui <yicong@ycstuff.net>
cc: bentiss@kernel.org, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, yiconghui@gmail.com
Subject: Re: [PATCH] HID: magicmouse: add pressurepad property to Apple Magic
 Trackpad 2
In-Reply-To: <20261001000659.21747-1-yicong@ycstuff.net>
Message-ID: <p3943r07-0pr9-2no8-78s4-0sn0p685q4o8@xreary.bet>
References: <20261001000659.21747-1-yicong@ycstuff.net>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 1 Oct 2026, Yicong Hui wrote:

> Userspace programs like libinput will take the pressure value reported
> by trackpads, and use it as a proxy for contact size unless the
> INPUT_PROP_PRESSUREPAD property is set, causing libinput to freeze the
> touch input when pressing too hard.
> 
> Set the INPUT_PROP_PRESSUREPAD property for the Apple Magic Trackpad
> 2 indicating that it is a pressurepad reporting pressure measured
> as a real force, as specified in commit ae8966b7b5bd ("Input: rename
> INPUT_PROP_HAPTIC_TOUCHPAD to INPUT_PROP_PRESSUREPAD"), and set the
> INPUT_MT_TOTAL_FORCE bit to allow reporting of the total force across
> all contacts.
> 
> Signed-off-by: Yicong Hui <yicong@ycstuff.net>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

