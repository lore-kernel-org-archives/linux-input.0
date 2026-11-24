Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=84.247.164.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795547078;
	b=oZAnaWbol9h+kfmwHqA9qkioZqI/F895ql4avgY+s4s2DoTMfwqrE+lI232jDhWY9ywc
	 EP7ZrK3YQPn2rFSnQ7eIJfYR3qDf0X8lpvnNiyRV9mFFCOg72DWiN3zNZjsynwRhW5YUx
	 EPLTGvLqpAajbNez0aj/Qx4JvyLnXvLEyrFN3VeyxuP6RQVHGNsJZDZM/fEs3Cg9htXGy
	 XSpjJRTtl5TsrbpRq2aGpnRoQUQk3oU4EOR3ljVku6s/ViYi8QQz//nQDDFV+6hcGnbyu
	 p3vP8nRrNIioj//P2rASFUWYsAgkX/FZTabSoKp+bcc7Jn/oxV1pv/tbx12DwbOPUzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795547078;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-Last-TLS-Session-Version;
	bh=eT01RV2q6Z9PssZBEgCRfVWCieewei0XtF0oecSDjFQ=;
	b=OOCb+jhAYGMSyycKzps/qlKnZa+4jepyHFly+183L2SgSn8pB6LO8rOZe3xLnhXAB5gt
	 UGkatcA6Bxxbvw+m/GL8lwi2V0zphKt4PCOZ0F3f1/8AXa3RTND9JF4Wia6FBO8RlEA/G
	 uIcnlALq4UbpLO91ZtIh39FXDR08BG1kYpXxxFCTCCgx3sPYVeRh3sd8N1IMS9su+8ybz
	 k+/pkgK9yOJVMunITQ5708lq8u2vuakoJN/HRmcTH+xaQ0g1Ih+CHzGzkwcV2vJfvBr3K
	 is1/REYAn1DLxbXKcEne4hOLRn2NtinubieNO9kf91IX2e16AdyQhkcwn2KBLG+F9sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=koesling.info;
	spf=none smtp.mailfrom=koesling.info;
	dkim=pass header.d=koesling.info header.i=@koesling.info header.a=rsa-sha256 header.s=dkim header.b=BgfnXRtV;
	arc=none smtp.remote-ip=84.247.164.36
Received: from mail.koesling.network (mail.koesling.network [84.247.164.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CBB606A31E
	for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 19:04:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35CBB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=koesling.info
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=koesling.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=koesling.info header.i=@koesling.info header.a=rsa-sha256 header.s=dkim header.b=BgfnXRtV
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E8B5E1320F7F;
	Tue, 24 Nov 2026 20:04:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=koesling.info;
	s=dkim; t=1795547076; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=eT01RV2q6Z9PssZBEgCRfVWCieewei0XtF0oecSDjFQ=;
	b=BgfnXRtVZf3j4S1MUJYEQNTDUpGctyp0E8dODZ5t1K+zja+Z2ZrqleBCROrl8woFFcMswZ
	5+I1UvPZd19q02YQ89I4IuVGSymJAxGcsLRMr5jUZiSGThdjwCtt8LiRIu0u2r72EdA572
	G8RJ2FecKrnDPDG+shDLgWLWsUDGPTpMyjhXj0Jd4yIYECGu1IU1tOk95SHoNmmP8Vj8Ad
	tpbsFeoqhVVywZsc2Pi+6kAFBc5IOoD0VfdormvHxrl8AoskbJI/Dh2iQ6sWG7NTwj5fAd
	UFWsPMHzJC6J5DC36uJQMLPRJvJBaiz3vc0IVfVMPeEYHgHsV+bX2EoEJzSJkA==
From: Nikolas Koesling <nikolas@koesling.info>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-input@vger.kernel.org, Aaron Ma <mapengyu@gmail.com>
Subject:
 Re: [PATCH v2 2/3] HID: pulsar: resume device for raw command execution
Date: Tue, 24 Nov 2026 20:04:35 +0100
Message-ID: <zFM9JtW6RymvIlWWE8tsvw@koesling.info>
In-Reply-To: <20261124141315.6745-2-mapengyu@gmail.com>
References:
 <20261124141315.6745-1-mapengyu@gmail.com>
 <20261124141315.6745-2-mapengyu@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Last-TLS-Session-Version: TLSv1.3

Looks good to me.

Thanks,
Nikolas



