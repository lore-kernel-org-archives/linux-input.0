Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803533D4123
	for <linux-input@vger.kernel.org>; Thu,  6 Aug 2026 06:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785996973; cv=none; b=qaHQ81+bFyLcX8BthFSpwis/kBbz+KvUHyFxmiMGm65QtgSgl634vI620yXKzWzZ6PugKYz5GnkdermIsLB51vFx6qxvi5GhyIpxve53zAdYlTM2GCJvMINkWxjqm1TVVRhDTn8505G2vV5o+XyAcJi9zYBTpDqZCzpssswSSi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785996973; c=relaxed/simple;
	bh=QqDgaN3QLEWvxdQzR38D0itKNcr94KPZdjDc2AmBvk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uesIvKr15B7q3pK1HjYM5Q860KldsliNzwKFQ/miTvPuxTt+4QFEadjU3KyosP40FiYY3B7ssiyJXjsZVXe5ygmUicJGSq4egMd7zLOrA0xDl3mneAS0LFbKbhBAxxYuQIr4xN0ibdudhnN6s/D8eOO8Ad3KloDUNNhjh3mSq2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLP13XwD; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLP13XwD"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so1955503a91.0
        for <linux-input@vger.kernel.org>; Wed, 05 Aug 2026 23:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785996972; x=1786601772; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sHCR4Pl+L0o94n1jBJ2gxemm61MSJDR8xkqz2EWs+Jo=;
        b=jLP13XwDcgx8oDA/mc4srkCvjvXocVx3Jl+YiaGWw7kq/gKTZn0wdX8KIVk83wkyq6
         odkRfHF9iPXjiLMLUjB4+hUf42TwU9KgI5ITs7PURPDBlea3nyKLtL/Rru4i8FiW1ugq
         nS9S+msI/1HmVIjB34ZphiLHO15/uNKdBxF21OOp+IiXC1E6jTChUaYm1MCABPXjsZIx
         VBc8AUFun04RZmKMBauVNa3Co39VeWfrNPbb0xn7aKk05JX2jOSanStjArRLO2eAtuXX
         y5ywAqO64Sd0997A7TY3z4gkLd9GFHD5+3YV4M9YTCM3S0DY4Cdf0L5C6OFRZ6tssa0N
         Sqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785996972; x=1786601772;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sHCR4Pl+L0o94n1jBJ2gxemm61MSJDR8xkqz2EWs+Jo=;
        b=HRWR0Y1AgKU5HQQdtUe93riEkYUjPmXbB8PN1xCP+tnk/ZhCyx+B4jjcb1HPAbIbwP
         Aru6k/t//V0wNz9ngkigJp9HG0bPy114mlyppm9yd8EGSs/nNq52pZ31VsCMfBEBik+W
         sZFW/Nx3SZxxCjhpuMEig/ocW/8ARnvm9x2/FWrXfRdbsp0eZg20VoQchtmguR+3QiM3
         xNdFc1gY+UMYNnJuK9H1AkVq+UXxlKolc/GSl//TmrFLdCi2cfonsOZvIdT0Jg1d78bp
         9t3/dc7amPsp519OvhuD4Y3uYVzepkBrtEqdKV4Br0L7+eb121Z/1s+jslCseaCDiNos
         nEBw==
X-Gm-Message-State: AOJu0YwjMdM6PorxZSOwIRWQgBAfeIYZfIobemyOoBCWIiyBDxj5LJkw
	HASJcd0LAA9hwNrTvOFk/JvRxtB6fxaAN55q04rqZUr7wrZXLb6MDi3k
X-Gm-Gg: AR+sD11qSGaXyB9U7G0xbJb4ng1tbx8xayHwHsUztqyoS6PbmwBH/hbA91NuSxrzTMw
	BMvzmFChOW0SyX6UFCZMJH6Z+6gddQB4JI5QXGlb9EMNo44wfBHeh7gxob7mYYIN/UFPiMF9LM6
	yjDxgIsR+Vp64picqXDpEyoTZJboIlanGn8Vzpy4YMCcRTFdBgJPsipMEGtZfWT1Qu5rwgr2WJZ
	6Kmnsamrhun7YGUNjM49kwGo8VPlw3DYTHvw+UofxBIgQFchbkWcvJ/MS4U/LqRR2mJPCReIunU
	559/QdFK1VZC5SBhXfY2jaVO7m0RQF7Vf1f8XulxIZDzA5TeAEmKPXDHsgg7NOVjuToLk492ljH
	O1/TnmO1TmzxdG4KxCsDfXe2uCNiKx1m/fggS/w3k6Q7kHv6bQN5BQbrWZUZtDrZgq4ckTEIrHY
	Q+nZFtXyYAClobsiPoBVpeL1IGCPUSgAGqpm9exUkP2Tw7N3cp3W2Po1ZVS8v7tztBxldaESD6H
	qPD27eS7biD5ilVQ+IVjGvH2Y/N
X-Received: by 2002:a17:90b:2785:b0:37f:e1af:df22 with SMTP id 98e67ed59e1d1-3903c5f03a0mr13935687a91.17.1785996971639;
        Wed, 05 Aug 2026 23:16:11 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:d081:36b2:965:e66f])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca6576b7sm18965936c88.7.2026.08.05.23.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 23:16:10 -0700 (PDT)
Date: Wed, 5 Aug 2026 23:16:08 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Dineshdkkhatana136@gmail.com
Cc: linux-input@vger.kernel.org, Dinesh <dkkhatana136@gmail.com>
Subject: Re: [RFC] Input: atkbd: HP Pavilion Gaming keyboard backlight key
 reports unknown scancode
Message-ID: <anQlOWU9YhC-2J-S@google.com>
References: <20260730115950.85353-1-dkkhatana136@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730115950.85353-1-dkkhatana136@gmail.com>

Hi Dinesh,

On Thu, Jul 30, 2026 at 05:29:50PM +0530, Dineshdkkhatana136@gmail.com wrote:
> Before preparing a patch, I'd like to ask about the preferred upstream approach.
> 
> Would maintainers prefer:
> 
> 1. Adding a generic atkbd Set 2 keymap entry mapping translated scancode 0xab to KEY_KBDILLUMTOGGLE,
> 
> or
> 
> 2. Implementing this as HP-specific handling (for example via a DMI-based quirk)?
> 
> I'd appreciate guidance on which direction would be preferred.

You should submit a patch to systemd adding an entry for your key to
hwdb.d/60-keyboard.hwdb based on DMI data for your device.

Thanks.

-- 
Dmitry
