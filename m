Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7E843DEC6;
	Fri,  2 Oct 2026 07:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.1.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790926465; cv=none; b=amkjYiYHW3DCLDIyKTUmXCMwGMWsqWbajf//YSIO7DWlmFIXitiQJhxYtyaf5oR2XzCzvg2uajjD9XtA/+tvsGP9fmwUL3aGs70gu12Hp/qhM5ESknDuFd+LrVeMtAu5V7LkPhA6Lqf730VX61N8wMpQVnKkj2eySzIvWQYa71Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790926465; c=relaxed/simple;
	bh=m+LVU2zi0zSOvknT2CQZ4vuI1VWQtPXUViI/XoHlI50=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M+d5T2ds2YMHYPnnG7W7IdERmZlXmNQQ+UehJrh/xK4wXjCkJ9nGxbWgjSnerfezJT8yAQdIAHbMGCrveDPen6HBhs19LPtL554nbD4YYK9TGaw22bzHGzeH3XJiEbZWfRZzwGz6GRdL4YG+8yz8ScwvwUgrm4PBZFb8u4lqh10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=pWkW/SR5; arc=none smtp.client-ip=44.246.1.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="pWkW/SR5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790926463; x=1822462463;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tpiacak94CnVvVjiQqt6BeZBKKqRNWtVDXJ5p2keyyY=;
  b=pWkW/SR5o4ecfiiDnP7CK1rmOpiI1VeyVJ6JWRumilOAInAoMaI/m/F+
   OEx9y8NDVUzFsmRn1Y0urdTZRVruBT+JKCIfohxUQoIF8PZUZ+zx50Cpr
   DF4rTY2doqH2dq6PXt+krMhaO+c/CwDBtA3bIdYVgaVDXAtolsO186IdI
   1iU3rsmUS92WZB3xOamZJTGvFsCEtIofPrb/HF1KEUtzWDbfYdv1CNLye
   dPZll+uMcY0JB+gKg6XNPyC/SOInfqGxv2OPhrSIPh4l+sl8/5sbbST73
   bAvDPwCSTCYUlD4bIi+c/1BbVcsaHeJZNEEt5ZMShZYxqj6PYmu2OJ1nz
   Q==;
X-CSE-ConnectionGUID: mQGoYcZMSYWiuYG0x9YIvQ==
X-CSE-MsgGUID: yxmXURUMRpy+DovE+/uubw==
X-IronPort-AV: E=Sophos;i="6.27,136,1787011200"; 
   d="scan'208";a="30213323"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 07:34:23 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:10260]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.164:2525] with esmtp (Farcaster)
 id c36c8b8c-7ef4-4a34-8890-c411c7f7ff52; Fri, 2 Oct 2026 07:34:23 +0000 (UTC)
X-Farcaster-Flow-ID: c36c8b8c-7ef4-4a34-8890-c411c7f7ff52
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Fri, 2 Oct 2026 07:34:23 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Fri, 2 Oct 2026 07:34:22 +0000
From: Jay Wang <wanjay@amazon.com>
To: <ihor.solodrai@linux.dev>, <bpf@vger.kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
	<memxor@gmail.com>
CC: <alan.maguire@oracle.com>, <martin.lau@linux.dev>,
	<yonghong.song@linux.dev>, <jolsa@kernel.org>, <qmo@kernel.org>,
	<nathan@kernel.org>, <nsc@kernel.org>, <linux-kbuild@vger.kernel.org>,
	<linux@weissschuh.net>, <christian@heusel.eu>, <mcgrof@kernel.org>,
	<petr.pavlu@suse.com>, <samitolvanen@google.com>,
	<linux-modules@vger.kernel.org>, <rostedt@goodmis.org>,
	<mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>,
	<linux-trace-kernel@vger.kernel.org>, <acme@kernel.org>,
	<namhyung@kernel.org>, <irogers@google.com>,
	<linux-perf-users@vger.kernel.org>, <jikos@kernel.org>, <bentiss@kernel.org>,
	<linux-input@vger.kernel.org>, <tj@kernel.org>, <void@manifault.com>,
	<arighi@nvidia.com>, <changwoo@igalia.com>, <sched-ext@lists.linux.dev>,
	<shuah@kernel.org>, <linux-kselftest@vger.kernel.org>, <ojeda@kernel.org>,
	<rust-for-linux@vger.kernel.org>, <arnd@arndb.de>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<abuehaze@amazon.com>, <doebel@amazon.de>, <mpohlack@amazon.de>,
	<jay.wang.upstream@gmail.com>
Subject: Re: [PATCH bpf-next v4 00/12] bpf: make the vmlinux BTF an on-demand loadable module (CONFIG_DEBUG_INFO_BTF=m) to save ~5.4 MB memory
Date: Fri, 2 Oct 2026 07:34:22 +0000
Message-ID: <20261002073422.14253-1-wanjay@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <596bfb65-db2d-413b-8039-c921031b50fd@linux.dev>
References: <596bfb65-db2d-413b-8039-c921031b50fd@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

> A question I had: is it really worth 2k of complicated kernel code to
> *maybe sometimes* save <10Mb of memory?

There are many reasons this is worth it.  The main ones:

1. This did not start from a number we picked, but from a real use
   case: users who run large fleets of small instances, 1 GiB of
   memory or less, with their workloads sized to fit.  We are not able
   to disclose more detail, but for them 5.4 MB on every instance is
   real money, and it can be exactly what pushes a workload over its
   memory budget and onto the next instance size.  That is why we took
   this on, even though we knew it would not be a small change.

2. Loading code and data only when a system needs them is what kernel
   modules exist for.  And most of them take well under ~1 MB once
   loaded (nf_conntrack, overlay, vfat); even big ones like ext4, kvm
   and btrfs stay around 1-2.5 MB.  The vmlinux BTF is 5.4 MB.

3. We are not alone in trying to keep BTF out of memory until it is
   needed.  The inline BTF work [1] plans to deliver its data, which
   is even larger, through a module too.  The .BTF.link record and the
   resolve_btfids option that serve both are already part of this
   series (patch 10), so this is not machinery for the vmlinux BTF
   alone.

> Do those tiny VMs that you target run systemd with BPF LSM?

Not necessarily, and that is the image's choice.  Even with BPF LSM
built in and bpf in CONFIG_LSM, memory-conscious users can turn it off
at boot with an lsm= list that leaves it out, and then systemd does not
load restrict_fs at all.

And even where user space is in the way, which as above it does not
have to be, the answer is to fix user space so it gets this win too,
not to give up on it.

> If the answer is "yes" for the majority of them,

"The majority" is also hard to pin down here: what runs at boot
depends on the user space packages built into each image, and on the
workload.

So the question should be what it takes to make this work, not whether
to drop it because it is complicated.  If there are ways to cut it
down, or issues found in the implementation, we would be happy to take
them and go through every one.


[1] https://lore.kernel.org/bpf/20260916074118.1007116-1-alan.maguire@oracle.com/
