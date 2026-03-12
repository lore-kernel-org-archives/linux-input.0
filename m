Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9E3317160;
	Thu, 12 Mar 2026 06:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773298004; cv=none; b=gxBvAH+ol/u8iWFBhLDaqwjgim/ORJGWtoow7zmwOTq1+SBZ1YSMawxK1Svph//CjW/CIM1cWsqWEHTCrUokfdSUSLPYLKmbXBVlQJWK6FBlQ8yNTw9HpoI2uVa9DQwOnvya+1WdNKxwmbKDoJkcc2O0T1O7SN9E3AgVJkRKc/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773298004; c=relaxed/simple;
	bh=T0ODP53dPZfx6uBhnVp3cJ4giaNRKnh9jAJhpRJe/sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i234NfGcy43O10kWO5Ujr6QjkMr9HSV+/w1AY4inb3XHsKmL3yfdG7G8lhyGgBtni/wnVhVjSmFMRdNKTOSeywQ0GHk1DJrkL9LHB8DitT+YZWwgfr/V/l6Z+pSfXJJ9J1ITWn/lJ8FEk9fcChPvC+u1TB0DUbaoDx426tm+LaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ilr8q3w7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zp5M91rv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ilr8q3w7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zp5M91rv"
Date: Thu, 12 Mar 2026 07:46:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773297995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LhT8DnaCn4aeyxuk52x6USFRxjvnO3V1rxo933HeMjk=;
	b=Ilr8q3w7+NO4lJO9tZ2H+w63Lrp2aekfrS7Q0eJBDEb5UVVCRHvg0y5CkO8HRI7CGD7cdC
	opZG9jtZ8Q3ce8eF172xXPTOurfaJHDv/O4dTufZ1lAtdkoA1nnB3B7wgVVkWMgeCgHV9E
	P0uHcBClauQQFIc1y7pm8bYSCcIegFqAlxplOpd9roqrapIv5O7stwf/Wa8vvE2ZSmZYf8
	CaviD0r1oRWm0kMEDBClTwAbA9tFUxk5KByM9VLUAAWtXmCESuj7r92XSbSomEO6JVlHOI
	MACRltuqFHmr5i7bffEz+mHMnpxN+1W09LsQUYNmsNSQIjcJ6mPtgwrRpxmzQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773297995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LhT8DnaCn4aeyxuk52x6USFRxjvnO3V1rxo933HeMjk=;
	b=zp5M91rv06D6BCgC5q+rv/cUJ4Hj8Fgay39cfHmgeOwh2C77Ps3QZDAw2F2AlUrU/0fVb2
	L+yiJdNi/XOVreDw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, 
	kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, 
	x86@kernel.org, Thomas Gleixner <tglx@kernel.org>
Subject: Re: [tip:timers/vdso 37/45] progs/hid_bpf_helpers.h:117:31: error:
 declaration of 'struct bpf_wq' will not be visible outside of this function
Message-ID: <20260312073810-db531b6e-ed24-4a55-865e-e7b94e90b8e6@linutronix.de>
References: <202603111558.KLCIxsZB-lkp@intel.com>
 <20260311160618-dbfa08f6-8cfa-4f81-94a2-d6d97f79ae93@linutronix.de>
 <abGeK0FpNn5uXi8B@beelink>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abGeK0FpNn5uXi8B@beelink>

Hi Benjamin,

thanks for the quick response.

On Wed, Mar 11, 2026 at 06:05:25PM +0100, Benjamin Tissoires wrote:
> On Mar 11 2026, Thomas Weißschuh wrote:
> > could you take a look at the report below?
> > This looks like an issue in the HID BPF subsystem, surfaced by my
> > unrelated change. Does this ring a bell for you?
> > 
> > I wasn't able to reproduce it so far, but will continue looking into it.
> 
> Both struct bpf_wq and struct hid_device should be generated in the
> vmlinux.h that we include in the selftests. So this is definitely not
> related to your patch AFAICT.

Ack. To be sure I sent this branch again through 0day and will see if it
breaks on the same commit.

> Looking in the config, we have `# CONFIG_HID_SUPPORT is not set` -> so
> that would explain why struct hid_device is not available. But in that
> case, why are the HID selftests even built?

CONFIG_DEBUG_INFO_BTF is also not set. So there should be no vmlinux.h
at all in the first. Which is exactly what happens in my attempts
to reproduce the issue. But even when fixing that up, the issue persists.

> The bpf_wq bits should be related to a similar-ish issue where one
> config setting is not set and so it's not included in the final BTF.

I'll look into how exactly things end up in vmlinux.h.
At least the headers for 'struct bpf_wq' are always included somewhere.
But maybe the type also needs to be used to define some structure.

> I paged out how we can ignore selftests based on the .config, so if you
> have any hints, that would be nice :)

Inspecting the kernel configuration might be hard, as there might be no file
for it available. Could you use vmlinux.h itself for feature detection?


Thomas

> > On Wed, Mar 11, 2026 at 03:29:54PM +0100, kernel test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/vdso
> > > head:   f7178f159b2a36d070fd43b0d751e4e4415ec39e
> > > commit: 912632a7fd4cc1eac2778828d92e8fe46939d6bd [37/45] vdso/datapage: Trim down unnecessary includes
> > > config: riscv-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20260311/202603111558.KLCIxsZB-lkp@intel.com/config)
> > > compiler: riscv64-linux-gnu-gcc (Debian 14.2.0-19) 14.2.0
> > > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260311/202603111558.KLCIxsZB-lkp@intel.com/reproduce)
> > > 
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202603111558.KLCIxsZB-lkp@intel.com/
> > > 
> > > All errors (new ones prefixed by >>):
> > > 
> > >    In file included from progs/hid.c:3:
> > > >> progs/hid_bpf_helpers.h:117:31: error: declaration of 'struct bpf_wq' will not be visible outside of this function [-Werror,-Wvisibility]
> > >      117 | extern int bpf_wq_init(struct bpf_wq *wq, void *p__map, unsigned int flags) __weak __ksym;
> > >          |                               ^
> > >    progs/hid_bpf_helpers.h:118:32: error: declaration of 'struct bpf_wq' will not be visible outside of this function [-Werror,-Wvisibility]
> > >      118 | extern int bpf_wq_start(struct bpf_wq *wq, unsigned int flags) __weak __ksym;
> > >          |                                ^
> > >    progs/hid_bpf_helpers.h:119:39: error: declaration of 'struct bpf_wq' will not be visible outside of this function [-Werror,-Wvisibility]
> > >      119 | extern int bpf_wq_set_callback(struct bpf_wq *wq,
> > >          |                                       ^
> > > >> progs/hid.c:448:16: error: field has incomplete type 'struct bpf_wq'
> > >      448 |         struct bpf_wq work;
> > >          |                       ^
> > >    progs/hid.c:448:9: note: forward declaration of 'struct bpf_wq'
> > >      448 |         struct bpf_wq work;
> > >          |                ^
> > > >> progs/hid.c:487:18: error: incompatible pointer types passing 'struct bpf_wq *' to parameter of type 'struct bpf_wq *' [-Wincompatible-pointer-types]
> > >      487 |         if (bpf_wq_init(wq, &hmap, 0) != 0)
> > >          |                         ^~
> > >    progs/hid_bpf_helpers.h:117:39: note: passing argument to parameter 'wq' here
> > >      117 | extern int bpf_wq_init(struct bpf_wq *wq, void *p__map, unsigned int flags) __weak __ksym;
> > >          |                                       ^
> > >    progs/hid.c:490:26: error: incompatible pointer types passing 'struct bpf_wq *' to parameter of type 'struct bpf_wq *' [-Wincompatible-pointer-types]
> > >      490 |         if (bpf_wq_set_callback(wq, wq_cb_sleepable, 0))
> > >          |                                 ^~
> > >    progs/hid_bpf_helpers.h:119:47: note: passing argument to parameter 'wq' here
> > >      119 | extern int bpf_wq_set_callback(struct bpf_wq *wq,
> > >          |                                               ^
> > >    progs/hid.c:493:19: error: incompatible pointer types passing 'struct bpf_wq *' to parameter of type 'struct bpf_wq *' [-Wincompatible-pointer-types]
> > >      493 |         if (bpf_wq_start(wq, 0))
> > >          |                          ^~
> > >    progs/hid_bpf_helpers.h:118:40: note: passing argument to parameter 'wq' here
> > >      118 | extern int bpf_wq_start(struct bpf_wq *wq, unsigned int flags) __weak __ksym;
> > >          |                                        ^
> > >    progs/hid.c:503:24: error: incomplete definition of type 'struct hid_device'
> > >      503 |         int hid = hid_ctx->hid->id;
> > >          |                   ~~~~~~~~~~~~^
> > >    progs/hid_bpf_helpers.h:59:9: note: forward declaration of 'struct hid_device'
> > >       59 |         struct hid_device *hid;
> > >          |                ^
> > >    8 errors generated.
> > > 
> > > -- 
> > > 0-DAY CI Kernel Test Service
> > > https://github.com/intel/lkp-tests/wiki
> > 
