Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794570388;
	b=eZOKc3b1siFuemuot/smHaFwXLWlgW7Wl8sPBYRBc+/NqeuAx+kGiD2Q4YVRhXAQ7ui0
	 5Mi/KQLdvMoSLLceJyIHM1XxBEXHVpqYIY3OQjZ7HzdmvmzJuaCRcdOisXowLYxYArbXS
	 AGZXLAU18n221xxLOFDJQbJ9oyn6Eon5FKJK3uhXKz8LFKOTrImpawn35w+98I6ycaIuv
	 ezb0MBTCx+aLg387sSRLg/dw/6C8Sp+kcvwb8G4TNNPLSYR3NzUI8Qji1mI8wEmm4mmLj
	 q62XOXZHVkqhS6dOPx49JLHeaCAqioOJxVDqfFEszspp34F+VvuE90VO3lhT5HYoSTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794570388;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:
	 In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=sIKt/11sRIpQoLlnwbdUZPL6D9m4uMaBATJci/erHQ4=;
	b=TMP12hmUpYbGaWzJajBGeTuWOsnJf1xnf3ouN9IZqiU/mosmdc7lc6DlKWUeg02jatY5
	 YNP/s2x/6SyK/mndjP/HJD2ex9QXeai8fevN9tAEdi+WQ9wRmDDz0ooSZPTS7XGQGJqtJ
	 LaltbQahsMRLdvzX2/MuJLVcb8xiciCEgKRa+s2NbUYbriDqo7X7w6Ki+yfXP5aQapyq0
	 Ko0K1t+fJG+8tro0fw7Tg5mQ32PFfrzJ/6SyamSfEdpzXbokTSN3xvlYQJQyGz4bLtE6/
	 xwGIvNyFzoxj5OJYkCqTnbsDHWHwops9BT/VhE7q8brDKjkRl3PGjtAK357ow5PCJ/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UPnYWao7;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2B1606A323;
	Fri, 13 Nov 2026 11:46:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A2B1606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UPnYWao7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794570388; x=1826106388;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=70lA5G/wnfwGcsKQOxEkBPPaTlPMDHLav32v2A0v/Rc=;
  b=UPnYWao7hiHtsxLmVV6W/5Nv6l1hPukMUlOOFr8nmYlKSdhNcVrYsXd3
   MjO1vbCRrNOc02ViLCQ010Eulb0SaBwx35Y6D9q/Irp8PGYcLmLigtmTC
   zFUuI3HBSe/TNECiqkqxJV79/wqWQXRXx7nJ4nnkqC1QzpPwaLVO7GP3i
   Ctwe4R0DGjIRxektfAAKkNNud9tn2Bc97hScNOVjkAcH9+Be3IOM42VDy
   ySAMYTMF9als8kGqjM9+XGy9I2e86hwDBgq3AEfYmnc0OwobEVzlxlu3A
   Nhe/7iJ5uR/SORmAGKKDu/XSeEdz3ia79fJg3A3EEq8/CtAsgQpMbSsFx
   A==;
X-CSE-ConnectionGUID: rgwzClnjTiOQBY5YVJ2x5Q==
X-CSE-MsgGUID: yxOSNn5fThSOj+Ilm1bSaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3258128"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3258128"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 03:46:27 -0800
X-CSE-ConnectionGUID: GFXZNQ+AT8iHFNZW2Nec1A==
X-CSE-MsgGUID: zZ+bSqT8TI2CZpHvQgVWfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="8750533"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.214])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 03:46:20 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, Armin Wolf <W_Armin@gmx.de>, 
 Sebastian Reichel <sre@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Eliav Farber <farbere@amazon.com>
Cc: linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
 linux-input@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-pwm@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
In-Reply-To: <20261113104218.32566-1-farbere@amazon.com>
References: <20261113104218.32566-1-farbere@amazon.com>
Subject: Re: [PATCH v6 0/7] notifier: convert remaining drivers to
 device-managed registration
Message-Id: <179457037547.7575.907664153895239687.b4-ty@b4>
Date: Fri, 13 Nov 2026 13:46:15 +0200
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

On Fri, 13 Nov 2026 10:42:02 +0000, Eliav Farber wrote:

> The devm_atomic_notifier_chain_register() and
> devm_blocking_notifier_chain_register() helpers this series added in v5
> are now in mainline, together with 6 of the 11 driver conversions. This
> revision carries the 6 conversions that were never picked up, plus one
> new conversion for a driver that grew the old pattern after v5 was
> posted.
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
[1/7] platform/x86: bitland-mifs-wmi: use devm_blocking_notifier_chain_register()
      commit: a362539b42193dcdb17f8fba40031a515c53885c
[2/7] Input: adp5585: use devm_blocking_notifier_chain_register()
      (no commit info)
[3/7] ACPI: APEI: GHES: remove unused ghes_{,un}register_vendor_record_notifier()
      (no commit info)
[4/7] ACPI: APEI: GHES: use devm_blocking_notifier_chain_register()
      (no commit info)

--
 i.

