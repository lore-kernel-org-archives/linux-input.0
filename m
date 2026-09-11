Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8053034F27B;
	Fri, 11 Sep 2026 14:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789136459; cv=none; b=gbLZNEY8nzZJRWKeTLcFtpKyhhicGo7E+9Jl85GEQXcdpgOO/ji964ZdFbFRtof8Ppg1UZw9WmV/+/ZTSlyydMs66KPyefGbZTB+b+qvk83UbI+scxuhCAyvjlN4gio9df7yqEQb7WuVvcHS92s7xugjL9nP7hsUCQStWiV17pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789136459; c=relaxed/simple;
	bh=Y0QhLrXcoEieY6b0ytjnwrxFMoNfWfmFASS7lY8AQOg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fPiQEX4z75n8Yjs/rx0XuCbH7iSk+UCYFqs+BhbWJbbQsK801+NbrtQZinSkDFJuWWvqswAE2c4CeeNqbtE9HIdwYHxXQ6gImrOpB2RAmm608j9/EBaoF48ulDKyyjSUG+wOXL6muTZqkaZFe9hqbewKJyxQ2sVBa19yzpd0aHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KdHXl9KO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KdHXl9KO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841971F00893;
	Fri, 11 Sep 2026 14:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789136458;
	bh=oPcRcdxfnYZeXyA7Z0NgOmnRD2GpoZA9qoYujY0nOg4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=KdHXl9KOQwZN5NBLDKENjAY6Ygrxm+BGL/SYCXYbARdm+ul09XmCIDxvuk/9AZpBq
	 ozvaRNFF9uizy69Wfu8T2/x5OVh6VxaXAYjh+C6amfWxX1r3PEXhRKmsVY8hgu8ryV
	 AaqduqeN9AdGUpN102qK2KmZAe5mtIvwrNNiDLoEEN7eXVmrbNEEDiKxdNOY32JWRo
	 Vdnl9YdzSZ05ukGDXD3DIpb5TOSnBuFFNGrnsnCy+LtHCV7VcHn8Gb1efy6fGXZe/v
	 3Z6rZYhGG1+Xr3oCmOVnun3EiEs+z97xrlU2ymbPoxbyA1oSY8QwVtJByZ/jSXfsig
	 aGxgLDj6wCNeg==
Date: Fri, 11 Sep 2026 16:20:55 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Chen Changcheng <chenchangcheng@kylinos.cn>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, ccc194101@163.com
Subject: Re: [PATCH 0/2] HID: alps: fix DualPoint Stick input device
 lifecycle
In-Reply-To: <20260814070621.68557-1-chenchangcheng@kylinos.cn>
Message-ID: <84rr1p6p-1rpo-3psq-858n-14697s209q62@xreary.bet>
References: <20260814070621.68557-1-chenchangcheng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 14 Aug 2026, Chen Changcheng wrote:

> This series fixes two issues in the hid-alps driver related to the
> separate input device ("DualPoint Stick", input2) that is allocated in
> alps_input_configured() but not registered in hdev->inputs:
> 
>   Patch 1: input2 is never unregistered on remove.
>            The driver struct has no .remove handler, and input2 is not
>            tracked in hdev->inputs, so the default remove path
>            (hid_hw_stop -> hidinput_disconnect) skips it.  Result: every
>            device removal leaks one struct input_dev.
> 
>   Patch 2: data->input2 is stored before registration, and on
>            registration failure the dangling pointer is read by
>            u1_raw_event() (URBs are already active because
>            alps_input_configured() calls hid_hw_open() before
>            allocating input2) -> use-after-free.
> 
> Both patches apply against linux.git master at 7.2-rc7.

Applied, thank you.

-- 
Jiri Kosina
SUSE Labs

