Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BF32BF3D7;
	Mon,  3 Aug 2026 19:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785785559; cv=none; b=WuQDzH6641ixywGnzjq0tNW8rXNMcEZhQYJznv/EuMLeg+GdnPLO+A1AUMq6JSo85jTnCrnEZA5G0MA7IDLEGSCNGLTQjGlf+gQEAIzX908gZs6jWPr0WTJqXwpYpSjlH7oO+cyHbss++ttNQJR7DOC4E4tOzTAqtbkZ3nPCYy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785785559; c=relaxed/simple;
	bh=8xYwGwhgZAZDcN9cDIgXGGIySLfAztaTMRPXOxjSt/A=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=D9Zo09hNbMUSkBg2QW4rrMwxFlEtuSEh6S82GN57gVnkfXlA8GdaTrXfJqaA1Wop3xZEu/GOhz2wiRYJr3J3b4VJspIW1O/8M9rcKWQtJyaqi9TQIfITiZabVE8mFPuN9vFWGiKrQKEYJtnnnyuOGPZKKGR/ny6tOU593uerMeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8XXAwxH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8XXAwxH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB0E1F000E9;
	Mon,  3 Aug 2026 19:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785785558;
	bh=YFHQp8RuFkZuAsicc5nNzSlX+SQFhUKs9EzR6+l0vh8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=A8XXAwxHJHcDaamb/KaA91GLLvq4ZDvQjWocVeZ9sMiNK5KrEzqwFZEBej8ShTVWC
	 shDcai5E6cLHeQf8bVB+A3MdtWI1GgM50Eg8erp4mqjTRnUGzDqKiVSOJNqMAq3h8a
	 3ASkY1mb2t4Bqz20qZ3j/nlxletD5sKoU/Bn7mmwcdfaSvMvxHxt+Dpejhq0Z+zaC/
	 N9rRfWeCY/50GnVW+rL57ECMu8gYcMISuozAMRNpKADZZfbd8c51vtijuk98ZVBqGw
	 aW0fVMQkPTUC6u6csjm6X8xZnHitzGI0EBJWjXIH/bCMi31qOXFG4P6gCxwLEJnwqG
	 d910TjYEkr+gQ==
Date: Mon, 3 Aug 2026 21:32:35 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Sriman Achanta <srimanachanta@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, Bastien Nocera <hadess@hadess.net>, 
    Simon Wood <simon@mungewell.org>, Christian Mayer <git@mayer-bgk.de>
Subject: Re: [PATCH v7 0/8] HID: steelseries: split out Arctis driver and
 add Nova 5X/Nova 7 support
In-Reply-To: <20260803191553.66368-1-srimanachanta@gmail.com>
Message-ID: <p2ro1683-r1p3-80qs-q6s1-nr6p18ss03p8@xreary.bet>
References: <20260803191553.66368-1-srimanachanta@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 3 Aug 2026, Sriman Achanta wrote:

> This series moves the SteelSeries Arctis headset support out of
> hid-steelseries.c into its own module, reworks it around a per-model
> device_info table, hardens the battery power-supply lifetime, adds an
> asynchronous status interface, and finally adds support for the Arctis
> Nova 5X and Nova 7 families. After the split, hid-steelseries.c is left
> handling the SRW-S1 racing wheel and the MSI RGB LED devices.
> 
> Changes since v6:
>  - Rebased onto hid.git#for-7.3/steelseries.
>    - The split now leaves the MSI RGB code in hid-steelseries.c
>      alongside SRW-S1, and strips only the headset members from
>      struct steelseries_device. The MSI RGB quirk bit is renumbered
>      to BIT(1) since the two Arctis bits are gone.
>    - The Arctis hardening that came with the MSI commit moves into
>      hid-steelseries-arctis.c with the rest of the headset code: the
>      hdev->rsize < 3 guard in steelseries_is_vendor_usage_page(), the
>      battery_registered store/load-acquire pair, the !sd checks, and
>      the hid_hw_stop() on the hid_hw_open() error path. The
>      steelseries_is_headset() dispatch is dropped, as the new module
>      only binds headsets. The battery_registered flag then goes away
>      in patch 3, where the device_info rework guards every
>      power_supply_changed() on sd->battery instead.
>    - The v6 patch "HID: steelseries: Inline and simplify SRWS1 wheel
>      driver" is dropped. Its premise was that hid-steelseries.c only
>      handles the SRW-S1 after the split, which is no longer true.
>  - No other changes. The resulting hid-steelseries-arctis.c is
>    byte-identical to v6.

Thanks a lot for such a brisk rebase. Now queued.

-- 
Jiri Kosina
SUSE Labs

