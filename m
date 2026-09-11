Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAB53AAF75;
	Fri, 11 Sep 2026 16:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789143805; cv=none; b=mE3IPO1wpbnPR5VelatYqbgNCWNg5MDuJGN37ANQ/MTcqwO+W0Lndm5Ww+BV6UfAWpq8v/yZsKMfcxPzaLVPZZyIhmii5R5pQHnGJsY41oqZRiR6IEV2b974+2LJOpbEHoIX0NBOHYSgERIWXwt+jl2cT4hZXAo+0IZMYkpl7PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789143805; c=relaxed/simple;
	bh=1Ag5HcAA18xDXWPHt8sY1TNFQTGQYV+VBGZhu3qCAGY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gQtlC7uSy0EEW8kXI8rgxqWLKFeZwDxxMDiX9uwClNd6KDReZF9kUyitKL/z7+hjAOwF1YqGXjri9nl9d9BCzV+D5TwnPU4tBKPC8ay6WC1rSsfKErWmC8i+et85kq3HzGuF3XLQ6DsO5cP4IezPsoO53gqerGDQPfdU9Xb302I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hkWDHDSr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hkWDHDSr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160781F000FF;
	Fri, 11 Sep 2026 16:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789143804;
	bh=FUG6HqhyaKfgQiNpcUJ/VgwxJN6YDeYCzKjZVR8f9Ss=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=hkWDHDSrGxBNWkNooaZ2ZBuSa57wT2SIiyxWviy/7DZ+LzAGcUEvFtoImSQ4F0jUq
	 aaYgt4JazwzlakqkI3vCP1tMqkO87/hTviPrN37iHY9qBcbEfjWhPIrscWoTHTch9t
	 A7H5PGp6icQO+dXNxerCzU5lDxQI7MBma28oY5s3A0BGD9UsqJNrr8IJi34EHaAQvW
	 F1kf8gOsUYyEUvV/drev/oshj39aJ/gSbHWMHBZIJlwS6/3DVFtKeNLW6ZNMzKSgjR
	 kYFIOP/oJ02ll3l4vpYnPQtobu4tUfNZa8qTSA3pZSff2wy4UtX9HsYlsyi+LluH7B
	 MkAZPDOQvtQvA==
Date: Fri, 11 Sep 2026 18:23:21 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Benjamin Tissoires <bentiss@kernel.org>
Subject: Re: [PATCH RESEND] HID: corsair-void: Fix firmware event packet
 description
In-Reply-To: <20260818130053.45064-2-stuart.a.hayhurst@gmail.com>
Message-ID: <450rn059-47p4-9319-47qn-672n52p7r358@xreary.bet>
References: <20260818130053.45064-2-stuart.a.hayhurst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 18 Aug 2026, Stuart Hayhurst wrote:

> The size was incorrectly stated as 4 bytes since the ID was missed out.
> Add the ID in and correct the indices for the firmware versions.
> 
> Signed-off-by: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

