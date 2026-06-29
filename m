Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5ECD3F8243;
	Mon, 29 Jun 2026 08:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782723182; cv=none; b=nPlqqw8N6jWAL2mq+bhMEJNvWFtOlQZC1of07+rxMTkvj5nQWWKgXMSpNN04vmD8aTjOtskylvGSBPpa92sIbeD8Yl0xM9Dy2WOPpYQ+LN68NHITXdsTzAyhR6x1rkg2QK8GCIWV6ZS9zOQBRtzoCGNfvmkJRt4+TRX4RZSCkuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782723182; c=relaxed/simple;
	bh=/9I9JsxnMoptVElbeNJwew0ZWxoUDJxDamZEI1QEvBk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KCIfpKPydpVCMYYTXt56x2209jbJSs34AyeAi3s69GA5n2CZvvI4msz0nJHQo0TQmsHxo3SkJJAEyeaj3f+3sSPSoa14tBENfaudUNJexI8CezWclaOk4b7aOuxdk1AG2vXso/FdYSN0fMZ1mNQ7uxxrTm9lerRxkK5ILqUdrzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYi6m0Is; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYi6m0Is"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8421F000E9;
	Mon, 29 Jun 2026 08:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782723180;
	bh=tfSN3uhWAHdDm6hsfrbOIduNwePRhUslARRlDY59BYc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=FYi6m0IshvdT0ls9vgB7drFx5rtZ63pJ8UZiB2leyEBPMO2+7B6dBOVUPOTiFfrfN
	 nU2E2yT4n+SsqeLkxkeFvDS/60gUPHmxaHPKnV0UwElkETQ8L+ma1qMnWxhhLRsjgW
	 QtHrJJOJNAY1KGzQvvKJP8hcGzUlO+sMEO//LOGlTsbwkw1JYT/RlBG+OORyiZ39cx
	 pSjvSF0yror1WWH974PaaU+BB8dfWJwixzgEhgxtvHcv7MhJ0anVk7k36TI99g+xXv
	 ZxZ0lcTi9z5YKTWyraiuZlSPXKV9Cjzhoshc1+pXCpzOT5N5g3wIbZ0QMOV2pcYbMh
	 AtJfkGHDFYAdg==
Date: Mon, 29 Jun 2026 10:52:57 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: David Glushkov <david.glushkov@sntiq.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v10] HID: steelseries: Add MSI Raider A18 HX A9WJG RGB
 support
In-Reply-To: <20260605175035.12257-1-david.glushkov@sntiq.com>
Message-ID: <70n30n9q-4939-3n4n-p789-o6s6r356181q@xreary.bet>
References: <20260531215204.172030-1-david.glushkov@sntiq.com> <20260605175035.12257-1-david.glushkov@sntiq.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 5 Jun 2026, David Glushkov wrote:

> The MSI Raider A18 HX A9WJG exposes two internal SteelSeries USB HID
> devices for RGB lighting: KLC (1038:1122) for the keyboard and ALC
> (1038:1161) for the lightbar/logo zones.
> 
> Add DMI-gated support for these devices and expose them as multicolor
> LED class devices. The driver sends the same HID class SET_REPORT
> control transfer as the tested userspace implementation for this
> machine and writes a uniform RGB value to all known keyboard keys or
> ALC zones.
> 
> The ALC payload uses sparse LED IDs on this chassis: 0x00, 0x01,
> 0x02 and 0x03 are physical zones, while 0x04 and 0x05 do not appear
> to map to physical LEDs. Unused payload LED ID slots are initialized
> to 0xff so they are ignored by the controller instead of defaulting
> to LED ID 0x00.
> 
> Limit RGB support to USB interface 0 and the tested DMI system because
> the KLC product ID is shared across MSI laptop designs and the key
> layout mapping is model-specific. If the DMI or interface check does
> not match, keep the device bound as a regular HID device instead of
> failing probe.
> 
> Also make the existing Arctis 9 vendor usage-page check defensive by
> returning false for report descriptors shorter than three bytes before
> inspecting hdev->rdesc[0..2].
> 
> Tested on MSI Raider A18 HX A9WJG. Both internal SteelSeries ALC
> (1038:1161) and KLC (1038:1122) HID devices bind on interface 0 and
> create steelseries::lightbar and steelseries::kbd_backlight. Setting
> multi_intensity and brightness changes the keyboard and lightbar
> colors.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202606010709.X0QYNjFZ-lkp@intel.com/
> Signed-off-by: David Glushkov <david.glushkov@sntiq.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

