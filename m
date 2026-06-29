Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF9B3F7882;
	Mon, 29 Jun 2026 09:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782724602; cv=none; b=rtItIYJ8r0GqPvvV7dLpgDgwAt3wBwuirH1djR9eW5QKthqat9Rci4tZBsFLe38YzoSmyDD4aynWUpcha37W+3kM90m+4kLc4kZU1Du7YXN84KIXuVu32D0xDihbg+uBgLcyEET/4KFO4I5apyAoutztFYTBAitvL09ubZr16So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782724602; c=relaxed/simple;
	bh=CPd26iAEjV6pmohRJC+w1y4DKhzX8Mz6nAvw2ZtutZE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MKaQdTgVIh+rSPdQh9Ls3oIzYGpvDS3zNdBoMeJ2wVAnM1Ghy5GSqtjeyJezSvT3gDgNhRNsBtzwQt0x/TB6GAmSnT7ReJd4mT+RLX2+sHBJicWpVCN99YbgcKHlfi6WYD3thkZULDvYdwozXKUyP5W1ObK+4i12/usJFKc2vZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2z/Zfj5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2z/Zfj5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C36F1F000E9;
	Mon, 29 Jun 2026 09:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782724601;
	bh=hgREAGn8S4b19ytXlnU6SUdthhVjY+reJMr8/tiL8ts=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=L2z/Zfj5NpDDUu952ohp8AbHYLZE3qhHaVRLb/9OgEeybiJLwxpbNAhY4Paj3YWgj
	 9lt5JBysWWRDiKBpgmlfUm6qWnq7tJxCTRQ+g/5uSTq4CtC/moNrsKgfiiru2QqXb/
	 zsLyiGh4Lhwnzxh3B1rF/jg8YIA+BcaLSyX/fEj5P84HPp+PuY8/k6/dwOHTFPxEAr
	 ifEqOdrGD5FtpUenJWp8ZQ1R4QfcTjIRCqm2nH7DQQGjbzj2Q1pfx4JHwf4WpPmFu9
	 W+kXo35nzgcmuY4xwevlu8Z7SBPxUGYtjbLwLcAK8BSvbD55n+BLC7DtIo6kprlR4Q
	 AKO49Val0+nxQ==
Date: Mon, 29 Jun 2026 11:16:38 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Michael Bommarito <michael.bommarito@gmail.com>
cc: Stefan Achatz <erazor_de@users.sourceforge.net>, 
    Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] HID: roccat: bound device-supplied profile index
In-Reply-To: <20260618030036.1880139-1-michael.bommarito@gmail.com>
Message-ID: <r6nrp458-n74n-npon-p795-865p259n73o7@xreary.bet>
References: <20260618030036.1880139-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 17 Jun 2026, Michael Bommarito wrote:

> The Roccat Kone driver uses an 8-bit value taken straight from a USB HID
> interrupt report as an index into a fixed 5-element profiles[] array,
> without any range check. A malicious or counterfeit device that claims
> the Roccat Kone VID/PID can send a "switch profile" report with an
> out-of-range value and make the driver read out of bounds; the same
> unbounded index is also reachable at probe time from a device-supplied
> startup_profile field. The read result is stored in actual_dpi and
> exposed to user space through the actual_dpi sysfs attribute.
> 
> Michael Bommarito (2):
>   HID: roccat: bound device-supplied profile index
>   HID: roccat: add KUnit test for kone profile-index bounds

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

