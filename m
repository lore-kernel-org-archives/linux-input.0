Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAE23BCD2F;
	Mon, 27 Jul 2026 03:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785121348; cv=none; b=tOoQqEvjbsQc7mBGteiHQ8FjgGaXh5iMnIoi5mk4lQ0Ef/lWCddqT1o+acKo4hdMLrj3WsBXVfxm4jSb5aol1oRsfM+LhDRBOYBcopX8i/XlTvi3xVM2AgTEvFB/68EHntAFP3ozBsMQbzA5D7Q1hkLNxMQp5gaWKn+GhlFwxv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785121348; c=relaxed/simple;
	bh=I5iv/F3SAmehI8bja8DsXWqKelHb81mAu/Q/B5cNgH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ToK+AoXfT8s2KnCVne6Hn/+UtMRK8ilEp/AuL7X5JHiUcD9MasWrluV9310SWUoWGsv6D7XGa11Ny22CzCHT5d/2s7SGTwNJADWOYhAVZQnuMWqlKRMSjuwDK7Celx2tRaDcfJ+dn8PcPuypkeiI1lECLJGDEbbvmtQGyrNJ5go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ge8d9ksM; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ge8d9ksM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785121347; x=1816657347;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=I5iv/F3SAmehI8bja8DsXWqKelHb81mAu/Q/B5cNgH0=;
  b=Ge8d9ksMqbffLNvSU6OQmwQDhUK8RJ4yLzxZTSmQfnL2h2mce6QhGLN1
   urxD60nYLbByQBeqZ126l8ZIQsg/QLuDXE+VuOvafSq4wejpmR17GS/5d
   cNHeKCaeb/8nh+KIMwBMhdJW7bqjNLlOKr5LHGAAFpCBToilP7DVbwR+8
   tyd7N9N0hO6lM49NuYeCSEEGHf/LkTifMJYYSQ90DX1fwzEg3PA94eSPy
   EhFegXz5XQQl1EALnrLTSTmNVX5yQ/QtLoHmJwfSzrnnb/VfEuYYulbUQ
   3iCSyvHRIFtCOOEKbxJz2Y3j0aC2cr9Dotx8L9qVnqQS/OLX2IcZPyJhB
   Q==;
X-CSE-ConnectionGUID: HsYIMCpdSoGenTCUIuclgQ==
X-CSE-MsgGUID: tDyB58kAQ8WHPboCKPD8GQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11857"; a="97200396"
X-IronPort-AV: E=Sophos;i="6.25,187,1779174000"; 
   d="scan'208";a="97200396"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 20:02:26 -0700
X-CSE-ConnectionGUID: hb3RjPKRQf6y4DBXsJ4tag==
X-CSE-MsgGUID: ovrbZwbNRcKWkpzjnDWDPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,187,1779174000"; 
   d="scan'208";a="255365081"
Received: from shsensorbuild.sh.intel.com ([10.239.132.250])
  by fmviesa010.fm.intel.com with ESMTP; 26 Jul 2026 20:02:24 -0700
From: Even Xu <even.xu@intel.com>
To: bentiss@kernel.org,
	jikos@kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Even Xu <even.xu@intel.com>
Subject: [PATCH 0/2] HID: Intel-thc-hid: Support complete I2C bus configuration
Date: Mon, 27 Jul 2026 11:03:08 +0800
Message-ID: <20260727030310.3850984-1-even.xu@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Intel THC QuickI2C driver currently configures only the target
address, bus speed, and SCL high and low periods. Additional timing
parameters supplied by firmware are not applied to the I2C sub-IP.

Introduce a common I2C configuration structure in the THC core and use
it to configure the target address, addressing mode, bus speed, SCL
timings, and SDA transmit and receive hold periods. Populate this
structure from the QuickI2C ACPI resources so that platform-specific
timings are restored during both initialization and resume.

Even Xu (2):
  HID: Intel-thc-hid: Intel-thc: Refactor I2C bus configuration with
    unified config structure
  HID: Intel-thc-hid: Intel-quicki2c: Support full I2C BUS config
    parameters

 .../intel-quicki2c/pci-quicki2c.c             | 46 +++++++------
 .../intel-quicki2c/quicki2c-dev.h             | 14 ++--
 .../intel-thc-hid/intel-thc/intel-thc-dev.c   | 69 ++++++++++++-------
 .../intel-thc-hid/intel-thc/intel-thc-dev.h   | 23 ++++++-
 .../intel-thc-hid/intel-thc/intel-thc-hw.h    |  3 +
 5 files changed, 97 insertions(+), 58 deletions(-)

-- 
2.43.0

