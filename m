Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72BE3D3CED;
	Thu, 26 Feb 2026 15:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772118644; cv=none; b=u2VwX1JW3JFi/u+ZnhW5ERVgK47lLdiMn6fn8GfjNeopK+gN50Rlq5AvTfkQqmSf8nw2LkiNg8iG480WL5DoziFHGhnkx3EzE0RWQSUz1XZPUgpSPMlDyf6VydhO+DiwMJ9TYqvnkui+7eN8R77EuiKzx2beXaGwIySevqotIi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772118644; c=relaxed/simple;
	bh=TvAev/3cBG97AGmYkhFH3gISkFgzBG3p/hGY4h5bEIs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sMGlWBQcIAt+Is5Ad6q4voa2E8mZNVF2ntZmXvn+IibbBh+w/Jrl5KOtLj+fJUaIZ3ayf+WRlIIMuIDYmMPhU+pCwZDfqkp3LThMXVKWVF9YBU6iTOOGQWaTyrC5Yz+oyW2MjnTSkxieMqojI+PFUUHv7E+XWRRAhYP5goHvOvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1ymK2YI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1ymK2YI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05E7C19423;
	Thu, 26 Feb 2026 15:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772118644;
	bh=TvAev/3cBG97AGmYkhFH3gISkFgzBG3p/hGY4h5bEIs=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=K1ymK2YIC7lTSOZnnUzWKgHFsvdQd/18dfzFnrl+avZk0VvL+fFWsjgMdfgGuHunh
	 raepu43YR4XPGWmVobDltqAywbcSdHQExBvo4tCnj1Iv3LeETSHldE/I6+1xmXYgk9
	 3oFOwydImMOieqq7gzjNcD+u1HN2RaVPwvmzc1FiNF1fDonBtdxtGXLusoPOjefess
	 HkoyDfOC7d/9bwst8Lzb7KeZSCSov9SG+Hc1bUdfk2hz9R1bfqYw3RU1UDp8YPFBAr
	 QKfuvFG8lQ5M6A9aBcepKElIQVkPe5OjN49yhpMuDiDlINJ77oCHobZhFthjjPwM0m
	 kOknmTkVCbAdA==
Date: Thu, 26 Feb 2026 16:10:41 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Werner Sembach <wse@tuxedocomputers.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] hid/hid-multitouch: Keep latency normal on deactivate
 for reactivation gesture
In-Reply-To: <20260108161139.32681-1-wse@tuxedocomputers.com>
Message-ID: <66so1p98-rr8s-5rs8-3oq0-37354p0810ns@xreary.bet>
References: <20260108161139.32681-1-wse@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 8 Jan 2026, Werner Sembach wrote:

> Uniwill devices have a built in gesture in the touchpad to de- and
> reactivate it by double taping the upper left corner. This gesture stops
> working when latency is set to high, so this patch keeps the latency on
> normal.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> ---
> V1->V2: Use a quirk to narrow down the devices this is applied to.
> V2->V3: Fix this patch breaking touchpads on some devices.
>         Add another device ID.
> V3->V4: Readd quirks formerly applied to the devices via the default class.
> V4->V5: Fix whitespace error.

Applied to hid.git#for-7.0/upstream-fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs

