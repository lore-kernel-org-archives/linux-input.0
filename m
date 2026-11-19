Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795104188;
	b=StAKRsouO2YlH/sPYHqKt5VvDtA7/EVDKvZwhjWYwu0XbPaIHel09bMb0+3FgwuG0vOo
	 EPsKO2FAC6IKCiM39cCdIctjGoRaxV7N+uB75Sk5zVrilaD/lmUUEXDJK1ej25F+ROfvN
	 2y/0ox8RpkrMMxqTvm2xUNi1uE3Bpl45MW+xiUWohxGETgVKaXIRj6Xjo2GtI10Q8psed
	 WrGfE1AgEEppLcZbWdl9XHj8szh9ow6ttTXbLi53S2EJDB886ey9HKjMzzSPOOuRShuj2
	 I17FNOvfcF8mHhzeLPVhjrNGBfumpJj8rUR648asz1272Grm7y1bqKroEdhYcAspLPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795104188;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:
	 In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=4zi2JWHeWfDfX39NlxX3oX9HxXWlhyFS95IVW8A7s5g=;
	b=tbnEo19vYvGIH4nFbojHi+IdMuUGJ+eUu27kLhI0ZfSADieu/hajuavxgplKE0rUAwcf
	 D1LzZeUrEBQDvURh8vRQ8RqoagNBb4Wm7iYM+/vlMb8IJl+29r2bnPhC3/5/Vton0Jz8E
	 8ledknDJzjIj286hAq4rUNqEP6Hrw2DQsYxI1f47DLhopjMPZpD5C1P2EAmohd9NxEcG5
	 rzuTXI5m4oo/DWRYhbX++AJffD94NWY1dsKF9gc2WToX3QKUV57U5584vDA3Fiiu9c1a9
	 WNag2/xLIdH0Jpkft//EWCn3AUr00YiPc0xRFbIz7zYZm2O4K8brflRhN0jtYKKqu3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=N5giJBrI;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8C8606A325;
	Thu, 19 Nov 2026 16:03:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C8C8606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=N5giJBrI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795104188; x=1826640188;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=r0qzl1l2ZjBbaSVw+4tulftWf87xepvCgmvPesxSJqU=;
  b=N5giJBrIl4oTng7dIlXEDzaIMfdioMAdVrKAJkt5tqF4XzHsWSaqgS/9
   yxYhhgqeEs+bj7TvDjZfbgF566tM4qa9cUvHu1xytGmFameEnRxiK68in
   1u9K0M4IHgtmj9ZTfXznwCRgakka1snTIJ5epX2sabf49MU4hlRBqmxIo
   RXWpon2Cl0x4OFAXZ4WMuaWTP43clpK1BUGDtWHxLVyBnSSvsXsER4Rh7
   CRFjgchoUxAxc70cyBZh1Yl4iUdoRP/9rhGH7srF2xU/U4CDJIepis5qd
   gW3nkiAho1tgF5HbEpkb0d2VX9VsPF5HYfaQ2f7OBsf5PiuCTG0SlbeEk
   Q==;
X-CSE-ConnectionGUID: mno0lg49QGOicspK9uizig==
X-CSE-MsgGUID: kzF60MdMRvqu2B5O/awMUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3951233"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3951233"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 08:02:55 -0800
X-CSE-ConnectionGUID: jJS52iEIT6iakYqFwr1/AQ==
X-CSE-MsgGUID: mQv+4zpvTbeL+TTVy1a05g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="10459450"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.132])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 08:02:50 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Mika Westerberg <westeri@kernel.org>, 
 Andi Shyti <andi.shyti@kernel.org>, Corey Minyard <corey@minyard.net>, 
 Hans de Goede <hansg@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 openipmi-developer@lists.sourceforge.net, 
 platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
In-Reply-To: <20261024-i2c-smbus-read-block-data-v1-0-19bb97467982@gmail.com>
References: <20261024-i2c-smbus-read-block-data-v1-0-19bb97467982@gmail.com>
Subject: Re: [PATCH 0/8] i2c: convert i2c_smbus_read_block_data() users to
 pass buffer length
Message-Id: <179510416419.21358.12676315877277601381.b4-ty@b4>
Date: Thu, 19 Nov 2026 18:02:44 +0200
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Sat, 24 Oct 2026 19:48:40 -0700, Dmitry Torokhov wrote:

> Convert callers of i2c_smbus_read_block_data() across input, ACPI,
> IPMI, platform, and power supply drivers to pass destination buffer
> sizes, adopting the 4-argument form introduced in commit 68f382641f8c
> ("i2c: smbus: make i2c_smbus_read_block_data() safer").
> 
> Because the prerequisite commit 68f382641f8c is in mainline now,
> subsystem maintainers are encouraged to pick up their respective
> patches directly into their trees.
> 
> [...]

Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

FYI [if applicable to your patch], as per Linus' policy change, also
fixes are mostly routed through for-next unless the fix is for a
commit introduced in the most recent cycle or is clearly a regression
fix.

The list of commits applied:
[1/8] i2c: acpi: use 4-argument i2c_smbus_read_block_data()
      (no commit info)
[2/8] i2c: docs: update i2c_smbus_read_block_data() prototype in writing-clients
      (no commit info)
[3/8] Input: cyapa - use 4-argument i2c_smbus_read_block_data()
      (no commit info)
[4/8] Input: elan_i2c - use 4-argument i2c_smbus_read_block_data()
      (no commit info)
[5/8] Input: synaptics-rmi4 - use 4-argument i2c_smbus_read_block_data()
      (no commit info)
[6/8] ipmi: ssif: use 4-argument i2c_smbus_read_block_data()
      (no commit info)
[7/8] platform/x86: x86-android-tablets: use 4-argument i2c_smbus_read_block_data()
      commit: 2a1d56a31ce503ee12bcf6d76bde99f2aab7c7d6
[8/8] power: supply: sbs-battery: use 4-argument i2c_smbus_read_block_data()
      (no commit info)

--
 i.

