Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793812792;
	b=5mWxjnHgMdrAJdcnaCbHToUlm3zi56XnvMyFQeL1lQJ3NSpF4he1ZlaQmCTrLVHtMu8N
	 87Bk8UHhrmdzZsu/RXdX1RWepfaQaSxW6RmgtMrVrVvflmcHMjXm3iuCpCWvJj53Ts1ou
	 ptVbjMHcmkwDIP3vzwgDyxsAFu0W3JKNKMLdUe1Y5ryq3MKMBG9KC5dOuR66JwTS6jS8Z
	 PEAePu8iO48MasU9lbcbtUYjQ7L43hFo+jenX5xzkKs2bdGti56gOH8W3OInt9WazTubM
	 e7jh0nocwYwBKF3b8NdJxLyoobvhIAU8XBbstMM6j+G4qEbivZOLApsUvC5IvZjrqpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793812792;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:Organization;
	bh=ozZ9gCZmDvrPUttrX5bAu2pX2X3DOCbcglFCjF93fg4=;
	b=IW8T2nD31i7wwGOv7ofWUCNOnRPwJdJKJy90ikRZN8kM1YflBHlm5fngKNKlNQItzpNS
	 CG/cpNGSLzE8OQtSwVgitbNa++Q40yDrbjphhwQfYtBHyYh/7E0ZmQfbYnwZaXIpdlHMB
	 cvG1tWKMpA+JeQzvKkXID6VHP0T9juHMj4A19IoT0WuKcWUjJg2+Xdvde+FdF/BraOTNd
	 ygGCbjbTlfNaV9oGMEcBynccI5FKHG0snqlJGwsjcQBHzdSCaBBx8m7jFQKCxdLukBhil
	 ckK9ssfnTF9VTp8gSCmSQhJtHdC1PugBuptBfn5vfOTlrBJ9519FVFWSWhmzAsNBoNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ts6vhhW4;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEEC606A31B
	for <linux-input@vger.kernel.org>; Wed,  4 Nov 2026 17:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AEEC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ts6vhhW4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793812791; x=1825348791;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=pR0E4Kf1BXK360fcv40ibezmC32wB7/5yHh2b735Z/I=;
  b=Ts6vhhW40VfgXjKyf0qnIqYWbEsV2KacuWGdRY4iCD81cO2hgeuGuaqy
   NUBy+vAl9DI6NnV/F01Ig253qZaCHm2GskkUqaP1MDyxNKIM20IllUAGS
   ELfe3sqpJieymFWtuQRIKWKpWB4X8n4QEseZXbSAhdE9gYfppjQGIIFQk
   k1PQTsAxuNmdUgeLCLNF1AdYWFwlyGRxQd5xMIuNE8FRXUVHzKEiEF8dc
   uE/R+6i3I8p6E7LANRbeFGtiuatxuuNqPL+/v9vdo+Id0GHUz25KEk703
   UDUdWCNSuFu4o6kySS6DUueQCWaPPMhC740EW8LMEnfkPhhnnTFXrJfLP
   A==;
X-CSE-ConnectionGUID: BUQVS10JRMyaZJrxJN1dLw==
X-CSE-MsgGUID: FJZkPi9VRnS6OActzx3F5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2476786"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2476786"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 09:19:50 -0800
X-CSE-ConnectionGUID: 7LLMyichSsq7eW8tRWHvwQ==
X-CSE-MsgGUID: 9mIJnbqDQMO6+InqZTx/vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6599979"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 09:19:49 -0800
Date: Wed, 4 Nov 2026 19:19:46 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Danny Kaehn <danny.kaehn@plexus.com>, Jiri Kosina <jkosina@suse.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org
Subject: Re: Firmware Support for USB-HID Devices and CP2112
Message-ID: <autpMnQT8t0Ecu-m@ashevche-desk.local>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520-cp2112-dt-v14-0-b1b4b6734b6f@plexus.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

In lieu of this discussion [1] I just realised that CP2112 misses the
documentation piece under Documentation/firmware-guide/acpi/ on how
it's supposed to be enumerated. Danny, can you add a such, please?

[1]: 20261003095924.1370238-1-thierry.reding@kernel.org

-- 
With Best Regards,
Andy Shevchenko


