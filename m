Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEBC20C029;
	Sun, 15 Mar 2026 04:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773547416; cv=none; b=CkpLvWE2zv63whXGVgDHH8qnryypmlrwoQRVN065KwmkxfvvkLuDLCCy3x8ndMyxDGHVCRdyTrBWoRhOcHDwTIDbvTqWsOcFBWT0Cgo8AibjQ+SiZv5spo83CaeiiAEn1Trks/NgY8GNsx/OUw+n+PRQhrrGr6YCEQ3tQwFRUlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773547416; c=relaxed/simple;
	bh=O/bIGAeyGtTfIUyYhpYcM5RJYmrd1A3jGUKbNZqm060=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMU6RSRq1yjbmamr94Gf1D5ROmtng9Eo0JgoKFqjS/F+gq9BVjlZmLZTn+g8d1yYHBhQVbW3Z2BIC1WAMU4F8AYFOHbqfJq61lLiOperpOVYkYsunWzYyalvR2EXx+aYcJjIBODYvrFpxwZcLYhGWxmRVkY3TgzXTiYSt7xt18g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=As6V5t4O; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="As6V5t4O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773547415; x=1805083415;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O/bIGAeyGtTfIUyYhpYcM5RJYmrd1A3jGUKbNZqm060=;
  b=As6V5t4OIgmjpxOKaxPwXA3WCaVTZroOVEkzEWzNEQ5p71n4bK5QEhEe
   WmB91RrD41SjVQn0nOFg3zLMLNCOHpFLcmCyzODonw4waudPRt9WjZq/D
   EU3USudRNUH6WjNZKPkm6cWLLunTvhhHoFyvyCglnh2EBFEPzkDmbLUQh
   zeX1GviDxupWmQGahRSFjp5m6CdQ4A9K5+/IdW5jlIcdJzTbcX3YYlakI
   h+121ssXq1VsMu56O4bSr76e74+4SUr6exIIYtJOwWqYjWwMZFGHfvTUr
   kvMJhrKEwp2BsA9PugsVHQC0x0jrngSKJvcYvEwNYKx1j0Hb+ScqB8Fl0
   w==;
X-CSE-ConnectionGUID: nDhipiTjRouhjEbNJSKm9Q==
X-CSE-MsgGUID: WtDAkta2Q6CTNoxUeRweWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11729"; a="78494983"
X-IronPort-AV: E=Sophos;i="6.23,119,1770624000"; 
   d="scan'208";a="78494983"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2026 21:03:34 -0700
X-CSE-ConnectionGUID: Ll9Xid7bQNikF9UpspO30A==
X-CSE-MsgGUID: n+VLRcZjQ6OaVdWdeCb38A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,119,1770624000"; 
   d="scan'208";a="217474796"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by fmviesa006.fm.intel.com with ESMTP; 14 Mar 2026 21:03:30 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w1chL-000000003xV-2jRH;
	Sun, 15 Mar 2026 04:03:27 +0000
Date: Sun, 15 Mar 2026 05:03:12 +0100
From: kernel test robot <lkp@intel.com>
To: Rahul Rameshbabu <sergeantsagara@protonmail.com>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, a.hindborg@kernel.org,
	alex.gaynor@gmail.com, aliceryhl@google.com,
	benjamin.tissoires@redhat.com, benno.lossin@proton.me,
	bjorn3_gh@protonmail.com, boqun.feng@gmail.com, dakr@kernel.org,
	db48x@db48x.net, gary@garyguo.net, jikos@kernel.org,
	ojeda@kernel.org, peter.hutterer@who-t.net, tmgross@umich.edu,
	linuxhid@cosmicgizmosystems.com,
	Rahul Rameshbabu <sergeantsagara@protonmail.com>
Subject: Re: [PATCH v7 1/2] rust: core abstractions for HID drivers
Message-ID: <202603150411.1TqpNCVC-lkp@intel.com>
References: <20260314215527.57575-2-sergeantsagara@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260314215527.57575-2-sergeantsagara@protonmail.com>

Hi Rahul,

kernel test robot noticed the following build errors:

[auto build test ERROR on b3d161f22ba9b2dc16bb82aa2b8515d98c99624f]

url:    https://github.com/intel-lab-lkp/linux/commits/Rahul-Rameshbabu/rust-core-abstractions-for-HID-drivers/20260315-071004
base:   b3d161f22ba9b2dc16bb82aa2b8515d98c99624f
patch link:    https://lore.kernel.org/r/20260314215527.57575-2-sergeantsagara%40protonmail.com
patch subject: [PATCH v7 1/2] rust: core abstractions for HID drivers
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20260315/202603150411.1TqpNCVC-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260315/202603150411.1TqpNCVC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603150411.1TqpNCVC-lkp@intel.com/

All errors (new ones prefixed by >>):

   PATH=/opt/cross/clang-20/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   INFO PATH=/opt/cross/rustc-1.88.0-bindgen-0.72.1/cargo/bin:/opt/cross/clang-20/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   /usr/bin/timeout -k 100 12h /usr/bin/make KCFLAGS=\ -fno-crash-diagnostics\ -Wno-error=return-type\ -Wreturn-type\ -funsigned-char\ -Wundef\ -falign-functions=64 W=1 --keep-going LLVM=1 -j32 -C source O=/kbuild/obj/consumer/x86_64-rhel-9.4-rust ARCH=x86_64 SHELL=/bin/bash rustfmtcheck 
   make: Entering directory '/kbuild/src/consumer'
   make[1]: Entering directory '/kbuild/obj/consumer/x86_64-rhel-9.4-rust'
>> Diff in rust/kernel/hid.rs:6:
    //!
    //! C header: [`include/linux/hid.h`](srctree/include/linux/hid.h)
    
   -use core::{
   -    marker::PhantomData,
   -    ptr::{
   -        addr_of_mut,
   -        NonNull, //
   -    } //
   -};
    use crate::{
        device,
        device_id::{
   Diff in rust/kernel/hid.rs:24:
        impl_flags,
        prelude::*,
        types::Opaque, //
   +};
   +use core::{
   +    marker::PhantomData,
   +    ptr::{
   +        addr_of_mut,
   +        NonNull, //
   +    }, //
    };
    use kernel::fmt;
    
>> Diff in rust/kernel/hid.rs:6:
    //!
    //! C header: [`include/linux/hid.h`](srctree/include/linux/hid.h)
    
   -use core::{
   -    marker::PhantomData,
   -    ptr::{
   -        addr_of_mut,
   -        NonNull, //
   -    } //
   -};
    use crate::{
        device,
        device_id::{
   Diff in rust/kernel/hid.rs:24:
        impl_flags,
        prelude::*,
        types::Opaque, //
   +};
   +use core::{
   +    marker::PhantomData,
   +    ptr::{
   +        addr_of_mut,
   +        NonNull, //
   +    }, //
    };
    use kernel::fmt;
    
>> Diff in rust/kernel/lib.rs:97:
    pub mod firmware;
    pub mod fmt;
    pub mod fs;
   +#[cfg(CONFIG_RUST_HID_ABSTRACTIONS)]
   +pub mod hid;
    #[cfg(CONFIG_I2C = "y")]
    pub mod i2c;
    pub mod id_pool;
   Diff in rust/kernel/lib.rs:103:
    #[doc(hidden)]
    pub mod impl_flags;
   -#[cfg(CONFIG_RUST_HID_ABSTRACTIONS)]
   -pub mod hid;
    pub mod init;
    pub mod io;
    pub mod ioctl;
   make[2]: *** [Makefile:1912: rustfmt] Error 123
   make[2]: Target 'rustfmtcheck' not remade because of errors.
   make[1]: Leaving directory '/kbuild/obj/consumer/x86_64-rhel-9.4-rust'
   make[1]: *** [Makefile:248: __sub-make] Error 2
   make[1]: Target 'rustfmtcheck' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2
   make: Target 'rustfmtcheck' not remade because of errors.
   make: Leaving directory '/kbuild/src/consumer'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
