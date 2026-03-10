Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7FE23BCED;
	Tue, 10 Mar 2026 17:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773162270; cv=none; b=oXSCL4rpPqYmxHSQZ1VCTtdqoUSYHZlHgrBkxslLg2GG+7o1VjgbPqmVRFqtikeb9uOH1VVayvopSRdL3nlrVPZHFfhXpHYAno27DsD0tW2TcdCvh/SyfT6zftc4RhkRxZilLuHQ6Styd2CfycDVmQK5EW5AnoSrtAKlOfa58J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773162270; c=relaxed/simple;
	bh=jcERqjub+kmhj0RtiIDyeSiBqtsaXtarWgmN73wlcFw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uPsL9XXczo2ZUMRhagmSHqf28VLSAUsE3Od0F0+1GzNCY1EOQ1IEdZekob2JEvIAUgPIGrtYwSJAwf2jCKfUqOlHmziNEnTPCEr2a4w/PvdWkjzr1yrV0sZl5hoxHaJALIR3trvVScsMsY0RPFK/m/l0JIfJ6FckZzrH9HFyfrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCNMtQ4n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCNMtQ4n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA31C19423;
	Tue, 10 Mar 2026 17:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773162270;
	bh=jcERqjub+kmhj0RtiIDyeSiBqtsaXtarWgmN73wlcFw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=oCNMtQ4n1MrzSVmfPqP1FgBZhWFLeEBusYPmOZP36Xdath5uFscCQIp/vkm6Pn9C+
	 j2yuhLVb27iY5zhNIcL4Ao/+S/FbeITZXM8nmd4k2r43pT5JYZSf3Y/vZ4l9ee8fBN
	 pukkEnF8ofLinybcNlDX81WJE66ioUVSxwfGMX8rCXniUOHfUf7JEgcVIs8u3LX0fX
	 r0FMnQMtVkTE9UXJgnRyNwyGs44x9Ol+mCfQj/1YqgpM7YT4090jujIOBMPtHFssmY
	 7todcJac9tP5g5bCOjEjuYP9b661HwiVVxZNd0ScQhI+IJFlXUb+PjkmbqWQJt72Ug
	 WGoVvTi56TxWw==
Date: Tue, 10 Mar 2026 18:04:27 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Denis Benato <denis.benato@linux.dev>
cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
    Benjamin Tissoires <bentiss@kernel.org>, 
    "Luke D . Jones" <luke@ljones.dev>, Mateusz Schyboll <dragonn@op.pl>, 
    Denis Benato <benato.denis96@gmail.com>
Subject: Re: [PATCH v2 0/7] HID: asus: increase robustness of the driver
In-Reply-To: <20260228191010.3830758-1-denis.benato@linux.dev>
Message-ID: <sp6o244o-8840-3q46-7266-520165onp274@xreary.bet>
References: <20260228191010.3830758-1-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 28 Feb 2026, Denis Benato wrote:

> Hi all,
> 
> Previous asus-wmi maintainer and asus-linux developer has become less
> active in the project and left me in charge of advancing the support
> for ASUS equipement on Linux.
> 
> I am preparing to send a patchset of his revised work to support ASUS
> ROG Ally handhelds devices and since that work is also useful in
> expanding support for 2025 models it is important to improve the
> hid-asus driver as future patches will build on top of these changes.

Patches 1, 4, 5, 6 and 7 applied to hid.git#for-7.1/asus.

Patch 2 applied to hid.git#for-7.0/upstream-fixes.

Patch 3 dropped, as it's fixed by 7b2f88cc9dd4c2b9f3d in 
hid.git#for-7.1/asus.

Thanks,

-- 
Jiri Kosina
SUSE Labs

