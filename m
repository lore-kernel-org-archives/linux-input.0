Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3213738237F;
	Wed, 11 Mar 2026 17:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773248764; cv=none; b=D6nXS5kwpDdzKrMGKpN/efpRehlFG9QlIfKthB+nzzQbKn9lZ/1RfuEuV0NjCzbmhbZ5y6QGt/ddw8r1Ay6oOYTYYPH4Q9lDBLYCfBw/28+R76qQaetzbV3vo+mfmkxL+KDZRRQbrVgqVCipo0BIfFpg05z70kVNjWqmVhDxqlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773248764; c=relaxed/simple;
	bh=EBtjx6PROw5OyEE6ip1LUR83kNqukiKny9uCnB2KzH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HRG4C8tNSNwgm4MuJ17P8LMaFiY3mce7Y2vDu5WnBr7cBDQo9rElcxX54yMJ2HC4RhwxRvuX0wYa57r6TF+/N+nkYCdjbwrax9vjKoqL0axXpXfZsjGcBRPjA00B4Y0R+sXs3V37cw/m+GwI3Br0NR2+SKZvNr7Og5rSNdmBbaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=np1WvjTi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="np1WvjTi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E167C4CEF7;
	Wed, 11 Mar 2026 17:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773248763;
	bh=EBtjx6PROw5OyEE6ip1LUR83kNqukiKny9uCnB2KzH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=np1WvjTilFItuyBwzXEdb5NJ4Zalc3P6SoTdrBEvuSZdvuniyJSYU2zWSRZdIVc5F
	 JUqfHShdzNSeThN79+YThlx3fenMv4ZRzDSqMF4LTHNG+ma0WBd+9Y4IayNlLv0oua
	 yo0bTMGwQdowW04xJRNrinRAmFkmSCTURvN2WxtcIEIuJ0dnJqRn55wknN8GDJMQkT
	 VBgGk5c+/hIdDrKcABXrxFDMaWD41UvWkygV2H+aTs/4JA7HKe1BsmfqESbyEVmc5i
	 evZvIiFQFFvEOVtT0TIyMTXoffOoN1C854A0UMLmrY2tjI6SIm3FI3LEVO5VGuzJBU
	 JcqizJEjxhW0g==
Date: Wed, 11 Mar 2026 18:05:25 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, 
	kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, 
	x86@kernel.org, Thomas Gleixner <tglx@kernel.org>
Subject: Re: [tip:timers/vdso 37/45] progs/hid_bpf_helpers.h:117:31: error:
 declaration of 'struct bpf_wq' will not be visible outside of this function
Message-ID: <abGeK0FpNn5uXi8B@beelink>
References: <202603111558.KLCIxsZB-lkp@intel.com>
 <20260311160618-dbfa08f6-8cfa-4f81-94a2-d6d97f79ae93@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260311160618-dbfa08f6-8cfa-4f81-94a2-d6d97f79ae93@linutronix.de>

On Mar 11 2026, Thomas Weißschuh wrote:
> Hi Jiri and Benjamin,
> 
> could you take a look at the report below?
> This looks like an issue in the HID BPF subsystem, surfaced by my
> unrelated change. Does this ring a bell for you?
> 
> I wasn't able to reproduce it so far, but will continue looking into it.

Both struct bpf_wq and struct hid_device should be generated in the
vmlinux.h that we include in the selftests. So this is definitely not
related to your patch AFAICT.

Looking in the config, we have `# CONFIG_HID_SUPPORT is not set` -> so
that would explain why struct hid_device is not available. But in that
case, why are the HID selftests even built?

The bpf_wq bits should be related to a similar-ish issue where one
config setting is not set and so it's not included in the final BTF.

I paged out how we can ignore selftests based on the .config, so if you
have any hints, that would be nice :)

Cheers,
Benjamin

> 
> 
> Thomas
> 
> On Wed, Mar 11, 2026 at 03:29:54PM +0100, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/vdso
> > head:   f7178f159b2a36d070fd43b0d751e4e4415ec39e
> > commit: 912632a7fd4cc1eac2778828d92e8fe46939d6bd [37/45] vdso/datapage: Trim down unnecessary includes
> > config: riscv-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20260311/202603111558.KLCIxsZB-lkp@intel.com/config)
> > compiler: riscv64-linux-gnu-gcc (Debian 14.2.0-19) 14.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260311/202603111558.KLCIxsZB-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202603111558.KLCIxsZB-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    In file included from progs/hid.c:3:
> > >> progs/hid_bpf_helpers.h:117:31: error: declaration of 'struct bpf_wq' will not be visible outside of this function [-Werror,-Wvisibility]
> >      117 | extern int bpf_wq_init(struct bpf_wq *wq, void *p__map, unsigned int flags) __weak __ksym;
> >          |                               ^
> >    progs/hid_bpf_helpers.h:118:32: error: declaration of 'struct bpf_wq' will not be visible outside of this function [-Werror,-Wvisibility]
> >      118 | extern int bpf_wq_start(struct bpf_wq *wq, unsigned int flags) __weak __ksym;
> >          |                                ^
> >    progs/hid_bpf_helpers.h:119:39: error: declaration of 'struct bpf_wq' will not be visible outside of this function [-Werror,-Wvisibility]
> >      119 | extern int bpf_wq_set_callback(struct bpf_wq *wq,
> >          |                                       ^
> > >> progs/hid.c:448:16: error: field has incomplete type 'struct bpf_wq'
> >      448 |         struct bpf_wq work;
> >          |                       ^
> >    progs/hid.c:448:9: note: forward declaration of 'struct bpf_wq'
> >      448 |         struct bpf_wq work;
> >          |                ^
> > >> progs/hid.c:487:18: error: incompatible pointer types passing 'struct bpf_wq *' to parameter of type 'struct bpf_wq *' [-Wincompatible-pointer-types]
> >      487 |         if (bpf_wq_init(wq, &hmap, 0) != 0)
> >          |                         ^~
> >    progs/hid_bpf_helpers.h:117:39: note: passing argument to parameter 'wq' here
> >      117 | extern int bpf_wq_init(struct bpf_wq *wq, void *p__map, unsigned int flags) __weak __ksym;
> >          |                                       ^
> >    progs/hid.c:490:26: error: incompatible pointer types passing 'struct bpf_wq *' to parameter of type 'struct bpf_wq *' [-Wincompatible-pointer-types]
> >      490 |         if (bpf_wq_set_callback(wq, wq_cb_sleepable, 0))
> >          |                                 ^~
> >    progs/hid_bpf_helpers.h:119:47: note: passing argument to parameter 'wq' here
> >      119 | extern int bpf_wq_set_callback(struct bpf_wq *wq,
> >          |                                               ^
> >    progs/hid.c:493:19: error: incompatible pointer types passing 'struct bpf_wq *' to parameter of type 'struct bpf_wq *' [-Wincompatible-pointer-types]
> >      493 |         if (bpf_wq_start(wq, 0))
> >          |                          ^~
> >    progs/hid_bpf_helpers.h:118:40: note: passing argument to parameter 'wq' here
> >      118 | extern int bpf_wq_start(struct bpf_wq *wq, unsigned int flags) __weak __ksym;
> >          |                                        ^
> >    progs/hid.c:503:24: error: incomplete definition of type 'struct hid_device'
> >      503 |         int hid = hid_ctx->hid->id;
> >          |                   ~~~~~~~~~~~~^
> >    progs/hid_bpf_helpers.h:59:9: note: forward declaration of 'struct hid_device'
> >       59 |         struct hid_device *hid;
> >          |                ^
> >    8 errors generated.
> > 
> > -- 
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> 
