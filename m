Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14723655E9;
	Tue, 12 May 2026 15:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778600972; cv=none; b=NzFQdaV53q2D5qqmZQ5NnV1DXEx7rwco4Iw9K0R0+LRRJ4OcU77XwdZTJypMo0qBnVFrnWmjeGpF1VZSia6DBJSB+Qa4sSg3Q9O1qvuyDX9/QV4qb7rcDwn6E9SjGMZdRaWqPsA4cU/W/tqLC093pPXll2YCzukdXxUEd8sOLJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778600972; c=relaxed/simple;
	bh=ywEasU7a36keVfgUbMrjuzLZ3V6SFPsRR9vEKRN+6HY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=l64VMT91HbndO/Egm120cE7E2OFMMdAGQtPgG6afo13euL/F92PKXS1pj/3SD6coaTRzpFF6OmvVi1H0qLeD6OEZt8uPN+8WVT5kc7o6wVAtHVe8JyOLbD8+xsd9IrNIoMH89eP6Db+OQy0lQYCp0NsScsl2hlKnUhP6TAjh4eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jysG1yVe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jysG1yVe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D3FC2BCC7;
	Tue, 12 May 2026 15:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778600971;
	bh=ywEasU7a36keVfgUbMrjuzLZ3V6SFPsRR9vEKRN+6HY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=jysG1yVehSNVdsYoJBd7llpn4Zp9va5peiIJcehqaMJfSrejkv5r1QZMCer68Cx7J
	 xtMTd5m8nJqwOp9paeR7BgeI6dUyA2yY2h+TAJ2luMs0yX3n1OMrZaITYrAl7Rz3D7
	 7DVkNKIaHBfrPe60cqHsv1XCG4W7GEq0fNrJiFEK4VE02iblqv3HK6vKDew6aoT+Ip
	 oQ82stOjScf2ACOy2fB7WVl2o7yRH6Jg7j2yRDMVJTAX4x76TI+Fz4whHL9YGT9JTV
	 KSCr2U+Bxhqk7Bg0/8aa0U5giEnetgClo+J9QkhVxruS7hAw57La4898VGoc/Mr+IH
	 INuwI5Yfmt2BA==
Date: Tue, 12 May 2026 17:49:29 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Lee Jones <lee@kernel.org>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, gnoack@google.com
Subject: Re: [PATCH v2 1/1] HID: magicmouse: Prevent out-of-bounds (OOB) read
 during DOUBLE_REPORT_ID
In-Reply-To: <20260416131655.2279756-1-lee@kernel.org>
Message-ID: <1r60np21-08n5-29ro-s0o6-r45pr422q221@xreary.bet>
References: <20260416131655.2279756-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 16 Apr 2026, Lee Jones wrote:

> It is currently possible for a malicious or misconfigured USB device to
> cause an out-of-bounds (OOB) read when submitting reports using
> DOUBLE_REPORT_ID by specifying a large report length and providing a
> smaller one.
> 
> Let's prevent that by comparing the specified report length with the
> actual size of the data read in from userspace.  If the actual data
> length ends up being smaller than specified, we'll politely warn the
> user and prevent any further processing.
> 
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
> v1 => v2: Add more size checks to protect against issues during recursion

Applied, sorry for the delay.

-- 
Jiri Kosina
SUSE Labs

