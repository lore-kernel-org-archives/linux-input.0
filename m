Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C70379EF6;
	Wed,  8 Apr 2026 19:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775676658; cv=none; b=F2yhEyEuu4A4XERBD9qiF+omX4d71fn3My5foWsuxizHaO4r1yhFGqb9rAnLSuy3O9GN/Ed7uAqvAU30fwdzPDFTBdlPguub8zUpDopGLqGuFgd82E8qLkqwt+ZDE5qj7U3AuEBMQx4EiPYsWm3TPLJEJ2IqnjVqHCahdxcAjLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775676658; c=relaxed/simple;
	bh=iPMhfVLkiRFGmKf/uet8JOEWLR1LlRRHZ7gCYNyb2Do=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ip305F/l9VXXO09VouW/CBwF/FE95NGMGXViux7WY197FCZ9wqFyMcSP+Tr3BmmdkQjYpaqwpdL/59y8+tNvrKArTMc7u8gX23f8o7Oe4lIdPzIYi7IfT99qMljYmoWui7XTmken/OiOOrI5z9VUDrlDWWElWDXUF11fISveCKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xgti+FSp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xgti+FSp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B3CC2BC9E;
	Wed,  8 Apr 2026 19:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775676658;
	bh=iPMhfVLkiRFGmKf/uet8JOEWLR1LlRRHZ7gCYNyb2Do=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Xgti+FSpmid8Bd6xjWEAIPXsMaD749NRRpQDny1VEKXSpM7zzI9k6mQVN3OCJmD4r
	 FUqqB/r0bYZNtGCmsOZ12Kif7IzGMJJ03Z2v7ulEImeluivp0WJg02zJmE787JvTM8
	 4/1PvEGPeRic2v0K1nwGFTICvImzG3He8Q9dsUVkFrf+r8lwVIv3fvGY1PI4dMj67q
	 nkKYNso7obSr19xHARHQRuYsoyiDjPVfxSxG+Ifhro43dx0e6NYwl+6tCe+W9sXcUp
	 gsRPyxwDOzWHt4lcZZZ7g9WVnmlBaQPgnHdbSOC+F7re97qetPfAGsmLdbf13mygSw
	 AYnN76w5elPAg==
Date: Wed, 8 Apr 2026 21:30:55 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Benjamin Tissoires <bentiss@kernel.org>
cc: Zhouwang Huang <honjow311@gmail.com>, denis.benato@linux.dev, 
    linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: core: add short report quirk and use it for GPD
 Win (2f24:0137)
In-Reply-To: <adZ2PTzQ05iObcGt@beelink>
Message-ID: <0q5589o7-0qp9-25oq-7n97-50q172q8s1o8@xreary.bet>
References: <20260407173212.86942-1-honjow311@gmail.com> <adZ2PTzQ05iObcGt@beelink>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 8 Apr 2026, Benjamin Tissoires wrote:

> OK, so if a firmware already fixed the bug, I'll drop 9e2a17d2e808 from
> for-next and not include it in the final 7.0 PR I'll need to send. 

Now dropped.

Thanks,

-- 
Jiri Kosina
SUSE Labs

