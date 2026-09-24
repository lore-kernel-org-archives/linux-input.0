Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441E532A3D7;
	Thu, 24 Sep 2026 04:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790223026; cv=none; b=jYs9DcXThrmNtwxbIs86X48MGXY1KhGwKBVCtEbCjohgRcWBXwgSOmblFy3669wp7mbUX2hZO/apP3QyKH2IMY9zva8YpxmznWXcOQP27F3eDawvlm0CDdMfsc0Vp9T9JRTZ6u7Je34UScuRIdhSDNrzyEgDRLAzdhnfodsltlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790223026; c=relaxed/simple;
	bh=/R79mf0UN30aDwOcAu+xr3w+bnwKPwqVeOzknFxhMtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvOIctohg/vMay0rUCswGLoq/kuNc7+yf7avktZnD0sVnuLlxaaUXx2aXiMIHemAjlf9i4Y4qqJFcSJSAB8/ihA0o0Rk/U6O3BkEn0gmpr9SWJMJBEg56c/X24b1asj4IwaWurlwNREUxExyO2An0xe6MEQPbN8Bt0mnpxzzxGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QQf1+PxM; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QQf1+PxM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790223025; x=1821759025;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/R79mf0UN30aDwOcAu+xr3w+bnwKPwqVeOzknFxhMtI=;
  b=QQf1+PxMJDnC0sx2IoGQcA4WAKmd432UoIhBT+SKtCIGvryWfaivpu4N
   dtnwUKp43ZZSHRA8os5vvpZvymjxaUwYTOg2vYjLEMgiYB6UrHqkgmyhQ
   hQlG5WftOCYBr6aKdITU0yRNz3MOCk/tw9ZB4ABKsQi8w44YUmmKg7Zf/
   DVwaEJI3AnNpmrbhDPXjtQ02Sq7b/PIwvR/DKd/ftK3wAAhMk8RpXsgqc
   ke2CP/wUDwfEq6rKwD9SrjVDS4NMPxDKlibwNoPliWnlRFghqAR/8mFko
   3QCfVfvs6rXVWTNhNb2WTNSdlGnn8hYdwPbEIxtMWycfkmuU7sXbITmR0
   g==;
X-CSE-ConnectionGUID: dN0UkuUVQqGDbFszSdHzDA==
X-CSE-MsgGUID: Eq2/u/VKR3GZuqo/3fG83w==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="94802348"
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="94802348"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 21:10:24 -0700
X-CSE-ConnectionGUID: +Z9BmMAST3utUSdVgPQUBg==
X-CSE-MsgGUID: wuav5v6NQAuyY7aW/32L3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="300154550"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 23 Sep 2026 21:10:23 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x9amq-00000000IBa-2izI;
	Thu, 24 Sep 2026 04:10:20 +0000
Date: Thu, 24 Sep 2026 12:09:46 +0800
From: kernel test robot <lkp@intel.com>
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+1075f6dc93f398c1857e@syzkaller.appspotmail.com
Subject: Re: [PATCH] Input: serio - don't sleep on serio_mutex from
 drvctl_store()
Message-ID: <202609241230.lUW53GKL-lkp@intel.com>
References: <20260919124604.210505-1-ngocthang2710.1999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260919124604.210505-1-ngocthang2710.1999@gmail.com>

Hi Nguyen,

kernel test robot noticed the following build errors:

[auto build test ERROR on dtor-input/next]
[also build test ERROR on dtor-input/for-linus linus/master v7.3-rc4 next-20260922]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nguyen-Ngoc-Thang/Input-serio-don-t-sleep-on-serio_mutex-from-drvctl_store/20260919-194604
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
patch link:    https://lore.kernel.org/r/20260919124604.210505-1-ngocthang2710.1999%40gmail.com
patch subject: [PATCH] Input: serio - don't sleep on serio_mutex from drvctl_store()
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260924/202609241230.lUW53GKL-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260924/202609241230.lUW53GKL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609241230.lUW53GKL-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/jump_label.h:78,
                    from include/linux/dynamic_debug.h:6,
                    from include/linux/printk.h:620,
                    from include/asm-generic/bug.h:31,
                    from arch/x86/include/asm/bug.h:195,
                    from arch/x86/include/asm/alternative.h:9,
                    from arch/x86/include/asm/barrier.h:5,
                    from include/linux/list.h:11,
                    from include/linux/module.h:12,
                    from drivers/input/serio/serio.c:14:
   drivers/input/serio/serio.c: In function 'drvctl_store':
>> drivers/input/serio/serio.c:361:45: error: implicit declaration of function 'restart_syscall'; did you mean 'do_no_restart_syscall'? [-Wimplicit-function-declaration]
     361 |         scoped_cond_guard(mutex_try, return restart_syscall(), &serio_mutex) {
         |                                             ^~~~~~~~~~~~~~~
   include/linux/cleanup.h:457:25: note: in definition of macro '__scoped_cond_guard'
     457 |                         _fail;                                          \
         |                         ^~~~~
   drivers/input/serio/serio.c:361:9: note: in expansion of macro 'scoped_cond_guard'
     361 |         scoped_cond_guard(mutex_try, return restart_syscall(), &serio_mutex) {
         |         ^~~~~~~~~~~~~~~~~


vim +361 drivers/input/serio/serio.c

   353	
   354	static ssize_t drvctl_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
   355	{
   356		struct serio *serio = to_serio_port(dev);
   357		struct device_driver *drv;
   358		int error;
   359	
   360		/* Port removal holds serio_mutex and drains us: don't wait for it. */
 > 361		scoped_cond_guard(mutex_try, return restart_syscall(), &serio_mutex) {
   362			if (!strncmp(buf, "none", count)) {
   363				serio_disconnect_port(serio);
   364			} else if (!strncmp(buf, "reconnect", count)) {
   365				serio_reconnect_subtree(serio);
   366			} else if (!strncmp(buf, "rescan", count)) {
   367				serio_disconnect_port(serio);
   368				serio_find_driver(serio);
   369				serio_remove_duplicate_events(serio, SERIO_RESCAN_PORT);
   370			} else if ((drv = driver_find(buf, &serio_bus)) != NULL) {
   371				serio_disconnect_port(serio);
   372				error = serio_bind_driver(serio, to_serio_driver(drv));
   373				serio_remove_duplicate_events(serio, SERIO_RESCAN_PORT);
   374				if (error)
   375					return error;
   376			} else {
   377				return -EINVAL;
   378			}
   379		}
   380	
   381		return count;
   382	}
   383	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
