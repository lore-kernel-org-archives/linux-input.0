Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C759A249E5
	for <linux-input@vger.kernel.org>; Tue,  4 Aug 2026 05:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785819801; cv=none; b=OouWJRJYhtuDqCwAnHow+DEILK7F/wo8rh3COHLWe2R/fGTfxDF9x2mLkHo84fh1xIAhQ5A3WlNSf/VxsLwMUQk4X8cpqLMLfiKGBLTlHUz2fq21LNt3OrdkEXC//UegsmvlBfRR3hGK87DnlQnwFuSGNen1qJRUA5/lfZyy5Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785819801; c=relaxed/simple;
	bh=R2VmxxTs+MpXch2wxSsqwZgW7vlIaZ+bgUcmW+Zx31M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Flb5P7BHZhaRVnGxFmXDarPBIJ9LujtkksFGMeKXocLbu2i1IevJwoOri29VHVs/mvI6ByMil2Ozgc+0dXTGNXSeppiHWascpgHSSzirVL1gPSA/C6ZYNZuopYdW0zkFIr4rKBzilsQH1hOSa5i1L+14VohHfspi2o2W3LN7vpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oT7upiHo; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oT7upiHo"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c9aea40d799so2194746a12.0
        for <linux-input@vger.kernel.org>; Mon, 03 Aug 2026 22:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785819799; x=1786424599; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/8CDi2Jj1vQpqhue3/u9PKS7MdffrHoCAeV6rBW/gOw=;
        b=oT7upiHoki1v1JkPHHAiIMCNXaXcmMB645Dp5lGcAkq0picQo0HVxlAzL6Re0W+rtj
         5xwdEwwx4M4MJYWvnruWdyQIks/Bu0qmHCa+PMi/unenKrkZJ/7xsy9StXvqRigxNY4X
         87Ido1oFpDbtwnojP4NQ4BXaLs1V1Po3sznI6ewsOP4Sbpa2LFaX8r6mQW3sBFBjxAj+
         I7HZCzWifuBpIZGgzY0u8+VX/sHNLG8deYwmnji3n2diGZSHHcqQtrM6gNS8Yod6SQ4R
         jfaSlW8727IZ/2DHORjrdD+V65Iw4proAZV8EKsHDWG/J2q7QsuVCwnmiP1cnY1pd+Y6
         OIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785819799; x=1786424599;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/8CDi2Jj1vQpqhue3/u9PKS7MdffrHoCAeV6rBW/gOw=;
        b=rEG7pHFM53qYYIfLZ1cHkhbEVdfpv2H/zN/KpOohHw9SL2yHS09Gw3Gz/XbNwrf3uH
         v/g5NSURifZhv8PmclVzcZqTuAw3DXaZtLh7Sg+kXnNVrRPP2Z/Oqn+rJkeTrVMD1OFi
         kugOo+p9XKq4imTz9tqrbLfTgzcnEpgBPRqPSNI1ERGQB5UnBsarE1LQDby4Rvtj+Mcu
         hKQrRXhYAVAzsDo9kr5DK/7toBbBQw/gaZeheVjwlZklMuJ1962PTIpoxRk7OOwQBcyi
         hRF4KHaPCW8mIdEVQTS2q2LFDyOoTfeF+r8dYHtqw/gJvo2UiPYQjn42uOtepmQ8Poov
         EfHA==
X-Forwarded-Encrypted: i=1; AHgh+RrR5Da87epmc/YOsfHqaF4PkklGmp0Ys8mgyWXqv1oEF0pXVDZnxYfm7RwZChbf3MPkfBS9oDkWC5QxAA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxNL8px1LO70sT4UtIygGnhfRnVGtIaXJhkhG37UtVeiR5Dqz7
	zUJ/PHn3P3wvXQMHOttV+wFEPeJOHXrj5F3QETsSiZDOXmNEMMK25Ibn
X-Gm-Gg: AR+sD10xYiqb66b1YHBqj9yQEQ1hFkDb57q3FAeTKx/RWfb9N8Q8ZtyOSWQSRUHT8xu
	662l1+4OWV6cKOkIjxpuhQ63N3ZdGrPpqtUEut6xrisnvc2OOWljSAhdIkjwLCkW60jxwt4jylw
	rs4CFCACkplmpbg1PQpsqTTWiFY7/g/83sI2i8yf7tC32aOPCx2U/giFbUThOa91ta2FAGfLJQc
	bBPG1gh6dl2qaP84CavUdy4tbHhO77fBCbODIpS3yM2PAqB7xGCFcumN8tNMPydy5rG955O4/ev
	a82QQuLvDp/zGnlc+OwGiF0orTjkQlgh/hshktZ6sTdj0jOrZI2Bkr7BoKGb3MExIrRqJ+GG3QW
	yrgW2NtTijTbZDULQB8IyLnVhcB7qXp2/oakgPydiP/sEqn9YlWla+SA2hnBcp8EQhQbxzJyaTK
	SP+sRumBpO6jQBqbfKn0jVe7nMy66nazJMz/i5cM8z2PT8bbL4gBFePqpR7sAM5NshOjCDfOTKQ
	EPTqKRxpWOS6/2z3FiAqEsWkOmJBxSB7u0cd2TS
X-Received: by 2002:a05:6a21:3a96:b0:3b3:1b38:d9d6 with SMTP id adf61e73a8af0-3c92a89da25mr12660784637.39.1785819799052;
        Mon, 03 Aug 2026 22:03:19 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:d109:cdba:8a20:74ad])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153db2f911sm49653631eec.0.2026.08.03.22.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 22:03:18 -0700 (PDT)
Date: Mon, 3 Aug 2026 22:03:15 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: Marco Felsch <m.felsch@pengutronix.de>, robh@kernel.org, 
	linux-input@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 4/4] Input: Add TouchNetix aXiom I2C Touchscreen
 support
Message-ID: <anFxs8grhvIVSdNA@google.com>
References: <20260703-v6-10-topic-touchscreen-axiom-v7-0-0d2a550a7ee8@pengutronix.de>
 <20260703-v6-10-topic-touchscreen-axiom-v7-4-0d2a550a7ee8@pengutronix.de>
 <20260702224804.E0B0D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702224804.E0B0D1F000E9@smtp.kernel.org>

On Thu, Jul 02, 2026 at 10:48:04PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 18 potential issue(s) to consider:
> - [High] Missing bounds checking during firmware chunk parsing allows malformed firmware to trigger integer underflow and out-of-bounds memory accesses.
> - [High] Invalid cast of regmap buffer to u16* causes endian-dependent behavior and corrupts register addresses.
> - [High] Unbalanced pm_runtime_put in firmware upload cleanup leads to negative PM usage counts.
> - [High] Firmware-controlled allocation size allows out-of-bounds heap read when checking touch slots.
> - [High] The driver prevents firmware recovery when the device boots in bootloader mode by improperly failing the probe.
> - [High] fwupdate_lock is held across system calls violating kernel mutex semantics, and is double-unlocked on error paths.
> - [High] Improper devm teardown order causes Use-After-Free of the input device by background firmware upload threads.

I am not sure this is true as sysfs attributes should be removed iand
handlers complete before we get to remove() method. 

> - [High] Use-after-free of ts->input in the threaded IRQ handler during config firmware updates and device removal.
> - [High] The driver waits on completion primitives for hardware resets and saves without reinitializing them, causing future waits to falsely succeed immediately.
> - [High] The driver passes stack-allocated buffers to I2C transfers, which violates DMA requirements and can cause memory corruption.

This is Sashiko's hallucination.

> - [High] NULL pointer dereference in `axiom_remove_axfw_fwl_action` if `devm_add_action_or_reset` fails.
> - [Medium] An operator precedence error in subtracting the preamble and postamble causes the calculated report payload length to be artificially inflated.
> - [Medium] Probe error paths leak PM runtime references and fail to disable regulators.
> - [Medium] I2C read errors are swallowed and falsely reported as success in polling functions.
> - [Medium] Missing NULL check on `kasprintf` results in a crash or broken sysfs state when registering the firmware upload interfaces.
> - [Medium] The driver lacks system sleep power management callbacks, causing the device to remain powered on during system suspend if not acting as a panel follower.
> - [Medium] Dead code in `axiom_register_input_dev` prevents failing initialization when no touchslots are enabled.
> - [Low] Typo in the sysfs `device_state` output violates the documented ABI.
> --

However there appears to be quite a few items that need addressing.

Thanks.

-- 
Dmitry
