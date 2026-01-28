Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251B936EAAF;
	Wed, 28 Jan 2026 17:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769622365; cv=none; b=EebkHvmnsscm0e5g/cEWPTy2OXPkwRBXTnUC/npB+pZZjA3ufDk2QJlCcu/qgQ9bGaRUWQVesbjZJ55eeh7hFgEPP0/jtjxc3zT4YZCCQku7KIqZIg8yMd77jtzhCtsQm+iAO3gl1ohGqElSZjjlLmz0Vj36/pqhHxdaFk/m72c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769622365; c=relaxed/simple;
	bh=y6zcCm0weiv02jif+kCDNZ3KdQfxUZJx2damFDR2gS0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WIUozGZ5cvQ+WrRCOyvRghMRwDCWs/XkvRxJHKqj0YOApAE95C0ZuQpn1o0bcxlfP66TYZTnDwT8V1hIjkx+SuMYGpHaiQVnD8NnpTWwOdCLLws85pQNKwxKQDtxESPf5LckCNyth+duLdcSxfA4KkydAECiCECORptmbxa1Xp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFRZnsHZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFRZnsHZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58777C4CEF7;
	Wed, 28 Jan 2026 17:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769622364;
	bh=y6zcCm0weiv02jif+kCDNZ3KdQfxUZJx2damFDR2gS0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=mFRZnsHZs6lFM7PSZkVe1GlO9JJr8mNZ8o66MDwyp0PzVuyv2tKhelNsdU7NCKhJU
	 x3YA/xeBhZBoBximl2MEAFXqd1I3xk/K3AifqtvXU17g8YWqhD/V0ObLvcWcCOSBxt
	 RIayPhRre/wudWFnrY9O/DRFwKu9xHIquRhuLRy6YOcalcJyl4jn6PoX3bVYgep2vH
	 Iakqmn48mO4SlytBiTQwynPB6PX3vRtzIWOrdhujpgscPJjlXfP1253/MSpW9Gv7fR
	 ggoItzyvTpD4svIJ4tj9WCIWwyra/pxJs83kDXH1spe6r/nAMmxh5/jypo0jwvT/Is
	 f1QIccu0nObrw==
Date: Wed, 28 Jan 2026 18:46:01 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Bastien Nocera <hadess@hadess.net>
cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev, 
    linux-input@vger.kernel.org
Subject: Re: [hid:for-6.20/pm_ptr 7/12] drivers/hid/hid-picolcd_core.c:651:33:
 error: 'picolcd_suspend' undeclared here (not in a function); did you mean
 'picolcd_reset'?
In-Reply-To: <4ecf6a790596c4814c6666805b53aa7b1dd5a793.camel@hadess.net>
Message-ID: <n7o7o70s-3pp0-r590-p65n-2175r761q79p@xreary.bet>
References: <202601260353.Dk5ekiee-lkp@intel.com> <4ecf6a790596c4814c6666805b53aa7b1dd5a793.camel@hadess.net>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 28 Jan 2026, Bastien Nocera wrote:

> The wrong version of the patch got scheduled in that branch.
> 
> The branch has v1 of the patch:
> https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git/commit/?h=for-6.20/pm_ptr&id=318f7b0f1bea13d3aa0506fe6f40399f11c4ae52
> 
> This is what v2 looks like:
> https://patchwork.kernel.org/project/linux-input/patch/20260113092546.265734-8-hadess@hadess.net/
> which should fix the problem.
> 
> Note that my v2 patchset also dropped
> "HID: surface: Use pm_ptr_sleep instead of #ifdef CONFIG_PM_SLEEP"
> which is still in that branch.

Hm, something went wrong with my b4 workflow then, sorry for the noise.

I'll take a look and ensure that the correct version gets queued.

-- 
Jiri Kosina
SUSE Labs

