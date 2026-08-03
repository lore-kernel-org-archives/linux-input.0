Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8C5357D07;
	Mon,  3 Aug 2026 18:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785781970; cv=none; b=YeNAH5tFIVanFchCtMRFOmr6vJdefsD2doSwU4lu96GWUbqchDkrvtI5G0igPbToe0dTDhLpgGzjE/PldUiaGbm4Y37YZ8y1z/CWjXBA7RUrJsON9Z2kLYp+lByJwb153wjdOzPtFl/sx2wbc76YS03vzLuUZ9OmBGwRCeRH8jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785781970; c=relaxed/simple;
	bh=BCbASCybN56BT3oY5+9L4vXGd8H/c9B687zgRI2bF0c=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IMTATRhKgQZt7iojGaIQBMmMDrqGhlarXI9/2nkWvdkD64biSXIBqaJKia343LxZS0NunW1vMvtW5QU9QjhMwL5Osgnnu8SY/F6IjujnWA8G7rwP0cZYDmZR06gXSHLm7F2KZuUkXyc5hNept73HliYnGj4ye4MRtD7/xB0IbrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVbsqoaX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVbsqoaX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A511F000E9;
	Mon,  3 Aug 2026 18:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785781966;
	bh=zplmEX51jNCDAo6A99F3dLa2Xh2tXvzspe0ZYy6m/oI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=WVbsqoaXTHRTrc8oUZKXcOGosd0ANOBDlZjzhbGdb13WEirc7nTAFbf+bBMEYivsW
	 ZPuTeXa2YKZxk6l3tM8blTlSjH/AXyhcFYqEZm3TJ/EX6wC3yZLoVlhCiXXnbk8KAv
	 6+kjkqauZPbBBrGJ4vslG4gz3tifyH0UJW37omXJnJZwXJRDX+4EO413Wz0jJFuB8D
	 pYc9Agq4vgVnCP8nCqEzg+6dIOwCp9sDEyCMNyhauoC2hqaWT19Lh6wXHTX+SU370I
	 2zgc/ND1IHsrDRHqKY4vnFuSJTVhxCvUfaN06uVpDVNzJzR8/nuESyskSYpAQ/oarm
	 PvTJhyFSUdBZA==
Date: Mon, 3 Aug 2026 20:32:43 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Even Xu <even.xu@intel.com>
cc: bentiss@kernel.org, srinivas.pandruvada@linux.intel.com, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] HID: Intel-thc-hid: Support complete I2C bus
 configuration
In-Reply-To: <20260727030310.3850984-1-even.xu@intel.com>
Message-ID: <r60q2282-q1s5-2nrs-qp71-s565qn220qrq@xreary.bet>
References: <20260727030310.3850984-1-even.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 27 Jul 2026, Even Xu wrote:

> The Intel THC QuickI2C driver currently configures only the target
> address, bus speed, and SCL high and low periods. Additional timing
> parameters supplied by firmware are not applied to the I2C sub-IP.
> 
> Introduce a common I2C configuration structure in the THC core and use
> it to configure the target address, addressing mode, bus speed, SCL
> timings, and SDA transmit and receive hold periods. Populate this
> structure from the QuickI2C ACPI resources so that platform-specific
> timings are restored during both initialization and resume.
> 
> Even Xu (2):
>   HID: Intel-thc-hid: Intel-thc: Refactor I2C bus configuration with
>     unified config structure
>   HID: Intel-thc-hid: Intel-quicki2c: Support full I2C BUS config
>     parameters
> 
>  .../intel-quicki2c/pci-quicki2c.c             | 46 +++++++------
>  .../intel-quicki2c/quicki2c-dev.h             | 14 ++--
>  .../intel-thc-hid/intel-thc/intel-thc-dev.c   | 69 ++++++++++++-------
>  .../intel-thc-hid/intel-thc/intel-thc-dev.h   | 23 ++++++-
>  .../intel-thc-hid/intel-thc/intel-thc-hw.h    |  3 +
>  5 files changed, 97 insertions(+), 58 deletions(-)

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

