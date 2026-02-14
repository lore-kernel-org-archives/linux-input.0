Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B962F745E
	for <linux-input@vger.kernel.org>; Sat, 14 Feb 2026 19:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771097691; cv=none; b=WqGJ5uHl7jKv+5Yke6ol6MZd63yVtwAPT/vEjaxXQzt9RavSeQSnDR7482iM/0bh9ezhzjTP9OHPykEsOrXQIrHl/H8VKF0e1OrJSyqNIWnnDm8TVKRxu5dZvC39ThxQ1XOKWEcBvQFyyblzbgSdB+RtLN8YCGRXdSFxMAtch3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771097691; c=relaxed/simple;
	bh=k3QtBmvkH85Y7SD8ewOfbHOVkOhRXD8qXzUct60VeEA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=EQgftiWd+zvRFrp5lpMA9pfuG5goJMIsidK8r/h6pjhgSehcKiIQIKU0PRzc5CTXhvMQXIhCKrwUIBZQdGS64U5F7ECFcXgRxdK9ek2+dQGx6emE2lvFNhniSpbcqcvmQDN2PsXdBGfo+vQkhhzyhyux0hw5TcWR0MAt5and6Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com; dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b=u7tVBSDe; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b="u7tVBSDe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ubuntu.com;
 h=In-Reply-To: References: To: From: Subject: Cc: Message-Id: Date:
 Content-Type: Content-Transfer-Encoding: Mime-Version; q=dns/txt;
 s=fe-953a8a3ca9; t=1771097682;
 bh=WcVudwyap5VOAmo/TAFpzXDMG3OHXX7mA209/eVovE4=;
 b=u7tVBSDeplL0r4ZFMQupurfXf3xiwFebrlbOkPedRQTKyMdUNT40INQbk4oMGqwLG02W0Qu80
 1oKXEKxWJaUO4glt4EajgQNc4kOpDNq/ScV9DPBln4fUTBPl+D8nToxQZm3qJNe36Y4ngYEdyZQ
 CUwPQgnFd+IzCxBILVyXID5CRijObAAIeILbEJjerDkhqG8bwRFp54F6ch6JOVNuq6WRuzdHMkx
 lHpKjhpo7lKvmx62wtfD58Yyd6y0efSjFeopePFgV78B0YReXUzcsv7OIjC8mdwIzwwxJzXaSTh
 ULoEL809HjrsJwPPUXj0x2e2F9Mc8kuYqxh0IdiV4kyA==
X-Forward-Email-ID: 6990ce4f62810ca23a433c4a
X-Forward-Email-Sender: rfc822; jpeisach@ubuntu.com, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.6.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8; format=Flowed
Date: Sat, 14 Feb 2026 14:34:37 -0500
Message-Id: <DGEXQ8IOZXIQ.2C12HXE7F8NIH@ubuntu.com>
Cc: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>, "Bastien Nocera"
 <hadess@hadess.net>
Subject: Re: [PATCH v2 1/1] HID: switch2: Add preliminary Switch 2
 controller driver
From: "Joshua Peisach" <jpeisach@ubuntu.com>
To: "Vicki Pfau" <vi@endrift.com>, "Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>, "Jiri Kosina" <jikos@kernel.org>, "Benjamin
 Tissoires" <bentiss@kernel.org>, <linux-input@vger.kernel.org>
X-Mailer: aerc 0.20.0
References: <20260109034034.565630-1-vi@endrift.com>
 <20260109034034.565630-2-vi@endrift.com>
In-Reply-To: <20260109034034.565630-2-vi@endrift.com>

On Thu Jan 8, 2026 at 10:40 PM EST, Vicki Pfau wrote:
> +static const struct switch2_ctlr_button_mapping right_joycon_button_mapp=
ings[] =3D {
> +	{ BTN_SOUTH,	0, NS2_BTNR_A,		},
> +	{ BTN_EAST,	0, NS2_BTNR_B,		},
> +	{ BTN_NORTH,	0, NS2_BTNR_X,		},
> +	{ BTN_WEST,	0, NS2_BTNR_Y,		},

Wouldn't it make more sense for South to be B, and East to be A (and
so on?)

--
Joshua Peisach
