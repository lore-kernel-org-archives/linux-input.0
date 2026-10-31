Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793409856;
	b=kZ7taq09e1KHvsl6OO1nM95jeLyo1O52dUgBBAHOD9Ej9ge0SpP4WjUQb5Ii8l8rpdFo
	 2hw4aVOf++N3lJjl1EuXcVWjGvD0jel14ozsKDAZESYzn0rGrsdLdDqocw+kU/XzQ/VnX
	 MX1a4MDeZFDwz+so387s4QT2bxgWMCK04DhWS+5XHQyR9LhZ+w0LaIocUxjO2cvLc33Us
	 8nXSIuz5HfLWcNEksweOR2nJbhNWIYTbA+XyuxIOHSSmq6P9HJhUje2QOi+wUXl4/WASv
	 wfB0/NQxNATnZp+2e84QdkAIjlqomFzYSVebtQwhpLJ9mbu03XI7U7BloF2K3scWTQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793409856;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=/bTTjj8n/ts39yLomRcVpuIj0WjaFRlNCsiPPRonh80=;
	b=XmZIERFst2UAy6rXLRYs7KluRHYzmY3balooVln8Gmeagm66b/hDeLi3Fl4zYYjNPLIE
	 W7f+p+dmK0QVDm6lBUAM95idofTBCU7jSTqwxAFH/bgROBLgoFUbynfClBmzkpPojkzYE
	 l7TdX6rV4yGIDENaR+YH3XpW5GzLGEK5LSqWmwEmtILfA5VBcCkFfDeMEZKGIJA2Mb95+
	 3qNtzZ5sSpjkEpuIpBzzjIfNFjCy8wgKNcRuqaUQkmvV+sArKuT/MbjzYvzmIvEurcbRV
	 MjH57p9Hp/iG2lNz7w6h/Oh+JqvWArtXihy33u87ImtKTVi7aznG9zUpckdRDCTiZTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	arc=none smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109B0606A31A;
	Sat, 31 Oct 2026 01:24:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 109B0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793409847; x=1824945847;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YUY4SZ+Fxv6EF7SHsc9znE54cxaG4yTMfXDhf7S41o0=;
  b=LJIMsVt8IJvp+60uuXos4izZxHgUsfZQnop/Ifw1JmR/P1+fXVHxeEyr
   Vu98gJO+Ci4JPWq2YknZixMiJl0pK3JYk5dwAltThV8kPVSqgsWUhrigz
   M88Zs3SKyb8QP5J4xNgnRh5T0YNXRGIuuCMdZpYDCq9UaoY1bnA8yLlPb
   wAzota1WGyiUxmPP0FlvYo9UnNcLnA3MY2w6XxZX9gvSVdzKagdVQY06v
   w0utLwA7S3xOZw5ARUsj7oDXc4fagF8U8tf+nG/nAThU2Rwa2Nws4IUba
   VKDXz6H5nogR/u1kXLrRmUbCJPtBHRYFS96SMrhR/NWkOvvOwlwjlsQPL
   A==;
X-CSE-ConnectionGUID: cXqIlUJHTzOFMF2e4Pnrmw==
X-CSE-MsgGUID: Pn2/85yWTlqAQ2IKYsrCEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2071714"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2071714"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 18:24:06 -0700
X-CSE-ConnectionGUID: XPJUpvmdR0Sqa12yYvTrOA==
X-CSE-MsgGUID: wbKxthZwQamUMnWMhHnqvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5915287"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 30 Oct 2026 18:24:05 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xMxpC-00000000cQO-3Pry;
	Sat, 31 Oct 2026 01:24:02 +0000
Date: Sat, 31 Oct 2026 09:23:38 +0800
From: kernel test robot <lkp@intel.com>
To: ahmad baghereslami <ahmad.b1995@gmail.com>, dmitry.torokhov@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ahmad baghereslami <ahmad.b1995@gmail.com>
Subject: Re: [PATCH] Input: synaptics - support the touchpad LED on RMI
 function $30
Message-ID: <202610310804.T0iDq0C6-lkp@intel.com>
References: <20261030070821.1716595-1-ahmad.b1995@gmail.com>
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
In-Reply-To: <20261030070821.1716595-1-ahmad.b1995@gmail.com>

Hi ahmad,

kernel test robot noticed the following build errors:

[auto build test ERROR on dtor-input/next]
[also build test ERROR on dtor-input/for-linus hid/for-next linus/master v7.3 next-20261029]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/ahmad-baghereslami/Input-synaptics-support-the-touchpad-LED-on-RMI-function-30/20261030-103821
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
patch link:    https://lore.kernel.org/r/20261030070821.1716595-1-ahmad.b1995%40gmail.com
patch subject: [PATCH] Input: synaptics - support the touchpad LED on RMI function $30
config: um-randconfig-1000-20261031 (https://download.01.org/0day-ci/archive/20261031/202610310804.T0iDq0C6-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.4.0-5) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261031/202610310804.T0iDq0C6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610310804.T0iDq0C6-lkp@intel.com/

All errors (new ones prefixed by >>):

   /usr/bin/ld: drivers/input/mouse/synaptics.o: in function `synaptics_disconnect':
>> synaptics.c:(.text+0x22dc): undefined reference to `led_classdev_unregister'
   /usr/bin/ld: drivers/input/mouse/synaptics.o: in function `synaptics_init_ps2':
>> synaptics.c:(.text+0x406d): undefined reference to `led_classdev_register_ext'
   collect2: error: ld returned 1 exit status

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
