Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795120180;
	b=hK74djq9qTm5xpSu17qh3QFxjQsOP//Uj3HIyeRxUm41bIo1jhZR/sAwFRalJLvya/F5
	 vLbDtHaMCc81lHGBkmLGi7LuceL3JlKNb6h2hd8eJLmQVtmSY3mmHTHeCLt90WENI7VEl
	 QvW0KAxIUlpNYZq1bK2tSU7MKWA8GgO3IQ3xe7anB7Gv/P3RmT5sVHE4SwKd4si/4NvDR
	 14XXL0knmpdT77dmPpQfIudB3g1DFDrRI9EWr6rW88DAF0QsIIeaW5KMIC5b/gKn9QvYj
	 SSBRTnqyFwBcs+BtmGOnK8iOjVUiY8pc69OS0OU9UQFZ5riVO0i/SEYWSk2yXiV/o3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120180;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=b0aB0kDkAjljsdIK2fVRymh9YLiC8tp59+fkLfxIXnQ=;
	b=4UqpFcKyBhxSn8kkmJs6gDPtU+OGdGObFi7CbM6E8MEvAmrXJrm84SmWSaB08RTDKEzu
	 LD6fTifqqhwOUqt2A+awyNxqjS1y8PM+UmQV4ZFoF1mBxGsVUugqOKNwqitiz5Z5quPln
	 G/LYR/n+NoFCSxDyH3l52eBteKwP1bBIfykPrcmlqGKHG/6DU8rkLhjFzjO7281ziRz7g
	 Ytf6/u0Nm9AEDUJ0qHeeFuvEYWWOeycX4EaEeqX73dSWeu0ssuEu/0U1Q+YG7LQg+AJEV
	 /T+Z4IYE2MdcOYzRiMxBMeacqSZF4uNVeCOU/40dX1D28gZz5xuiq1bbteEBKytCkPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hijN1RQW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FF7606A33D
	for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 20:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hijN1RQW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427C81F000C0;
	Thu, 19 Nov 2026 20:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795120179;
	bh=b0aB0kDkAjljsdIK2fVRymh9YLiC8tp59+fkLfxIXnQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=hijN1RQWTmyqSnYQ+F0SSMJxChrfdzcqkWTDxDkAYmFCyeYw9+31xIGmB+JudU5sV
	 QvjBbT10Y6+P4J3LDO5F8JgG3sW/hPSmvGFIEU70hBCanVOMrpqAV/MKmyb98w0osN
	 wFE35/rF+pfENis6U6TeHhh2TUnnGWUyGWgOQLtqf8tgq5SFRPxoXL1W5g0YDV+fpP
	 fZzeA00fKQvOCRMzPjuivIvDCk8yzAahHfx4SvXR53KMM5ZBDlSl4kNtq5bZGWttPZ
	 JWswff0Z9ezwjkig4QzwxHCzKocdbbz+IwxP9AmmTW/wCDM4oawe9EN7ylhESu8s3N
	 u4qgrgemwzOPQ==
Date: Thu, 19 Nov 2026 21:29:37 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Vicki Pfau <vi@endrift.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v2 1/3] HID: nintendo-switch2-usb: Fix potential deadlock
 on teardown
In-Reply-To: <20261111065001.3626071-1-vi@endrift.com>
Message-ID: <524372r8-q2qs-ns3n-0r09-o6p6qrsn87r3@xreary.bet>
References: <20261111065001.3626071-1-vi@endrift.com>
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

On Tue, 10 Nov 2026, Vicki Pfau wrote:

> As reported by Sashiko, there is a narrow window in which cancel_work_sync
> on the message in work can block due to the work waiting on the mutex that
> the canceling thread holds. By moving the pointer clearing and unlocking
> the mutex before calling cfg->shutdown we can avoid this deadlock.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20261006061619.2005967-1-vi%40endrift.com?part=1
> Fixes: 9417132df63e ("HID: nintendo: Add preliminary Switch 2 controller driver")
> Signed-off-by: Vicki Pfau <vi@endrift.com>

The series applied to hid.git#for-7.4/upstream-fixes, thanks.

-- 
Jiri Kosina
SUSE Labs

