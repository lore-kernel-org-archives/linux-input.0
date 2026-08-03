Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BA9435523
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 19:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785783652; cv=none; b=ppf+jE8yg1rpQ95Liqmf1Alnw5lHJ8hXaisWSMMZjiCEMyftNoZj7kFnUuELGiW6FgP0CIOlLQacKM73tZCc4Qo7wVQPK+X5poQr/nBwhQlOQzFpVKs1L3yZgUmblSEGJ6BJFhS0+f4oybJEzg8QQSZsBhWZN5WJE2oS83eXgfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785783652; c=relaxed/simple;
	bh=ufzogOLsRjB/4+zQj5Ko+/zH3GNbS4P0o7ap6L+V+c0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mchALdKP84tWE+u2oPwcgLxQ2jkDYmRgTWfk2Dck2LXp3oAeFHJYF9XYxS5h3Qgw/r0MJdI++RMZ5eM3o+rO6j4Eb59ZL/DYPupigVkOcfJvDjUiOpJK5mc/if5VXCnI+9INO0n7mmvpKESYk+T2Yquaq27aAtbi9DT7kJrOSJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abR1PPVn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abR1PPVn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC281F000E9;
	Mon,  3 Aug 2026 19:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785783650;
	bh=aiRMq3KzFeNLkMpHhrH9uEyFNREMLlxG7ioAXLT+aak=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=abR1PPVnFW0+OEck9Kyfv+9gKMtll+CN8WZW2ID0r8zTa+knV5LzVFpHooNf5TlC/
	 Ckh3nAK8dMAlvpQJEQ6o3lUzqo+tib7ehMjHF1Stgc0G2uKagc9D8fVKKslXe8J3WY
	 l5aE87KfgU9wlhMHuAhtQmRuqPzGPXwOBettiPrdT3x7Fzd7bpAz94xL1YAb9sLHC8
	 i+f2IFBi3lKTk9+QAnhaDu9eYRbw90ghoQYgJFF2GRG1s8/dCum57DUw12jY69H5Ig
	 viuIhCBMMPV+XIQPTiwb+wZA86Qr8bTAMYGeKC7HVJ0BtRXxio3V96S+OqNoRsm8cG
	 Bfb2x7vuDr4/Q==
Date: Mon, 3 Aug 2026 21:00:48 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Vicki Pfau <vi@endrift.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: Re: [PATCH v5 00/10] HID: steam: General cleanup and improvements
In-Reply-To: <20260730041251.1659029-1-vi@endrift.com>
Message-ID: <38n90452-08r3-2362-3122-n54n5qrqqr56@xreary.bet>
References: <20260730041251.1659029-1-vi@endrift.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 29 Jul 2026, Vicki Pfau wrote:

> This is the first half of a patch series improving the hid-steam driver.

This series is now queued in hid.git#for-7.3/steam. Thanks,

-- 
Jiri Kosina
SUSE Labs

