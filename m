Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795124913;
	b=k9aHIl+y6raxMrsvEjO0a2KzU9ySgn5VcSvUQ8DvOqkj+3v6aszEcUiltpWIFr5zqwq/
	 obtx0lPB0F8Pi15YXT2AzPzj0te3AXes7MW36oMYF/ZQpBrWttAbNVR2ysGtHWy6hVczm
	 IsyV67MSkYI/+w39nAtboBDng997REualRu/sqILDuvz2e+/ROI/b6f4/fPRLfohxj5cx
	 JTG3kgxO7OVIJo7PenMJm3zHQvyw64iwvH1U+NrIuazhn5VPbyMmWAHlmAzjsEfXgrrTL
	 0QSc/uI7HxYc44ypDzNruJXaihWzVHwFMBRU0YQ27VsoHYQkE1QAb8EMMxY/TEHpkhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795124913;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=3RLrWa8cWiK47JmZg+2x4DjG0a31/hKehv9jC5FxM4I=;
	b=yEkHRcu338hTVCNdY3OcfXJjwb7L9gVljQbZe6Li1ox9zmKMdeFchytHJgL8erG0TaMD
	 iV678UkW3Lzz+TQGtnkLmTggl4ml2V/AJuJENrux6SsGlp5FkCiawLoehhRVsRbMJgs+N
	 umiNSsbJqYyWJ3k1wzvZJG+bPPm48zFWZe5x4T2JeTMh5Be85RS2nAwudf9oeMqLc81uU
	 S/vo/chHHDycmUIey79gbNDXzyCxp5cQWIYMOosO93LpOwjD/EyASxZFdMr1h+n94Hj3B
	 IkAAKP4p4P+EJTTG1TCTrv4y5eSFQbWVCeXs2p2gHa5o3x/2qudDXC9ZciNLKE9vdow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZS7jDjd6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3D2606A320;
	Thu, 19 Nov 2026 21:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZS7jDjd6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C041F000C0;
	Thu, 19 Nov 2026 21:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795124912;
	bh=3RLrWa8cWiK47JmZg+2x4DjG0a31/hKehv9jC5FxM4I=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=ZS7jDjd6DAFIDX5vfgIXbi0MV89HFrrSH9odppR2NQ9Rfy2Ap4Qc4RxxAVYIzXKxQ
	 QnvjCNPnedex0tWR/7BW7LPTz5Yb5Uu8sm09vVM9y9BZ6hSM7vMCGjq69p6u+2N94Q
	 Kc8S1ZCnN3v07kaROMFJxnsBmhIl1QUntLayIKs2ntTuL/8FYwDxqdNgqomtAUr1vB
	 n8ZeSOsP2qdYyyFSdR95X9VlYubq1eE4iHPqJTlgVbF/2eBoKh7sEAgMSAXAjlXhne
	 i0B/GYHBtrlxAjbgKpohRfIShA/ZN9/2W81i00r78Je3Vjkazrq//zkt0e907pYVBE
	 KFTcLtivtTUjQ==
Date: Thu, 19 Nov 2026 22:48:30 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Viktor Sharha <vsharha07@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: quirks: add ALWAYS_POLL quirk for Keychron Link
 receiver
In-Reply-To: <20261028232945.20169-1-vsharha07@gmail.com>
Message-ID: <4357r996-sr60-6s7n-n8q4-or999078n712@xreary.bet>
References: <20261028232945.20169-1-vsharha07@gmail.com>
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

On Wed, 28 Oct 2026, Viktor Sharha wrote:

> The Keychron Link 2.4 GHz receiver (3434:d030) exposes a joystick on an
> interface of its own. Keychron's Hall-effect keyboards, such as the
> K4 HE, send a burst of joystick reports on that interface every time
> the user switches actuation profile, even when no profile uses the
> joystick.
> 
> Desktop environments do not open joystick devices, so usbhid does not
> poll that interface and the reports are never read. The receiver then
> stops delivering keyboard input on its other interfaces until the host
> re-enumerates it or the keyboard is switched to wired mode and back. A
> key held during the switch also keeps auto-repeating, because its
> release never arrives.
> 
> Holding the joystick device open, or booting with
> usbhid.quirks=0x3434:0xd030:0x00000400, avoids the problem. Windows is
> not affected, as it polls every HID interface.
> 
> Link: https://github.com/Keychron/qmk_firmware/issues/532
> Signed-off-by: Viktor Sharha <vsharha07@gmail.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

