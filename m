Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5BB399340
	for <linux-input@vger.kernel.org>; Thu,  4 Jun 2026 20:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780604826; cv=none; b=DQ5pKR+zwamNyUOMwV/zh2YdCuXdAtrr4NpCvSQr99nUhlD1ddUWpNvU+4U43R4run9pbEY74WVyOFhe5M7ILA/3IHxT4QKfgb7dEjT+x2qAopgJ2LvyDBNsH9facOSAYsTXLunDp80jvWX7qsmPnKktS6d1en8kzMzODkfGFO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780604826; c=relaxed/simple;
	bh=Wce5xGa/nLSLqGMURGpy4Ao2T2nkLcD9GtxfRyC3InY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s3MJEIrRl7PqpD1CP6PP5mNjkcRce1kaLzLjYVgQpBtQ7p/xWlO2jskhycr966jk2HM0CK0rRknMdBSxC8+yeF14JfqvALftO7XE4VuFp0k76Zak6HayXwo++3CC7QWL6msvqW4/raCrhoK9t85Cc6H4kjHvXl0sFF0j3NxcX6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WDgWzmgK; arc=none smtp.client-ip=209.85.167.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDgWzmgK"
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-5aa68d7d757so1347835e87.0
        for <linux-input@vger.kernel.org>; Thu, 04 Jun 2026 13:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780604824; x=1781209624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DoIRyWg6RlmfL4adV/AmFkchSnn0ZkhyqkOhiIb6Q6o=;
        b=WDgWzmgKpVbIAyi5zs4k0MAWCe5VSIL3hmYSA8bLLrV0f65PKrd1pHPDLruejZSI2v
         1X4cgJROHAj6JlcTszOiMww4kJx1w0QCZf6RbszgeyLU5qKtnL9WBnKcG34zr/uJxcHv
         CNmG8t2oPuvEtF83QPZ7JZ+5SBEuatfgfVZry7nbQGaAF90g4kWnxdg3orw8zNI0vVRk
         nxH42ctLPRyQpbX0vfUsJuhOviB3w2Z3rWy4gPEHiEW311LzW/gu0EBfespJbjTYSiN6
         Dt93m9jWxmuH3gf2NvtJtp6qxawPZZdc/2nnEvhkKcELfQf9C+DTCSOXbZZwMSnC23wX
         Ajsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780604824; x=1781209624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DoIRyWg6RlmfL4adV/AmFkchSnn0ZkhyqkOhiIb6Q6o=;
        b=ZNrffL8WiYGaKPoPidXksJN7m8KMc+pCSqZEn3jVHv+/tGBMJKuWROec9D80uGxqVq
         ZH5YyHZEPeqCYhRlSCpPvxRjXm4o+zt2Uxquk11EsY0IScFM+Dw4qVPAsQ2Y9OOe/cbI
         3fX5pqw5AhqKfKylfxsiIO9i1yxhbJPFuTlIIvRp93ivyX7F52iCsSbF+hwKnHsrEefL
         7GzwuOeqdWYTjH/jx7Dbm+JsO93/icxI4F1d701hl5skSNM4tgxvcjom/mu0L9md470C
         I4hvIBUfudBNGb8lgw94xIS9KbovFFc8y/PPsTECJLCh2YqFLvAkJLr8WuDBpX8dZJcA
         TufQ==
X-Forwarded-Encrypted: i=1; AFNElJ+ynmrMGFiqbhu8yhpKJAiQKerWVRX4tZf4dOQHIqnTTUujXz2PsUnaCjkdwCnYbbcHShOYlxNShPHJQA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu64OKYSm0/xsc71rp8HB1sJyoNS2pmw9I9VSmu+5StH8w+2JB
	ZbseewMwZAOYjpQfR1Xwag31SHZ61FB+7mxzGQ1pHqKQA7dfuvRjIMOq
X-Gm-Gg: Acq92OEetMvOG0BypOqvLCLWMB/TzXFXseKnG5kn2ISxLCZ8elU4tXE9IcYcJ+utzVB
	gPVjdufmwgq+xm/8ekpR5PfdtxOEpUm4MOGhC03KoU6OCzZZMfxMvUp6qy32FRIV723pA93O2Yy
	5wpcmrAE3p30v2YbCbRK0mY9Wc5Ju0elFXSHS01kF44bDSVpG78dvpMOxg2T0g49ukMIz6mS0/x
	jPkrk+dfvImjJ1OBYfjQcWFdwQfNRqsp6W/11UZaVUDgfbvImYVLfowe+hlawZxQphXyrqe3ZIl
	Y5Mm/E+Ssd4T3uCW48HVfobPlyrQaFDrIVZjxnahVYqCS1gUgyX+oIFGL7tXEXMn1bjaEOHc0Zz
	rt+gAj2iyCS+VNNwB9ftoykj0K8jvmcdVeGFGmD9R0eHpwZat+pnv4FiOq7sGp3CxqI81zAnosd
	bYr/DBJi01PRmNplJq7ZQzHDbYSx4Pqf7Vew1NfWvt+9szc3rBQBEzhnSnzR8l0oMrIw==
X-Received: by 2002:a05:6512:4158:20b0:5aa:6f89:9378 with SMTP id 2adb3069b0e04-5aa87be9785mr77648e87.33.1780604823357;
        Thu, 04 Jun 2026 13:27:03 -0700 (PDT)
Received: from machine (host-176-37-220-32.b025.la.net.ua. [176.37.220.32])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b906a83sm1427292e87.33.2026.06.04.13.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 13:27:02 -0700 (PDT)
From: d3z <d3z.the.dev@gmail.com>
To: even.xu@intel.com,
	xinpeng.sun@intel.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: "Danny D ." <d3z.the.dev@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	abhishektamboli9@gmail.com,
	sakari.ailus@linux.intel.com
Subject: Re: [PATCH] HID: intel-thc-hid: intel-quickspi: reset touch IC on system resume
Date: Thu,  4 Jun 2026 23:26:46 +0300
Message-ID: <20260604202647.16777-1-d3z.the.dev@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <IA1PR11MB60989CC8623B35747E0EFF7EF4132@IA1PR11MB6098.namprd11.prod.outlook.com>
References: <20260529222210.1532876-1-d3z.the.dev@gmail.com> <IA1PR11MB60987CB2D72FD1701951DFA4F4152@IA1PR11MB6098.namprd11.prod.outlook.com> <IA1PR11MB60985B856D77963E2DBE47F9F4152@IA1PR11MB6098.namprd11.prod.outlook.com> <20260601213047.115271-1-d3z.the.dev@gmail.com> <IA1PR11MB60985A7B3D9EA4583C2DDBF7F4122@IA1PR11MB6098.namprd11.prod.outlook.com> <20260602151317.27768-1-d3z.the.dev@gmail.com> <IA1PR11MB60989CC8623B35747E0EFF7EF4132@IA1PR11MB6098.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Danny D. <d3z.the.dev@gmail.com>

Hi Even,

Good catch on the missing state restore. I rebuilt with your version and
re-ran the test.

This is exactly your proposal: reset_tic() after thc_dma_configure(),
then qsdev->state = QUICKSPI_ENABLED, with no thc_spi_*_config and no
thc_ltr_*. I built it as a module and swapped it into a clean
linux-surface 6.19.8 on the Surface Pro 10.

It still doesn't survive s2idle - touch is fine at probe, but after one
suspend/resume it's dead again. This time resume() fails outright instead
of coming back quietly broken:

    intel_quickspi 0000:00:10.0: Wait DEVICE_DESCRIPTOR timeout, ret:0
    intel_quickspi 0000:00:10.0: PM: dpm_run_callback(): pci_pm_resume returns -110
    intel_quickspi 0000:00:10.0: PM: failed to resume async: error -110

So reset_tic() can't complete here. It clears the reset handshake, then
times out in quickspi_get_device_descriptor() and the whole resume bails
with -ETIMEDOUT. The device isn't a wake source on this box - "Can't find
wake GPIO resource" - so device_may_wakeup() is false and we're on the
reset path, as expected.

And the timeout is the THC, not the touch IC: across s2idle its SPI
input/output address and read/write config are gone, so reset_tic()'s
descriptor exchange has nothing valid to run against. Reprogram those
first - the thc_spi_input_output_address_config + read_config +
write_config block, same as quickspi_restore(), same as v2 on the no-wake
path - and reset_tic() completes and touch comes back. That's exactly why
v2 reconfigures the THC instead of only resetting the IC.

One more platform note: the SP10 never reaches S3. Firmware only offers
s2idle - mem_sleep is just "[s2idle]", with no "deep" entry to select -
yet the THC still loses its context across plain s2idle. So a reset gated
on S3 would never fire here, which is why it has to run on the ordinary
resume path.

Thanks,
Danny
