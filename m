Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16813A59BC;
	Tue, 12 May 2026 15:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778601381; cv=none; b=YtGKlvOyMyLhOBEmR+QqMXn5OhjCCG+Glzjqo5ihbd+H+gI0Ca9IAowhFiA/OsV0rS1ihZFxMpfa6uD81AdUpWbuk4H+jxchLO/ZGXQ5sz8haEvxZatWSwmOJnDPGfo45Pgf+CAWQC7HweMs2MbG60OjxYVegZ/bst43wTFgIDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778601381; c=relaxed/simple;
	bh=xrgY/J5okTxRzQTtXO4kQ7NHE93ddpEZa77GDFwT26w=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GDR0UTxXJMU/jbuZl0afliZa8ncbBHPoY6AeALe1ZeIaCzLKhEgOGeIiz5KFRTWtQvpGJFJhOGS19FvZMBy5SJy9ui9Ms4B15QibiWp92EayarD5dVQ+CGV7yMeJUfPzkGTQXWCyvtc/9qtcRL/75Z390uDmCDEqwfcp77p20r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFFkJpEz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFFkJpEz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79253C2BCC7;
	Tue, 12 May 2026 15:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778601380;
	bh=xrgY/J5okTxRzQTtXO4kQ7NHE93ddpEZa77GDFwT26w=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=PFFkJpEzbLADv2hkXMSDR+GZ/2TvVvJ5/HrDZcF+1J9AuTYNSTliU9JP1Ll5p049a
	 cgNIyaFt1t4kXmkjB7kvKyJapR6+fsaCnPAsFcz3TyAM6Ra7ti0Uc/ikEKHjeUBs/b
	 ukf8k1snIFYdQzt9d6VUVIs0WhM65LcXlA8ZNHo7SoyDYAOBIAMhVd18nUpXNcTXh1
	 oCofxQYIzn6/rgxENXl+JIRimPL7MlzWE0Sr7JTmUYIf+npv0rYPVSrp7KLyuonkGz
	 fwhllDv1kz8STdH41jMculb2i9uYbuRhPwKLzK/q3qdclwIAaKRfYLIiAYcyMcbsjf
	 j5jYjTUGgXRPw==
Date: Tue, 12 May 2026 17:56:18 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>, 
    Lambert Fan <fanzhaoming@anopc.com>, Zhouwang Huang <honjow311@gmail.com>, 
    linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/5] Add OneXPlayer Configuration HID Driver
In-Reply-To: <20260419042624.625746-1-derekjohn.clark@gmail.com>
Message-ID: <q2nop225-7433-72qr-s720-939sr6s00p1p@xreary.bet>
References: <20260419042624.625746-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 18 Apr 2026, Derek J. Clark wrote:

> Adds an HID driver for OneXPlayer HID configuration devices. There are
> currently 2 generations of OneXPlayer HID protocol. The first (OneXPlayer
> F1 series) only provides an RGB control interface over HID. The Second
> (X1 mini series, G1 series, AOKZOE A1X) also includes a hardware level
> button mapping interface, vibration intensity settings, and the ability
> to switch output between xinput and a debug mode that can be used to debug
> the button mapping. Some devices (G1 Series, APEX) use a hybrid of Gen1
> RGB control and Gen 2 controller settings. To ensure there is no conflicts
> when the driver is loaded, we skip creating the RGB interface for Gen 2
> devices if there is a DMI match.
> 
> I'll also add a note that Gen 1 devices also have an interface for
> setting the key map and debug mode, but that is done entirely over a
> serial TTY device so it is not able to be added to this driver. There
> are also some "Gen 0" devices (OneXPlayer 2 Series) also use it, but
> the TTY interface also handles the RGB control so no support is
> provided by this driver for those interfaces.
> 
> Signed-off-by: Derel J. Clark <derekjohn.clark@gmail.com>
> ---
> v4:
>   - Make all delayed work part of drvdata & ensure they are canceled
>     during remove.
> 
> v3: https://lore.kernel.org/linux-input/20260412213444.2231505-1-derekjohn.clark@gmail.com/
>   - Ensure default button map is properly init during probe.
> 
> v2: https://lore.kernel.org/linux-input/20260407041354.2283201-1-derekjohn.clark@gmail.com/
>   - Add DMI quirks for certain devices that ship with both GEN1 and GEN2
>     MCU to avoid clashing when initializing the RGB interface.
>   - Add left & right vibration intensity attributes.
>   - Add additional mappings for keyboard inputs.
>   - Add a delayed work trigger to re-apply settings after the MCU
>     completes initializing after a suspend/resume cycle.
> 
> v1: https://lore.kernel.org/linux-input/20260322031615.1524307-1-derekjohn.clark@gmail.com/

Now in hid.git#for-7.2/oxp, thanks.

-- 
Jiri Kosina
SUSE Labs

