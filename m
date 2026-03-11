Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444EF3DC4BB;
	Wed, 11 Mar 2026 15:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773241783; cv=none; b=XYSjeYXygciPDTCnPz1e310Li4PZjKIA5zgXKC7pomLZvm8XXXzCU3bLXHqt8+OZA0KVPD6xR8/W7lZQ8PfE8T3yHV+9Lz3noYWitCxJ0s5yGrAwya1m8L2laExu7CHnly8+NrbygkYEYXBFKT/TyPNfBRiszh1k/7qadlmAneY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773241783; c=relaxed/simple;
	bh=I2mfo7qVYmAWe5mDiS4CnkB0gGFkCY+8zPKDmAu0ygs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3DOAUEFgGdFpeAyxp3AZS/geC2EyO8IlmQND/Qu7amWvT0ZuL8JFu2DESMLsesgT4/6Bwc6zBPIx13lE7/GAD8kYpvrdZexWJLv3Mt14kmYNW7glKB7m1rNL4LaMdMJ8WfMu4G3tu1EzFWykm/oksOF7VaJBE4UHmkHx7M5QTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4IZupYG5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6ceOLEU7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4IZupYG5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6ceOLEU7"
Date: Wed, 11 Mar 2026 16:09:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773241778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RfGiGE4E37F1lCJNzRO/ltlbQa90G36FBWlUjaMcpt8=;
	b=4IZupYG5KkAOv1mwnmY+Hhce70eUaeOUTtbMN0qiiDttEWYCRM7q9R7mQrm+8WyLXC7swd
	vMzlbVk8mx+BUMlU4puhEdsN/rrmRngbbP5GhXdBa7TlTeXzz3EvEM0DSQw83KnHI3bQTE
	twqDWCi7USFHe9Q0VOTByk2aJiloarpQGEp0QQbGlPt3uParL7f9MEMqdCrXGPMOFUjES1
	t/bvBgdAvPiaz9jc8aABYmt7Z0Ip4ZiFk3/Ac2vAjaqirkdRUujHf4KDhFGKmAXbmXX60H
	/o295OplxWH8YXqGKkL4OwKDnbJjc8JaUljgaXs83kWbyM9C1LIjx5vG3F+1Ow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773241778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RfGiGE4E37F1lCJNzRO/ltlbQa90G36FBWlUjaMcpt8=;
	b=6ceOLEU7HqLZJXB93/9rN90NpUgY/4SUGIeOZqY5ebIXSNSOT+4+1FUmbZYtfJ7RNAjHF5
	tKqp69Ectxk38kBA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, kernel test robot <lkp@intel.com>, 
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [tip:timers/vdso 37/45] progs/hid_bpf_helpers.h:117:31: error:
 declaration of 'struct bpf_wq' will not be visible outside of this function
Message-ID: <20260311160618-dbfa08f6-8cfa-4f81-94a2-d6d97f79ae93@linutronix.de>
References: <202603111558.KLCIxsZB-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202603111558.KLCIxsZB-lkp@intel.com>

Hi Jiri and Benjamin,

could you take a look at the report below?
This looks like an issue in the HID BPF subsystem, surfaced by my
unrelated change. Does this ring a bell for you?

I wasn't able to reproduce it so far, but will continue looking into it.


Thomas

On Wed, Mar 11, 2026 at 03:29:54PM +0100, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/vdso
> head:   f7178f159b2a36d070fd43b0d751e4e4415ec39e
> commit: 912632a7fd4cc1eac2778828d92e8fe46939d6bd [37/45] vdso/datapage: Trim down unnecessary includes
> config: riscv-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20260311/202603111558.KLCIxsZB-lkp@intel.com/config)
> compiler: riscv64-linux-gnu-gcc (Debian 14.2.0-19) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260311/202603111558.KLCIxsZB-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202603111558.KLCIxsZB-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from progs/hid.c:3:
> >> progs/hid_bpf_helpers.h:117:31: error: declaration of 'struct bpf_wq' will not be visible outside of this function [-Werror,-Wvisibility]
>      117 | extern int bpf_wq_init(struct bpf_wq *wq, void *p__map, unsigned int flags) __weak __ksym;
>          |                               ^
>    progs/hid_bpf_helpers.h:118:32: error: declaration of 'struct bpf_wq' will not be visible outside of this function [-Werror,-Wvisibility]
>      118 | extern int bpf_wq_start(struct bpf_wq *wq, unsigned int flags) __weak __ksym;
>          |                                ^
>    progs/hid_bpf_helpers.h:119:39: error: declaration of 'struct bpf_wq' will not be visible outside of this function [-Werror,-Wvisibility]
>      119 | extern int bpf_wq_set_callback(struct bpf_wq *wq,
>          |                                       ^
> >> progs/hid.c:448:16: error: field has incomplete type 'struct bpf_wq'
>      448 |         struct bpf_wq work;
>          |                       ^
>    progs/hid.c:448:9: note: forward declaration of 'struct bpf_wq'
>      448 |         struct bpf_wq work;
>          |                ^
> >> progs/hid.c:487:18: error: incompatible pointer types passing 'struct bpf_wq *' to parameter of type 'struct bpf_wq *' [-Wincompatible-pointer-types]
>      487 |         if (bpf_wq_init(wq, &hmap, 0) != 0)
>          |                         ^~
>    progs/hid_bpf_helpers.h:117:39: note: passing argument to parameter 'wq' here
>      117 | extern int bpf_wq_init(struct bpf_wq *wq, void *p__map, unsigned int flags) __weak __ksym;
>          |                                       ^
>    progs/hid.c:490:26: error: incompatible pointer types passing 'struct bpf_wq *' to parameter of type 'struct bpf_wq *' [-Wincompatible-pointer-types]
>      490 |         if (bpf_wq_set_callback(wq, wq_cb_sleepable, 0))
>          |                                 ^~
>    progs/hid_bpf_helpers.h:119:47: note: passing argument to parameter 'wq' here
>      119 | extern int bpf_wq_set_callback(struct bpf_wq *wq,
>          |                                               ^
>    progs/hid.c:493:19: error: incompatible pointer types passing 'struct bpf_wq *' to parameter of type 'struct bpf_wq *' [-Wincompatible-pointer-types]
>      493 |         if (bpf_wq_start(wq, 0))
>          |                          ^~
>    progs/hid_bpf_helpers.h:118:40: note: passing argument to parameter 'wq' here
>      118 | extern int bpf_wq_start(struct bpf_wq *wq, unsigned int flags) __weak __ksym;
>          |                                        ^
>    progs/hid.c:503:24: error: incomplete definition of type 'struct hid_device'
>      503 |         int hid = hid_ctx->hid->id;
>          |                   ~~~~~~~~~~~~^
>    progs/hid_bpf_helpers.h:59:9: note: forward declaration of 'struct hid_device'
>       59 |         struct hid_device *hid;
>          |                ^
>    8 errors generated.
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
