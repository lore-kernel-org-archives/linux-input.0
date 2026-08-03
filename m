Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6531F435EF0;
	Mon,  3 Aug 2026 18:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785783222; cv=none; b=AJVfKtXy/NhgAKjHh8IhEAy8ykCJan870jRu6vNvcc2VAopkNs1MjDl0nm3LPqsWqYtyu1/+IoaKHe8BDeoc0FZvWsDteIc7RtkSVUsTJpUszyfIjx+Glp2r1wPkv952b67mI15BXJJB6L2bR19q7ikWEJ9rK+CNnXdEjsRTOuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785783222; c=relaxed/simple;
	bh=miA7RuTsTDOqlqESlDvLspOX3rG4OiGReUQlxuKe2QY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XXpxPDZap/NcPQhafM/rHAFFQa7lTFW8+EQ2h+iMiyytXKaI1MuhVT3Uml1lJVVHZTj502SAqmfLj6d4/usZQhEv3SydJPEBwaF9ebmVOk25GgnmmQ5SAAeD4QDzrHW2baxaLc0sPgz5aPHb+RL6tJHkWEC0D1vVWGeCez5HSVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekUY/8bt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekUY/8bt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4801F000E9;
	Mon,  3 Aug 2026 18:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785783221;
	bh=X2uOnMZy2XnsCSZBPr1Tr3EQz5e9a0hr9emk4UjN7ss=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=ekUY/8btybb2BeGbIQPuHymMT6U9PFfRlwE9b5s7DB+1ulsWLaUv1eDcyz2xayr3Y
	 kdCQrZ845HTAAFSOPbshtBGGEfqJM2kduxjqSKa6LNOkXuvlLpqr0t6A1OblJGW1EI
	 IXnPGwlhwt8ZJ/cqsDgakv/laHn5MVqUVC0YILA8tuQ+hEGZus/C4PQqEUflWb9GqQ
	 uX5cgR/3hc557A7WIGnaBtDiUIAhJ2cQiLJQXgfvD8UPr3EJagdbGE/ZsOZt5/6xlf
	 78bmX/87UdaYEUA0O++yueEeebyj1/0Oe7N6QlxUORgYm7vfFW88vdUBbvufpDid54
	 194FRyo9aArRg==
Date: Mon, 3 Aug 2026 20:53:38 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Even Xu <even.xu@intel.com>
cc: bentiss@kernel.org, srinivas.pandruvada@linux.intel.com, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
    hbarnor@chromium.org
Subject: Re: [PATCH v5 0/3] HID: Intel-thc-hid: Refine error recovery flow
In-Reply-To: <20260729050145.2272597-1-even.xu@intel.com>
Message-ID: <rq974non-9809-043q-6r8n-qr8937n6305n@xreary.bet>
References: <20260729050145.2272597-1-even.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 29 Jul 2026, Even Xu wrote:

> This series refines the fatal error recovery flow for the Intel THC
> (Touch Host Controller) subsystem, covering both the QuickI2C and
> QuickSPI drivers.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

