Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1939E30F548;
	Mon,  1 Jun 2026 09:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780304736; cv=none; b=bsYOXPj/sAiAEh8sa8XIx9WJvV3AgoP9f+k5hI1CmG/MbU4FG5R1KaeZ3jq7B1LtOKX/COJB8gAVPw6UzuSlntxKoCgBk179bl3RH9iK7pfT2wn5kHu5mTTjnDj/hJ9wx5fR5ehi+LcZIzusReP86kgdbd7c4dLtqkO39ZFL0xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780304736; c=relaxed/simple;
	bh=IDX0u5FOaWQ4XfuLbY0O9Ey4VB9kLt9xp1uvOIuH+6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMHmFFu8NwMS/8Zkos1RCnuFRBnwfUj9GdN2oiWyd3lDYwJcf2NkY8hzI8OgPIeVrkAoxMm1kd12/FYfd0KrF9dWN0RmtYj1jyaE0SQ0Ks4S8CoSbnA7xj2WtF8O7Rw2ohmtHmYviKOEm72sNWO3TFwaa5dBWczzt1ibdfcxEvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fbibviok; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fbibviok"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780304736; x=1811840736;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IDX0u5FOaWQ4XfuLbY0O9Ey4VB9kLt9xp1uvOIuH+6w=;
  b=fbibviokuzMS+HiI/QjCKlVPYfq8/KkSlFmP884DFA46p2WNJEosZCy9
   PdtUhIewC4EOnkXuVfeMQQ+Iuwh7RAbk3ihw3JXiFwPVvJNlPQ4PE6q/7
   eyjYboMOJPyD0Jo35DwYvRywsbZ5hB7ccRRcde44ypdKs2hy5QOyrNeon
   hEpz3p6mQXe76l8RDBAk/fmJV+sbGnVmIB0HrFEyW/zUtT4/hZMEUpKye
   JIrRjky/O7WOVVfFh3RdP6yjDV1+m4yEAnbmzCJS+6MIJlTWDcLzNvk8a
   93ecNwPkpHCSU1PIla2GnaIJBNRdKWRU0SSexy9/dACzZJ8tvsuSnWpT9
   g==;
X-CSE-ConnectionGUID: m4TPKo1ER/K+VpRajPIwsQ==
X-CSE-MsgGUID: dPRZ0xAmTiOAz9kQJcSYDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="92535170"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="92535170"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 02:05:35 -0700
X-CSE-ConnectionGUID: q6bn0CE3QtGSpB5O8NT7XA==
X-CSE-MsgGUID: IZ84GNK0QWyjkaaxNyH+Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="243634031"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 01 Jun 2026 02:05:33 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wTyaQ-00000000APe-0tx7;
	Mon, 01 Jun 2026 09:05:30 +0000
Date: Mon, 1 Jun 2026 17:04:35 +0800
From: kernel test robot <lkp@intel.com>
To: David Glushkov <david.glushkov@sntiq.com>,
	Jiri Kosina <jikos@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] HID: steelseries: Add MSI Raider A18 HX A9WJG RGB
 support
Message-ID: <202606011654.dFHta3Dw-lkp@intel.com>
References: <20260531233903.208321-1-david.glushkov@sntiq.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260531233903.208321-1-david.glushkov@sntiq.com>

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on hid/for-next]
[also build test WARNING on linus/master v7.1-rc6 next-20260529]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Glushkov/HID-steelseries-Add-MSI-Raider-A18-HX-A9WJG-RGB-support/20260601-074317
base:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-next
patch link:    https://lore.kernel.org/r/20260531233903.208321-1-david.glushkov%40sntiq.com
patch subject: [PATCH v5] HID: steelseries: Add MSI Raider A18 HX A9WJG RGB support
config: x86_64-rhel-9.4-kunit (https://download.01.org/0day-ci/archive/20260601/202606011654.dFHta3Dw-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260601/202606011654.dFHta3Dw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606011654.dFHta3Dw-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hid/hid-steelseries.c:569:27: warning: 'steelseries_hid_to_usb_dev' defined but not used [-Wunused-function]
     569 | static struct usb_device *steelseries_hid_to_usb_dev(struct hid_device *hdev)
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/steelseries_hid_to_usb_dev +569 drivers/hid/hid-steelseries.c

   568	
 > 569	static struct usb_device *steelseries_hid_to_usb_dev(struct hid_device *hdev)
   570	{
   571		struct usb_interface *intf = steelseries_hid_to_usb_intf(hdev);
   572	
   573		if (!intf)
   574			return NULL;
   575	
   576		return interface_to_usbdev(intf);
   577	}
   578	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
