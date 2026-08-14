Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E733D093A
	for <linux-input@vger.kernel.org>; Fri, 14 Aug 2026 13:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786713114; cv=none; b=UEh/+Ul+cMifEGZ88fzjwZyDztJjOpw7e8y6sJPYg9smxoaSYweEKvUxdW3rwKXwZ/qrVMNsE/PQNIhzQmpOw/ex48PA3KDLdJ6wypo8d8KwOnuswK7yNcScS4DsFP2VOcuNBMnqMqLVxZVy+u5ivFxMVBhkkBVtSD1hBlnKh3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786713114; c=relaxed/simple;
	bh=bQZw8DRnMFh8tVFX3FQsARwldiOneIpfrJCwTAKjxmc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EsN3OOQQBvoIk2qyGPnQnNSawkmhID7VD+mPLmBtUbxeQoDuDxNJh4gDKRtWjUtM2f+4iilr4t5EpyogJM8Tn1A56KcaAqD+WjKoHbriOHwpPHBpCTFvBddP4DAPHGVjx/MFUuEsbJykcvfP9CoPS+hXmZB6BZLVTPIODKm1/PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQXlCpke; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQXlCpke"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C211F00A3A;
	Fri, 14 Aug 2026 13:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786713109;
	bh=euc3t0C4oiz+rPa/aflJKVwLjeE3e30Giw5QXzDfntc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=HQXlCpkeA6rv8N8hHEfKXJYnOw4PIMuE0o5UJ3CBK7M8CYFN2iBK0no5SBLaX83LI
	 moGp5w6mfxWAjzcQ4K/UxYGMeGZ2tJULtOwImsn0q83vdi/rwl9ystUeb0B21YoUHb
	 NtK2nEApIgafYLbcoEFmjWKlA9dbD/kofZ7PRMnNrRsq9wFBVEIax48gxwnDSfCpwx
	 YZ5JCdCpkqg9xh6UDlsuKuG6fQ5d/OqxCEXfTqaNcSbSMcdX2TKaKg3+NY0sZo3Is7
	 hI1LTZllnMmr6XYV1aLjK7yUfMwo5IHRSM9BclxNJI3W6hrLWDimuQPe5pOjmxvPXz
	 4/8+6gxjGXVyQ==
Date: Fri, 14 Aug 2026 15:11:46 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Vicki Pfau <vi@endrift.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org
Subject: Re: [PATCH v5 0/6] HID: steam: Add 2026 Steam Controller support
In-Reply-To: <20260812011401.3250968-1-vi@endrift.com>
Message-ID: <1osspn48-6o3o-qp6r-o6n2-7qn271oo2o9n@xreary.bet>
References: <20260812011401.3250968-1-vi@endrift.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 11 Aug 2026, Vicki Pfau wrote:

> This is the second half of a series that modernizes the hid-steam
> controller. It adds support for the new 2026 Steam Controller, with feature
> parity compared to the 2015 model and the Steam Deck drivers, as well as
> some smaller cleanup. The biggest cleanup is cleaning up the somewhat lax
> locking practices, but a few more minor things exposed to userspace include
> logging improvements and zeroing inputs when switching from gamepad mode to
> lizard mode.
> 
> This has a little bit of code cleanup and fixes some lock safety issues.
> 
> Vicki Pfau (6):
>   HID: steam: Refactor registration
>   HID: steam: Initial 2026 Steam Controller support
>   HID: steam: Fix wording of connect/disconnect logs
>   HID: steam: Don't set feature reports when disconnecting
>   HID: steam: Clean up locking
>   HID: steam: Zero out inputs when disabling gamepad mode

Queued in hid.git#for-7.3/steam, thanks.

-- 
Jiri Kosina
SUSE Labs

