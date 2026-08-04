Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838B73F3275
	for <linux-input@vger.kernel.org>; Tue,  4 Aug 2026 05:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785823166; cv=none; b=AvB1jWrPQ8X0yg027a2zZPatIC1Gt3ZsBXXU8kIl8uze6IS8r+hbqCWzjTu1Oz8y8shbsJpwDfYrQGatPPrOD/pxhuxB0CqUK8qVl4ZaDLlvWnEvh/OxjQLkCAiI+UHJL7XTlqdOaQ9kuBB1kHfUj/qK6F8EW0EIHOgmHizt238=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785823166; c=relaxed/simple;
	bh=45qMr05RH9eju8ErKccVknyVpToXp1eeb8CHUu0sp3g=;
	h=Message-ID:Date:From:To:Cc:Subject:MIME-Version:Content-Type; b=JalOQeoA55iMX5V0Y1c4dcym39Qw+d7X7sHJH7cX2tHmH1VrERT8q54PBXzvfQ02m+YW+I6ElLE2Id1aREK/k3V6MnFUA1NF97gTCWFByUufjD+Q8rgfDVop+eYwj70nLFM4XwR4nauk3IQH4B//dyMlyxhjNoOPftzJoAgnsLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=eSpoTRAe; arc=none smtp.client-ip=203.205.221.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="eSpoTRAe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1785823159;
	bh=b/8aLwIee1Y4gs8ByEtpegd7WM55oBReMsIARDr4JCA=;
	h=Date:From:To:Cc:Subject;
	b=eSpoTRAewMzkTrQb0UiXaiV+UqfOit4PO+CnONdsTHETucRimAbA14H5Ly4g97ddM
	 iLJxv5GZsc0Ncd7HFrtfmASbCteH30jREBBWf6f/ug3k7VXfRKBi8Ofo57H5mF0/Ej
	 62dV7ZsLzjUe3icoCR418RhiW0A4uEEbLwlzq/R4=
Received: from localhost ([182.91.99.53])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id ED285688; Tue, 04 Aug 2026 13:59:18 +0800
X-QQ-mid: xmsmtpt1785823158tcw3ba5w2
Message-ID: <tencent_E4E0828C2FC582A61FBA7A52932BB7656A06@qq.com>
X-QQ-XMAILINFO: OIJV+wUmQOUAhG8MvXAAnwa81GjwLDSHsPY5Njhj+F7xpipX5WgWtoMsbf6tNT
	 miMBzXdzPZ7rVJ14Gkpt5Pbc4RTudCpo22ekomfDIM1nWea1P9dBWyFGmQVNiH9gM9f9921m795W
	 E5FSHhHG2JphxU9r6oYNXgdFR8v/rK4ED72VjExgj6w2uPEx3mkch1uPfZRlYZRIvnl7MPEkXFGP
	 9u6tp9NIa6HLIqEy61vgQXrr43JOT8eWQIhvJZmUZTujpdvZ2Xm69AwblWzJ29fICamUiB8OveLB
	 U8UyF8JaB9FTlZ6+/O8aTbDNxAizQQ3MrHTWiOH5robK9Wl5APlKUZf4pX9IG3dwyIIC5SJjXTUX
	 5vUYU5O5nk1pKOkGm0WqXJzpGe8krolrP04dne7ZsUXqjGnZJDgN32rBzmk4Up/JTOpV7Yr935ks
	 aw8VaKQD1ms6I/PY8FdAur0I59wWZcYLvcxlxCXvVI/LAEDHjl52S1xRgDtASUbUYglrrRv7h+PH
	 iZgpF5T/DoHpswRksR22TfueZe3/2qxCGm4kMugsp/+gwWCSQtH7SboRDUJzdXN7dALb2Z4HfiPg
	 2bHaFF8xQ545fNdF1rl9eH/9u+dl3yxkBPEf89KzQJonsYGk+jE5FoT5x68pG1QyasCVEi34GNtz
	 yL2wec6CiM+YLyDrL8P31RH3btVWbgfeG7jjSfAVxKz09Jl2OHmrw4PiRVwOjtGvVnBVJFW5byPz
	 DU4SenWK2esGmnboLFQpN7puIuZTc2erTv+tbzSdN5f4kkw8SuO1UpV3hb7N35JzdTm9sGrlYmTs
	 +YZQM811MizxeAYD4PlKFWEfzpMNWRTDasfdp002Uq8Osn0l5Qa4fozB8eG5+d5DNeAbHq7SFrzO
	 deY78X44DrT3WwfF1HcHCn7nY/HqJ7Dl5xqlzhSx31/uvHq2pl2PAcSB9EvhVBjtNo4e+PuKkVeA
	 SNfLd0o3uM/OOVgy4gpWiOTDbTHdBtzOllIkQYg+jhR5WwbISZ/csGRu6lzavcBRRKnYMDnQCqe8
	 Cr9VfBaYPzBa2BTD+uFze8nyEL1xVESh8DjE6i2kxQf9CiQi9+
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
Date: Tue, 04 Aug 2026 13:59:18 +0800
X-OQ-MSGID: <4fa756950e981e524028e13141076212@foxmail.com>
From: vegetablecat@foxmail.com
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaron Ma <mapengyu@gmail.com>, Shengyu Qu <wiagn233@outlook.com>, Zixing Liu <liushuyu@aosc.io>
Subject: Re: [PATCH v4] Input: xpad - add support for Beitong KP series controllers
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, Aug 04, 2026 at XX:XX, sashiko-bot wrote:
> [High] Contradictory Vendor ID for KP40D between xpad table (0x20bc)
> and HID quirks (0x20dd).

Both are correct. The KP40D wireless dongle is a composite USB device
that exposes two interfaces with different VIDs:
  - 20bc:515c  XInput interface, handled by xpad
  - 20dd:515c  HID interface, kept alive by HID_QUIRK_ALWAYS_POLL

> [Medium] usb_control_msg_recv() with sizeof(ms_os_desc)=128 will
> unconditionally fail with -EREMOTEIO on short reads.

This is not an issue in practice. The device locks correctly on all
four tested PIDs (5126/5128/515b/515c). The response data from these
requests is not consumed — the act of sending the MS OS descriptor
request sequence is what triggers the firmware lock. If any request
returns -EREMOTEIO on a particular platform, the dev_warn() is
informational and does not block probe.

Thanks for the review.

