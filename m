Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A861C41A505;
	Mon, 27 Jul 2026 13:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785158562; cv=none; b=YHnub6N8BB4ylQIwa8B++6106+aAsCYLqSCNS1I4gUTjSQqwT9YDQwQz9mdso3AuQPY7BbF8KkRMpfTUD9FbyOoPJVcH5oD4NexTfWg1QEMd2oEz6VErhREYr2aGURmYmgiAqZtX2ToIrp0h2R0idK5KB/RaBMjOjmVnSXE3wFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785158562; c=relaxed/simple;
	bh=4h+fnq0F4Qv55k9xbXWWudJWzghLpWZllmMcOpKWfJ8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JQeNwTwlcIYV4LDvjdAwNDat1JTPrhDbllpluF/gWtnQ12VPM/GgqJTUcI/U3dGZLgri/pYiSq4VWq/EVPqXRwFX0KEqPCto6Mh/yJB4aKtJ0ukadUR0jf6zQauCnjFpdvuai8HtTQmlWJ9DZPmFJHRy2l3YShPw3w2RrqGWXNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com; spf=pass smtp.mailfrom=red54.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=FcWGuMYY; arc=none smtp.client-ip=203.205.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=red54.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="FcWGuMYY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1785158548; bh=4h+fnq0F4Qv55k9xbXWWudJWzghLpWZllmMcOpKWfJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FcWGuMYYrKp+tWOUJW25vrGW+0SLuGWy74pklE2dRKr9Y4E70BaUbwqqCieL0PK/C
	 5r1XZP4v6vdaKdrO+ijDU2j5FLgrR0w9f558mR4GJBNRSBnPf2gpm5bCXdZ8ZbiVup
	 Et7WsLwOdyqdC5UaQ5Tl7JaYcKpO0WK2qUkP6oQ4=
Received: from mail.red54.com ([103.253.24.18])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 5870AA4D; Mon, 27 Jul 2026 21:22:07 +0800
X-QQ-mid: xmsmtpt1785158527tjaumlawf
Message-ID: <tencent_B61FC9737ABBDDCF4A60256D7FCF98B5FD06@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoeqBzBzlzqI2x3O7sxL5rh7LW6Q7FT5Oc86YJ0wAB6j6TdeGBpX5
	 rYzkFtgWRpeZOzm+kPDsFJxQdAOJT7h3hO0d7OThhOimQBNoCC+NLkfrXnHle1lPWFJ8TKjt7cdl
	 +lEuTPz+3GUXwkulM8zQfgRlwFqsv+wVpko7TYcIYfVca/Al2p2/7KuxxcCBeHThVLr6TFj5xM6o
	 K+o4icgA70Odu5WUcgJmbL6xfqO4eTMGoDLW/mI5j0xbzu3JdTUS26UyRE4hcodLy4TH+W6tFcEv
	 tOBsUACbRNGi97oaNOiqZrgh1DP6dTQO29EU2cktMwFD+KuI2B88rQhp1OYbmy6AAn3t2nsCclo/
	 2Rg/9OmjvICqcYvigbTdNBxT9PrScvgYRy322yxEgYLGGbCneZ3XEbLNXQG5D+iB0cCp/0njoCqr
	 nivOZAfxjXDQMGAn5ee8JStofUm1f3qILBHdy5csPFargIa+FgjG8ZFsyYNPuTd+Ljbtff+ljtCv
	 L1/cFH1IL7yF2yUX9pU5V/p2PxZoIoGaUul8F+X7GMf/Kv9J0VypJVjBTMIE6kp6luZSW2Ea73s6
	 4FyrJzPSyEde+R6XyoFSK1pdEcKqcoq5Ti70qkcZymzeyvMWw3WfKrw0KlCNpHJmsoSpTO7/iaEK
	 y5fY8bfLOQnPPur1UFO+gJ/KnwzKB17U/08pu5mqMJcngiIjDcvCmvTljlELeugCMOFqsdYgH+XN
	 OWdSkt/Of4yRGhpf3tBf2/kuuyakTwSMd8/FYtvg9osEb03d6pTA1W6IxiBJkC5SlUEFKEkCsA5V
	 PIzAm7qbjvPk+BApypQ9Exm6DnImClnOVT2aSXof4Wsp89+ZgjOxfKNoy7pMmbsEIE7/MZmLV6ul
	 Oi4IsdFODo8mpf+KAlLKQaWqg7etUIvhNnVXA3a4W6H4vQ+eg1lJPiSr+jNLzhc40nwLikGT8h1U
	 Bz4wmtDFZWZkCp7PwrMblABMn5uvMULAfoD98t+W8+F3NEf7+izAcijN7WBkK4XfDnS8pcJwcfF/
	 14Ioes/LfgkBuSZxiyTpgDXXToTOmvijHeFCYQzYi6C6QVpXdUHP78+66Gm0eXNgr6OMQdXbhe/p
	 52rL/VdbIVpxCQUxI=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
Sender: yeking@red54.com
From: =?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?= <Yeking@Red54.com>
To: linux-input@vger.kernel.org,
	hansg@kernel.org,
	dmitry.torokhov@gmail.com,
	bentiss@kernel.org,
	jikos@kernel.org,
	yeking@red54.com
Cc: dianders@chromium.org,
	linux-kernel@vger.kernel.org,
	sashiko-bot@kernel.org,
	sashiko-reviews@lists.linux.dev,
	superm1@kernel.org
Subject: Re: [PATCH v7] HID: i2c-hid: Refactor _DSM helper and add i2c-hid-acpi-prp0001 driver
Date: Mon, 27 Jul 2026 13:22:00 +0000
X-OQ-MSGID: <20260727132202.66220-1-Yeking@Red54.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_76FCB13C1FB6FBFFA004F2D19AF6E458030A@qq.com>
References: <tencent_76FCB13C1FB6FBFFA004F2D19AF6E458030A@qq.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Hans, hi Benjamin, hi Jiri,

Friendly ping — v7 was posted on Jun 30:
https://lore.kernel.org/all/tencent_76FCB13C1FB6FBFFA004F2D19AF6E458030A@qq.com/

No further review comments have come in.

Is there anything else you'd like changed?

Regards,
Zhibang

