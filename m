Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CAC414A27;
	Fri, 16 Oct 2026 09:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143068; cv=none; b=sSSpNb2KLKxwM3hOTbRLvT1BQ49qXaI09YTnH68+7th8MEQt2gaeSur6wbs1X4KCqs0ApmfSF5ipPTX6PTqX4mDASblNxhE1x+wKysCgoAsviAvkikNU43Ioj1S37XmP/LYxXkeFLx3EaUjMVtU6pW8UrlnACuV+VwavOVdQdkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143068; c=relaxed/simple;
	bh=6EbV1oYJAfQEQG33N5w4YYAgDqd4UAZMM8GN+PWrKrQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FA7EE4OAWBtlsdLbmKUfJo1xEMsFQ6MRqIeV0m+qHBjIUHlYSfedxdi6cbF/VFG4SJLtNd8gqptJH56a08x4n3XZt+k6avA5LcDlILN6me5IvB95WlQsX21OsMfkkDyr4FJYy01dKi8ubc7xxpWePOoJ9geyEqXGyc+qmxlukgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLMuhnFJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLMuhnFJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74BD41F000C4;
	Fri, 16 Oct 2026 09:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792143067;
	bh=noLcCu746mLJ9CAt+FDWT03FSrYXn2DTKmLvKK1mhTI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=GLMuhnFJO4MdbAcRnD5kvYqKVswW1HXMUIu95ARHYi0ETLy42A5p0VmpuE13hPda2
	 QpwFEL9JwhqAW41qnkicoZT9qbOQ9yVRwppJ5G+1T7gUT/XaT1XUZxDfldRCjhdlJA
	 eFIwO3V16EWrINE2JKjU4/l0fPRUWjB8ATEGFNKO6AvB7bSlBUizFek1o5s9BOcteI
	 Yqx6deBgjaNmTozQDRi2zhf2woQU/PUhwSpzYBiPcM1Ad0xT1TtMvoBVUyq2y7SEfq
	 tBbTPvrQHqes+PzuUOWd3t7MQmpsXySgqr7qsK9K2sirQSFFWErSTIlsShI9YbSvQj
	 05t8bqusobbDg==
Date: Fri, 16 Oct 2026 11:31:04 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Tjark Effenberger <mail@teffenberger.de>
cc: linux-input@vger.kernel.org, bentiss@kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: Kysona: Add support for Kysona M600V2 variant
In-Reply-To: <20260926124337.45870-1-mail@teffenberger.de>
Message-ID: <3rqrn962-8s32-4op6-p398-0n9q5p7no82s@xreary.bet>
References: <20260926124337.45870-1-mail@teffenberger.de>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 26 Sep 2026, Tjark Effenberger wrote:

> The M600V2 has a different HID ID on the wireless dongle.
> 
> Signed-off-by: Tjark Effenberger <mail@teffenberger.de>

Applied to hid.git#for-7.3/upstream-fixes, thanks.

-- 
Jiri Kosina
SUSE Labs

