Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CD33C5550
	for <linux-input@vger.kernel.org>; Wed, 25 Mar 2026 12:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774441116; cv=none; b=uD5o/YSa9pldN09d/PvltPuQyBtEXghWM8UeJdVrrB0Qc4FpifgtcSuR3no1gDao5fLpvFxU0lVydafeXMcYGEpTWMX5wPVcxhGN9b+6OJftTDTnp/tZ1LKaMONwpJG0dsz/qswPnPXfuM+aAv0enFMezKGEMyWFmeHs6phVLx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774441116; c=relaxed/simple;
	bh=bqK0L16wtxKKxO95+QIb/J7Bx/23mMyR1swl0kBkmZs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=nR6eBoFSz604DbLTZ0JtqgEnLogcqt9gf5sbKVP38+ntLY9YgHPhfGjptMM7cjTPmfKrGWtMhBA4muujh/T08Xfw9zuZXva3RYoIrD1WGfKQsx2kBHFyaBrCo+hLn7+wdtKapNwb5Nq7Rmsdaq/SySnrdP+eYMAYZlLbtRMhZSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gPQ1sMf0; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gPQ1sMf0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774441114; x=1805977114;
  h=date:from:to:cc:subject:message-id;
  bh=bqK0L16wtxKKxO95+QIb/J7Bx/23mMyR1swl0kBkmZs=;
  b=gPQ1sMf0/CbRaVrCvgxe0baj1mYkbPFVfpxyfO+SZ0AknV6o9OS+2DJq
   OWvVEU5AvZqeymLzr3tNoi5b9Edo9lX4441eo/KiaVnhVGnmZcAF0CIXa
   938GlHWrWvIWGGq0seet8QfQCZNVJldoLaVTD9aa7/Kz1UTh4sd+TY4Yp
   CkPK+kE3aaz3L3xRGsdMKgRoQbmjk9FQTaxwMa79ArXX7bBlwMp0IxcmQ
   KruCH9R08i5oNfC9XmAJSMhvOeVoPzi98cTR0CrM7VbFshrmj+7xK7GdC
   J8kRr/PvU3rsUDlzjQ4nmB7Rd0T/on71o9wsm8/Mh2RQlc+r4RSnLODDD
   Q==;
X-CSE-ConnectionGUID: Zw2wPJP+RZe6b/5HAeMJ4g==
X-CSE-MsgGUID: N9J4KFLWTsGzEOfQsXngqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="75590035"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="75590035"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 05:18:33 -0700
X-CSE-ConnectionGUID: i3lGmdFySeqfJQ6TwSyaPQ==
X-CSE-MsgGUID: Kxkh23qoQR6q3fXEAzu6iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="220260739"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 25 Mar 2026 05:18:32 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w5NBt-000000006nD-3diS;
	Wed, 25 Mar 2026 12:18:29 +0000
Date: Wed, 25 Mar 2026 20:18:16 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-input@vger.kernel.org
Subject: [dtor-input:next 32/43]
 drivers/input/touchscreen/mxs-lradc-ts.c:508:8: error: macro
 "class_spinlock_irqsave_constructor" passed 2 arguments, but takes just 1
Message-ID: <202603252057.JgSqGyIe-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
head:   303cdff39cdb1895a6d2b08e8946cc89feaf405c
commit: a995f3ca3bd51c348bd4c8d1833d318bef1a5001 [32/43] Input: mxs-lradc-ts - use guard notation when acquiring spinlock
config: sparc-randconfig-r134-20260325 (https://download.01.org/0day-ci/archive/20260325/202603252057.JgSqGyIe-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 14.3.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260325/202603252057.JgSqGyIe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603252057.JgSqGyIe-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/input/touchscreen/mxs-lradc-ts.c: In function 'mxs_lradc_ts_handle_irq':
>> drivers/input/touchscreen/mxs-lradc-ts.c:508:8: error: macro "class_spinlock_irqsave_constructor" passed 2 arguments, but takes just 1
     508 |                 scoped_guard(spinlock_irqsave, &ts->lock, flags) {
         | ^               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/sched.h:37,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from drivers/input/touchscreen/mxs-lradc-ts.c:13:
   include/linux/spinlock.h:623:9: note: macro "class_spinlock_irqsave_constructor" defined here
     623 | #define class_spinlock_irqsave_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(spinlock_irqsave, _T)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/irqflags.h:17,
                    from include/asm-generic/cmpxchg-local.h:6,
                    from arch/sparc/include/asm/cmpxchg_32.h:67,
                    from arch/sparc/include/asm/cmpxchg.h:7,
                    from arch/sparc/include/asm/atomic_32.h:17,
                    from arch/sparc/include/asm/atomic.h:7,
                    from include/linux/atomic.h:7,
                    from include/asm-generic/bitops/lock.h:5,
                    from arch/sparc/include/asm/bitops_32.h:102,
                    from arch/sparc/include/asm/bitops.h:7,
                    from include/linux/bitops.h:67,
                    from include/linux/log2.h:12,
                    from include/asm-generic/div64.h:55,
                    from ./arch/sparc/include/generated/asm/div64.h:1,
                    from include/linux/math.h:6,
                    from include/linux/math64.h:6,
                    from include/linux/time64.h:5,
                    from include/linux/restart_block.h:9,
                    from include/linux/thread_info.h:14,
                    from arch/sparc/include/asm/current.h:15,
                    from include/linux/sched.h:12:
>> include/linux/cleanup.h:300:17: error: invalid initializer
     300 |                 class_##_name##_constructor
         |                 ^~~~~~
   include/linux/cleanup.h:438:14: note: in expansion of macro 'CLASS'
     438 |         for (CLASS(_name, scope)(args);                                 \
         |              ^~~~~
   include/linux/cleanup.h:447:9: note: in expansion of macro '__scoped_guard'
     447 |         __scoped_guard(_name, __UNIQUE_ID(label), args)
         |         ^~~~~~~~~~~~~~
   drivers/input/touchscreen/mxs-lradc-ts.c:508:17: note: in expansion of macro 'scoped_guard'
     508 |                 scoped_guard(spinlock_irqsave, &ts->lock, flags) {
         |                 ^~~~~~~~~~~~


vim +/class_spinlock_irqsave_constructor +508 drivers/input/touchscreen/mxs-lradc-ts.c

   491	
   492	/* IRQ Handling */
   493	static irqreturn_t mxs_lradc_ts_handle_irq(int irq, void *data)
   494	{
   495		struct mxs_lradc_ts *ts = data;
   496		struct mxs_lradc *lradc = ts->lradc;
   497		unsigned long reg = readl(ts->base + LRADC_CTRL1);
   498		u32 clr_irq = mxs_lradc_irq_mask(lradc);
   499		const u32 ts_irq_mask =
   500			LRADC_CTRL1_TOUCH_DETECT_IRQ |
   501			LRADC_CTRL1_LRADC_IRQ(TOUCHSCREEN_VCHANNEL1) |
   502			LRADC_CTRL1_LRADC_IRQ(TOUCHSCREEN_VCHANNEL2);
   503	
   504		if (!(reg & mxs_lradc_irq_mask(lradc)))
   505			return IRQ_NONE;
   506	
   507		if (reg & ts_irq_mask) {
 > 508			scoped_guard(spinlock_irqsave, &ts->lock, flags) {
   509				mxs_lradc_handle_touch(ts);
   510			}
   511			/* Make sure we don't clear the next conversion's interrupt. */
   512			clr_irq &= ~(LRADC_CTRL1_LRADC_IRQ(TOUCHSCREEN_VCHANNEL1) |
   513					LRADC_CTRL1_LRADC_IRQ(TOUCHSCREEN_VCHANNEL2));
   514			writel(reg & clr_irq,
   515			       ts->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
   516		}
   517	
   518		return IRQ_HANDLED;
   519	}
   520	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
