Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD4E2E1F06
	for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 18:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781114799; cv=none; b=hNLb/Tv2ENgmZshEUfMqPc8FRj6Bq1Ym0UsCxi+6XO4Ps3P9VQiZXuGfCiQ0UzICXdgktevLhPvZjMi8Yz/I6jysr1SWraRX6b9WM3OWAId8a4k+7TPKj4kAgWlib7njYyFbUjcelVGE8QQg1vxL0t5ZdL+0wLCr3+KIMu5G1JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781114799; c=relaxed/simple;
	bh=OgIidfQUbVTC/I+hzPW3Otx/fplgxpx33I9IeDSm+Y0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fnVrjGBZdn4jWcntX+QMIgH1Fvnh4OTc1HYkx9E0LapHvnzHjWSH0YCEmrnnXUJX5+2t6DFgbF15qvFadezZDlnK3WOpEnYz8uCVbo6aDMIQ/QIUEadgZZFkRuDRY0lY2NDdJU+FH91gMFhDKqjCG9vN1VNqIBn5ebiryrv5VnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EauPuoJf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EauPuoJf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85AA31F00893;
	Wed, 10 Jun 2026 18:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781114798;
	bh=aVQDpRcgMeO0V/hr8rGCwo0HclhJj91tPKxoQ17RMXk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=EauPuoJfI6heMH8v/omUB5TFh9EdhgQevHi285jCA4ml6xIL1uWxnQq+NB/ptoZ+K
	 E0XC0fCjjIC+xMiouCjP8UvFQQiG8Y8np01STT0g4altVrxD64RvJiBCrkZZvPVWT5
	 x/4bar2DJBwF2F/YX1jp+EquDM6Jhk5Ba8vlg1LMKHSIafuBitS136171dRDyGuKKP
	 /eEkYY5aZyW6d811N/vYBc2FK9lg3a2SCYNMCMMziV14S3fyqC9j9Ut/CB2UbwS410
	 fMp7kFymda4ktSDBDN9qYzesunY8BXn8MFlXk9Q8h2mfx1QWqhGkVxLWcx0cuyRDXQ
	 iqgyikdMTFr1w==
Date: Wed, 10 Jun 2026 20:06:34 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Paolo Pisati <p.pisati@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org
Subject: Re: [PATCH 0/7] ASUS Zenbook Duo keyboard support
In-Reply-To: <5sn10614-2s0s-7r22-s9p9-5np4921p047n@xreary.bet>
Message-ID: <2r449o0s-44r6-4oo7-6s08-2o782r9pq3q1@xreary.bet>
References: <20260513163248.16483-1-p.pisati@gmail.com> <5sn10614-2s0s-7r22-s9p9-5np4921p047n@xreary.bet>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 10 Jun 2026, Jiri Kosina wrote:

> > Add support for the ASUS Zenbook Duo line of usb/BT wireless convertible keyboards.
> > 
> > This patchset is a collective effort, gathered here:
> > 
> > https://github.com/NeroReflex/asusctl/issues/25
> 
> Applied to hid.git#for-7.2/asus, thanks.

And now dropped due to build breakage reported by Benjamin's CI:

	https://gitlab.freedesktop.org/bentiss/hid/-/jobs/102074691

Please fix that and resubmit, thanks.

-- 
Jiri Kosina
SUSE Labs

