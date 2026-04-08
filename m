Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24E5386C07;
	Wed,  8 Apr 2026 20:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775680645; cv=none; b=UZ9nY7TsL7AwNarErIfwxD75xJN/9a7kOkSrqyzr1gGPSq/bhQ6z2DbVXftWTgq5waZuEA6jOgZFlI04NVbAMK+TApWAYeWxu7Okflb78OxWzR5mQX3Aqvf34VNq2nqjDkpp4Z3J7Sz15z0ZrPe36Y5tUjYp3XvyWcmxlDuHXgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775680645; c=relaxed/simple;
	bh=PGUuppb868T+v76/q62nTCJ4l2syLFUr5JCYMiVykDA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=eyrJivM3sGMthzi1O86nqrfz01O/J5c3Rt7SEA4eLxy7eEPjpJG0Cu4cWDoWzkh8e4/VqVbyAmar7BI3HuCDcOTksxAhBlDhnGoIWUXkulnzWC1656JRZ/rutw2amLMIKnBNfWFMuMyQdoyqWv7KYKFM0R120xpimPsBOzOKG/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvzOb37P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvzOb37P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E295CC19421;
	Wed,  8 Apr 2026 20:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775680645;
	bh=PGUuppb868T+v76/q62nTCJ4l2syLFUr5JCYMiVykDA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=KvzOb37PSpo1dsYJ5Psmh4emGptQYONUjF6dlTCNWQEgIaLaO2NwKnujLLMGGxsiI
	 Yc7BFd4dcG0qZoPmg5hnqrsDkee4M7KxV/VsMJDTAmlL6CvSgHyWpmvPqZmhdbFvcV
	 md/UNSR1vN3S/VjMvA4pPkdoWQdzwUH90N+USvVJxLf1Sgc3GpI/gihP5ls6vYTvLT
	 qI8XizBwZYnR51ACFALgyKYxYIPKCq65p/tGhVw6uI/Zx9Ojp7YSNVJ5YvfaiQJSVE
	 A7uqcwhcshZoDxkjIkkSub4Gz6KVSojlmc4Y5Lz85eit2INNaMdLn9HMhc5I3P/Gpz
	 Utro0JU13YTtQ==
Date: Wed, 8 Apr 2026 22:37:22 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Rosalie Wanders <rosalie@mailbox.org>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: sony: update module description
In-Reply-To: <20260402155915.17745-2-rosalie@mailbox.org>
Message-ID: <q44pn080-r2q9-7o0s-3q19-0roqr036578s@xreary.bet>
References: <20260402155915.17745-2-rosalie@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 2 Apr 2026, Rosalie Wanders wrote:

> This commit updates the hid-sony module description to make it correct
> with the recent hid-sony changes alongside making it more consistent.
> 
> Signed-off-by: Rosalie Wanders <rosalie@mailbox.org>

Applied to hid.git#for-7.1/sony.

-- 
Jiri Kosina
SUSE Labs

