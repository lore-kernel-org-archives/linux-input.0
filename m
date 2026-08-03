Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8EB427FBF;
	Mon,  3 Aug 2026 17:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785779945; cv=none; b=VAa9NLODLrHzOqb054WxhjH0qauSGMiS+lQ0ejfKeun8dVwovLjF24n/XmzXrQpPz0/74oZbRZmKMxuOASrm1isO6uwlyIkk+0RQxpj0LJZxGBG4FnjtEZKdpVPV5W6+Yq70ljoHs6bXykx1p6+oXo8fYFaue2ZPfKcAmkjtxVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785779945; c=relaxed/simple;
	bh=0rTR/no/7IkIzGAlwC0X0+O/ebS6IKYGK8dOSF3rYjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJzU9ST4gDhExkICk7boE+A2QrIRY1vyjtthzJkvWEFrQUFDI/xZp7vAUAp7zqWLsiZeNJFueiwvQgHGyLuh0A2YQycH/uoSavnVu8ozjJFDGZE3g4QfUevemriWkyALmUSh6/U9WDOxyczsOF1D1rpSAr3yNrpiULl0fVzJVc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hzD4FCmF; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hzD4FCmF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785779944; x=1817315944;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0rTR/no/7IkIzGAlwC0X0+O/ebS6IKYGK8dOSF3rYjQ=;
  b=hzD4FCmFVFSw18F7r2v10WuvKGhILwhfkofpa9jsw0dAeaiKl4Jg7y8I
   icHRkVUTKrUK/yupb28HWkQCWubsHhZ7jYvKPpZQRtw5ISNf7w7nHluJm
   AGN/6e1Di1WDdSa+aja3cMxW7986OTmyHqUeu6JYacSF0nhv7BYRVvPra
   puO0s3zjEQl45PtAP5YAbgIJTxEdPms/jj1lW259Phw3+Sq2bzPtmKK0v
   V7YuPIFiwrVtQCNGa28pNj5tHLZQMwGOdcfrEYr9xnaHBEp9/CrWH65zd
   CSTIlYPBaE51FR3bT+SeXHW76y8A1gNkCk/1F/g84Y/fETx7GLoBT8QRr
   g==;
X-CSE-ConnectionGUID: enCybRuGTe6EBvzxVDBV8g==
X-CSE-MsgGUID: zvZDreaiT5qmizoKgWXQdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="103864563"
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="103864563"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 10:59:03 -0700
X-CSE-ConnectionGUID: /G63bwS4T0iPtKMknbrZtg==
X-CSE-MsgGUID: zf/fAcXcT1Kr7Xf664yKDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="256960727"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 03 Aug 2026 10:59:01 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wqwwE-000000007Wf-14AM;
	Mon, 03 Aug 2026 17:58:58 +0000
Date: Tue, 4 Aug 2026 01:58:25 +0800
From: kernel test robot <lkp@intel.com>
To: Jiale Yao <yaojiale02@163.com>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Miao Li <limiao@kylinos.cn>,
	Nguyen Dinh Dang Duong <dangduong31205@gmail.com>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Jiale Yao <yaojiale02@163.com>
Subject: Re: [PATCH] HID: huawei/rapoo: reject non-USB transports before
 to_usb_interface()
Message-ID: <202608040118.PKscfqFG-lkp@intel.com>
References: <20260728064302.3853953-1-yaojiale02@163.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728064302.3853953-1-yaojiale02@163.com>

Hi Jiale,

kernel test robot noticed the following build errors:

[auto build test ERROR on hid/for-next]
[also build test ERROR on linus/master v7.2-rc6 next-20260731]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiale-Yao/HID-huawei-rapoo-reject-non-USB-transports-before-to_usb_interface/20260803-165822
base:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-next
patch link:    https://lore.kernel.org/r/20260728064302.3853953-1-yaojiale02%40163.com
patch subject: [PATCH] HID: huawei/rapoo: reject non-USB transports before to_usb_interface()
config: x86_64-buildonly-randconfig-003-20260803 (https://download.01.org/0day-ci/archive/20260804/202608040118.PKscfqFG-lkp@intel.com/config)
compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260804/202608040118.PKscfqFG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608040118.PKscfqFG-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "hid_is_usb" [drivers/hid/hid-rapoo.ko] undefined!

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
