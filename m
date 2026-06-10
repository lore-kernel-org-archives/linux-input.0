Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8192E7631;
	Wed, 10 Jun 2026 15:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781105736; cv=none; b=k1d4GgrzuTn3gVSSzAEN9vEQwme5A5LItFC/Y6dv7+2TzFBFhUVi+1mqLz8Epldr+tQXfrdiy5iG6mndVh6N/qHY8totpeXKOYBvXKKjBI3qNu1CFeIwL2ADZsGCwXoK1xkyrad5jWWRk4wEgs32Gzrb/UlqPcJg6m40K0xoS1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781105736; c=relaxed/simple;
	bh=0P6oViHWE+VkgOOA7L73NiuNfmXMAJkjwebGYJjg2qw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QeryWv+vuyrzlOIh3EZ1da4S8faNX8msrUvUlWJcGJgu2ZrJTPTcNcjEX9ltC33LpGaHWOLgbUZ0hFmworrLXhPJXxtdaCB8PFGVqZFtle5a8IgowPBlyKad/Nf6nVufWDKC7gqyhF9NzCYuoyOD8MRSmC3sAduuc24UZc+fwo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrjR13aE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrjR13aE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CABC1F00893;
	Wed, 10 Jun 2026 15:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781105735;
	bh=ZbW7i4PwZavtIZUj7RLCT22+wFWoQxCRF0xLTzk2MQM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=lrjR13aElRUN+yQc9zzMSiY19esQY5NmnI+T/U+tIdQ9Uyf1aLVkvLDp5DxRSbyEk
	 fg71tcmE/ofza+w8gbVCeIWZdh0c2V6c2PCtlNIvPMOz1bd1qLCx86ymAZd5yczcJR
	 fRvxxk7ROu0arOJo7A7BAL9OWM/akBTPmeOJwvx8wNVFC9lWZ1L4zBzaazdkfRBAlT
	 4U0VwfQUqTneoF+bxojfxfZda9yHPv0/R3KiSJVEM2eRRy+Zyv9iljLP0zJuUehsRq
	 9B+FWQGuxybpGYGEQF71vQs7TQCFW6qaOZMXU4K4VFdHp+qCrYIqi+3vZNPHUhbcRp
	 TNAtCvEOqwHog==
Date: Wed, 10 Jun 2026 17:35:32 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Danny Kaehn <danny.kaehn@plexus.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Andi Shyti <andi.shyti@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
    linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
    Ethan Twardy <ethan.twardy@plexus.com>, linux-i2c@vger.kernel.org, 
    linux-kernel@vger.kernel.org, Leo Huang <leohu@nvidia.com>, 
    Arun D Patil <arundp@nvidia.com>, Willie Thai <wthai@nvidia.com>, 
    Ting-Kai Chen <tingkaic@nvidia.com>, Bartosz Golaszewski <brgl@kernel.org>
Subject: Re: [PATCH v14 0/2] Firmware Support for USB-HID Devices and
 CP2112
In-Reply-To: <20260520-cp2112-dt-v14-0-b1b4b6734b6f@plexus.com>
Message-ID: <5q3963qs-r9nr-3qqp-5n5s-13r635pss576@xreary.bet>
References: <20260520-cp2112-dt-v14-0-b1b4b6734b6f@plexus.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 20 May 2026, Danny Kaehn wrote:

> This patchset allows USB-HID devices to have Firmware bindings through sharing
> the USB fwnode with the HID driver, and adds such a binding and driver
> implementation for the CP2112 USB to SMBus Bridge (which necessitated the
> USB-HID change). This change allows a CP2112 permanently attached in hardware to
> be described in DT and ACPI and interoperate with other drivers.

Applied to hid.git#for-7.2/cp2112, thanks.

-- 
Jiri Kosina
SUSE Labs

