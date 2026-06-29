Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444483F8EC2;
	Mon, 29 Jun 2026 09:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782724738; cv=none; b=pzCXImK5FL5TjpMCKq35+IJtjD2VquUHTmu2ocJBpVQFSKsGS/PX9ZsJbqJP+R5R+BA1VnsWVwtYiQiu5aQ8WeRgDq/qzdkHoo8DZaEe1zE/PyERwHe2vNg5ehxQtnmjVQOoFgwuCEEjyAVm2DtCXrPF3eYHEsm7QyHctQIoRN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782724738; c=relaxed/simple;
	bh=0ktAWpwvOiVRIYnduTILfNa1q9eZ7bG5klq2YQF07ug=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=irQjVwwikYJFd3Cvc+l+jAK5pAKDHwLw55sjqOxVVJz6iLmoRidPWH9RMLTDBNPuYokyFZv0SsYTXb+v31YL96Y0SstjpgOITPxEBMxt3cbpaRBe4pj1PrmXWJe/xhy1pPTijFYbHrjPZrK4ml2mA7QJD8L0qwLrIJ4fNwWwMJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxvRybJr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxvRybJr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D0F51F000E9;
	Mon, 29 Jun 2026 09:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782724736;
	bh=j3cGtzLYHT67m4ZlOG77HLueaDzBGaW8TBNuIJjODys=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=hxvRybJrpHILES1GQ7IjDtXPIXnDVuN1MTaqpNfxqB6xb4F+hhXTMZNReLiU1WObT
	 k7QBUIx7N4yOAuGP0CoxmplSw1d7tBvy1T4UzyoTAwP6R1tMrlWhT368Ax3KXPYu/S
	 ugeUElohobTiAT0UqEF/Fuyo5VJ3skr3ePQJDVB/pKr4noLE8+LIh69LTbbJB5BgQx
	 weowWvQygXGsqbE7ZBFaA+MdnKtBDwKZVNg/yitfqCw9ZmNZg/+JlMfEzKA7MQcidL
	 SaEVzZWTfIqKq4ChLzCyM1cfShApeAbDq5G0oiuVa+BXbX3P5wxQQY3f6IbaP8+Y6e
	 UjvGT7dsr528g==
Date: Mon, 29 Jun 2026 11:18:54 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Maoyi Xie <maoyixie.tju@gmail.com>
cc: Hans de Goede <hansg@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: lg-g15: cancel pending work on remove to fix a
 use-after-free
In-Reply-To: <178176639579.3377656.12792307991044339915@maoyixie.com>
Message-ID: <np9n823o-9543-9225-8o46-qn6p6q47s3oq@xreary.bet>
References: <178176639579.3377656.12792307991044339915@maoyixie.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 18 Jun 2026, Maoyi Xie wrote:

> lg_g15_data is allocated with devm and holds a work item. The report
> handlers schedule that work straight from device input.
> lg_g15_event() and lg_g15_v2_event() do it on the backlight cycle key,
> and lg_g510_leds_event() does it too. The worker dereferences the
> lg_g15_data back through container_of.
> 
> The driver had no remove callback and never cancelled the work. So if a
> report scheduled the work and the keyboard was then unplugged, devres
> freed lg_g15_data while the work was still pending or running, and the
> worker touched freed memory. This is a use-after-free. It is reachable
> as a race on device unplug.
> 
> Add a remove callback that cancels the work before devres frees the
> state. g15->work is only initialized for the models that schedule it
> (G15, G15 v2, G510). The G13 and Z-10 leave it zeroed, so guard the
> cancel on g15->work.func to avoid cancelling a work that was never set
> up. The g15 NULL test mirrors the one already in lg_g15_raw_event().
> 
> Fixes: 97b741aba918 ("HID: lg-g15: Add keyboard and LCD backlight control")
> Cc: stable@vger.kernel.org
> Suggested-by: Hans de Goede <hansg@kernel.org>
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>

Thanks, applied.

-- 
Jiri Kosina
SUSE Labs

