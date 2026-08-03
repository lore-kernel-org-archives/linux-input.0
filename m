Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6943538E8C9
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 17:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785779441; cv=none; b=YWIr+oG5VB+hosd5E+uSquj34aUsh1KnuvTiZ/t6yVDz2cBc5Ui66vIVGyofyBfiiP3K1cL6Pelj9rPUkT9a/QYooTIaHKA/khNgqk3bqeDtWSD0tuL8mnUSLiTAS9E1QrqK1lHdGfhSfl+rLI2tIjHVSbOVD3V9Z8BeoBwlnn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785779441; c=relaxed/simple;
	bh=NFqf7VwYGGs/Li4sTQL0Cs7agrk3v7M8/0ra1Ynv/C4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KNguT5dJRd4fpyxJDnv+WNUg6ZDj//r5FwgCYGmJ1dyaKvfXnLGePGTsUY4JS4jmbevJidG5xRnO9jZiF7NLaeFZjyyTOtiruinFWZ8VnswAuzb/aiPazwkSb067W1R2fe4MGDYEC3TckgV8xF8eBw4f9dHCBONJ3n8Qg/9/Y8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLtyzZoD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLtyzZoD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC621F000E9;
	Mon,  3 Aug 2026 17:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785779440;
	bh=0+UNBe5hEsk5JRTxyqZRzH7B+iESHeezMo+ZpxXSu9s=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=LLtyzZoDXXvRbMCeZZvWgm+9D3eg+rkSdw1FtIjD/xy2R2vJVKFJNI//GHJCnZQJg
	 GL3ybsNGeQL5lQVF1/15tZi3hJWAqjjOvo339fs/gxln8v7CeBT7g/YqLZ/pJA2Lv1
	 2jQFLCnTAbAffV0lM3NfnMjYF0JEEDrtvCJEBQB+atCDEMYSyKOD/fhU2zA0mM92jW
	 pCcghB2h5SI0LUOqLkcQrhxiICD2GDOnbFdRE0K6LA8ObzPg+7fszbqLzOs/BVCaVb
	 Qrx5thts38kJp9thWjSdaaubAqi5FCsEagRYzsM1w4NtuZIcLUJLMchPXunycvOliO
	 15pGLzv+RSbDg==
Date: Mon, 3 Aug 2026 19:50:37 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Vicki Pfau <vi@endrift.com>
cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
    Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    Silvan Jegen <s.jegen@gmail.com>
Subject: Re: [PATCH v12 1/3] HID: nintendo: Add preliminary Switch 2 controller
 driver
In-Reply-To: <20260715033409.3599913-2-vi@endrift.com>
Message-ID: <psq9p9s2-53r1-0990-9606-2o77n0267s60@xreary.bet>
References: <20260715033409.3599913-1-vi@endrift.com> <20260715033409.3599913-2-vi@endrift.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 14 Jul 2026, Vicki Pfau wrote:

> This adds a new driver for the Switch 2 controllers. The Switch 2 uses an
> unusual split-interface design such that input and rumble occur on the main
> HID interface, but all other communication occurs over a "configuration"
> interface. This is the case on both USB and Bluetooth, so this new driver
> uses a split-driver design with the HID interface being the "main" driver
> and the configuration interface is a secondary driver that looks up to the
> HID interface, sharing resources on a common struct.
> 
> Due to using a non-standard pairing interface as well as Bluetooth
> communications being extremely limited in the kernel, a custom interface
> between userspace and the kernel will need to be designed, along with
> bringup in BlueZ. That is beyond the scope of this initial patch, which
> only contains the generic HID and USB configuration interface drivers.
> 
> This initial work supports general input for the Joy-Con 2, Pro Controller
> 2, and GameCube NSO controllers. IMU, rumble and battery support is not yet
> present.
> 
> Signed-off-by: Vicki Pfau <vi@endrift.com>
> ---
>  MAINTAINERS                                   |    1 +
>  drivers/hid/Kconfig                           |   11 +-
>  drivers/hid/hid-ids.h                         |    4 +
>  drivers/hid/hid-nintendo.c                    | 1277 ++++++++++++++++-
>  drivers/hid/hid-nintendo.h                    |   72 +
>  drivers/input/joystick/Kconfig                |   11 +
>  drivers/input/joystick/Makefile               |    1 +
>  drivers/input/joystick/nintendo-switch2-usb.c |  475 ++++++

Dmitry, can you please Ack the drivers/input/ bits here?

Thanks,

-- 
Jiri Kosina
SUSE Labs

