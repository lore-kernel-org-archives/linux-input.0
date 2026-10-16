Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F1E423E9E;
	Fri, 16 Oct 2026 09:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792144696; cv=none; b=DlI036iegAZO6Ez0mNIKA4pmJZjWO5V8U794XVJWTsYXi2nJ8JeUdb51cvMn9BbVXRay/VxqUPHk95p4qtKizGvM4DzXGN9toBo8Hb1W3TtCTjtLvHOHzpF/2hSsqf8aHeCEjmr6BttlpqCj/pzXrscskxlH1Nr9zT/fmMmn93s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792144696; c=relaxed/simple;
	bh=I22ghJolzdNclZpWsxooy3Tk6heiCnMsECp60D1aQsw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NeAioiLiwlJ/cqH21cTglPTHeB2ghW4cljwMKxyEeFBfa7ox5pf1aq6O8E9TqRidAJ45oDQzY9WCpYvURq3F8RzAUOhwniGR6KyqSiswaUCLEqKUJDpcS7mr9HbSX89XQdTFoFgrv1/5oPSHCIDbONaj2rl8jl0/S1Lsv0OdnPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhLCrey4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhLCrey4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB141F000C4;
	Fri, 16 Oct 2026 09:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792144695;
	bh=MtukVFNTNaXEDI6mUYTkMNYHnigtQ5j6TCPPGtl4jxU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=RhLCrey4VlzbxbYlH/leCNVPGmc0PYW7OvyfU06TWbCAloKuBqCoIkdyndlBuq2C3
	 jo4KDEwPC/5b2rlBkpEiRyjNLB1faBdr+5TUv+qCJT7eAxdbFYpQStoVHQQcXpwviu
	 YW6Hox2GiGIORjdfZfCbL8EIcqafB+QqUL2lQTIEtOYSpjqWlxKUzSMmcCLtp03R2w
	 eAY2ZvLepOF4ltOY8vG2iNMkVfWXnbTgGR08ZXoP8W1XwkKpRMkfvq5roOOHTDdMpT
	 vGnU8qv5qf+iHuRAGTpIsiUAw40dqzkhJSarisRrO4HWNt/syvLrnI0Q7x4i3TeeKD
	 JT+YUc4++B4cg==
Date: Fri, 16 Oct 2026 11:58:12 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Aditya Garg <aditya.garg@linux.dev>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    Linux Input Mailing List <linux-input@vger.kernel.org>, 
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] HID: apple: ignore the trackpad on T2 Macs
In-Reply-To: <20260903064407.27755-1-aditya.garg@linux.dev>
Message-ID: <1n24q16o-p210-0q73-49n9-3q0034sn2ns9@xreary.bet>
References: <20260903064407.27755-1-aditya.garg@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 3 Sep 2026, Aditya Garg wrote:

> The trackpad on T2 Macs is incorrectly bound by the hid-apple driver.
> This is due to both trackpad and keyboard sharing the same VID/PID.
> Use the existing APPLE_IGNORE_MOUSE quirk for the same.
> 
> Signed-off-by: Aditya Garg <aditya.garg@linux.dev>

Applied to hid.git#for-7.4/apple, thanks.

-- 
Jiri Kosina
SUSE Labs

