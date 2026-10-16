Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1DE3E7BCC;
	Fri, 16 Oct 2026 09:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143766; cv=none; b=DuMnjygwk896qBu8waJcaW8dhC/nNb9wdQ8nJMpOi3rCPSL6iMa+2/31nJD0YNHXz7UxrG+y42YUd84twL+pFLRFMAv4CtXb2U3nY/jhbvkE0uxKbI5TAOOCKSQ3k+fw5g/g7yCc8oW6nkHRyk6CvgeA+/F04Hed7BvqdnCQAAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143766; c=relaxed/simple;
	bh=G6/10ke9NYHCbPMjv/V3XIQuzlBoeJCbnVT4QBOVLDg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=c1O7grue8ZYNpBMsUC9FuQhnZnCN1hX5Ia33LKnuKetHFe4dNT4uhogsT9cuXWmL7Np5rUHHtZcBNBVlGZVbGRmYez/R3eLf5gloGsHsvEfgirufQda19lsavg6U4sukaabx6AOm3kgwok8/KRBMMtohpM42FBVGNpQKTN6i01M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ll0L3GXo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ll0L3GXo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D921F000C4;
	Fri, 16 Oct 2026 09:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792143765;
	bh=UlUlZ0i1Ii+ocKjykVy3xPARknYEqXjSibeXEO+pB64=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=ll0L3GXoR7bnpTq+in0CEOkjzVK7qzHhgbc4yDgcn1teFn84rUOBSub8SYUQaHmGM
	 7XEcAJRisWcly4dfqC3eNN7MCIKkeflPGdBZD0iIUzuFpxeJ5G8hXWV/RiY7DASHX+
	 EnYDwQOje2gAFoP/YI2A30N0AxwEVb8v7VyyhXdFnKn9cehcz0rSUaLTxJnp9eihxJ
	 ObG83YpyQBMnR0xxFDqPLmrrW5GDkubDIN5ARBmXYvhf1iq8l5XvcNbGh+QvwQ0ZtW
	 HiUVAfuX/xOAhVVpidgjnv+7jd5SMt3m5NHZr/7yfko2puylIW4eHir3eEJA+PsGu1
	 cNC0f+o5FDrRg==
Date: Fri, 16 Oct 2026 11:42:42 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Denis Benato <denis.benato@linux.dev>
cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
    Benjamin Tissoires <bentiss@kernel.org>, 
    "Luke D . Jones" <luke@ljones.dev>, Mateusz Schyboll <dragonn@op.pl>, 
    Denis Benato <benato.denis96@gmail.com>
Subject: Re: [PATCH v9 00/12] HID: asus: add support for ROG Ally handhelds
In-Reply-To: <20261009122820.7603-1-denis.benato@linux.dev>
Message-ID: <82q38prr-84os-0n4p-4337-683o299512qs@xreary.bet>
References: <20261009122820.7603-1-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Denis,

this unfortunately doesn't apply on top of hid.git#for-7.4/asus and there 
are more conflicts than I am comfortable doing without actually being able 
to test.

Could you please respin this and resubmit?

Thanks,

-- 
Jiri Kosina
SUSE Labs

