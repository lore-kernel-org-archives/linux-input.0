Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B944040BCDB;
	Sun,  4 Oct 2026 22:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.155.198.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791152503; cv=none; b=hP5NcYUQLz0SEAJoHtZvA/+7a3j3G/qmQopPJYb39DFEgyPypN20ETVfDg1uIp/diGfrAe7hPCIR1NLLN+wcOb68sjQn/gDsB1HA/GmrVbKT4HGbZ9V0y9nbsH4tXVONd3KkCZ4Y8fMnUmewpU9l91961IX0f729rgW2ZwPkD5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791152503; c=relaxed/simple;
	bh=8MfZas74TP4bH2JkIBPs6F1Wj3cq6DvSuL/z6D0z5ro=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XMkpqibyn48tYhDvpD2uwRxOE32m5JsEQEzT5g3o3BwcH5c+hiC2XvWc9sP8vUr1qhDP1vGwhWhG1PR4/uHxitA0S/UmlWzxXkNwIIH903s0X2ePc5gZGzaJ6G3wzp0vNaKzDUDBF3AsBSyQ60Zm9au3e1s0xQowgkT5gDOZS0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Af33HbjK; arc=none smtp.client-ip=35.155.198.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Af33HbjK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1791152497; x=1822688497;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gGkA92gKn6Umlg7Do4va51y7OdkAYyeZaeaCQws/E94=;
  b=Af33HbjKYOCoaBHpbzVoHqqWybQPyWBlTj0a00UAD2IeqbAc3dpdQkBL
   mh4WA9KlMwvATVJKClsCma4kaZvyhOSZmnydGJyi+AiB5AhirTES9AkYQ
   Bl72vIFxnHNfYbAsPgH1GOuHcyRUSMDYBjuq29vnP4tVB5c9OyDTOzTox
   dT/QMY1RX1/1ZdkuQGmEEWrRhyvs10S/rU8Ta/PeEVA/gaw1ffZkPsuR7
   zZ+P9C+lTnTro5hq1CDTahhEnDh1GbFv9TRyjUihioWWtkcv/5u6Edvo3
   0bXjSK8UAustB45O2nSHSJrLvOEWZLs3GVQMCXFtI0EX6dtSIEQkq8g4n
   g==;
X-CSE-ConnectionGUID: bhwPuL6iQoibWn7EKQVtmQ==
X-CSE-MsgGUID: iF4tuhgNQbWGyCqDCfgFXA==
X-IronPort-AV: E=Sophos;i="6.27,141,1787011200"; 
   d="scan'208";a="30278872"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2026 22:21:32 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:21386]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.164:2525] with esmtp (Farcaster)
 id 0691faea-dd80-4741-bdc2-6e25b9dd697c; Sun, 4 Oct 2026 22:21:32 +0000 (UTC)
X-Farcaster-Flow-ID: 0691faea-dd80-4741-bdc2-6e25b9dd697c
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Sun, 4 Oct 2026 22:21:31 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Sun, 4 Oct 2026 22:21:31 +0000
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
Date: Sun, 4 Oct 2026 22:21:27 +0000
Message-ID: <20261004222127.31128-1-wanjay@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <44315425-c505-46fe-8379-f19d78ff3abb@linux.dev>
References: <44315425-c505-46fe-8379-f19d78ff3abb@linux.dev>
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

>    - If I know I don't need BPF on the workload, and these 5.4 MB
>      bite me, I can just turn off BPF

They cannot, even when they know they do not need it.  As the cover
letter says, the cloud provider usually ships one kernel build to all of
its customers.  Customers install their own packages and workloads around
that kernel, but they do not build or customize the kernel.  Turning
BPF off is not a switch they have.

> What I find strange is for a user of this scale *to not know* whether
> BPF will be used in the workload or not, which is what lazy load may
> solve.

They do know.  They run predictable workloads on a large number of
small instances, and BPF is not part of them.  They spread the load by
resource usage, so at that scale every byte matters: more free memory
on each instance means fewer instances in total.

>    * Compress it.
[...]
>      Keep zstd-compressed blob in the kernel image and decompress and
>      parse it synchronously on first use.

Thanks for putting this forward.  This compression approach is simpler 
than loading a module.  I expect the overall code complexity to stay similar
to v3, since both need to find the first user and defer the module BTF parsing
until then, but it should be easier to merge into mainline because it avoids
the request_module() deadlocks.

Would you like to prepare it for a formal submission, or would you
like me to do so?  Either works for me.  Ideally it lands in time for
the next LTS kernel, so that we can adopt it there.

From what I can see, most of the work left is in that deferral.
Whoever needs the BTF first also parses the waiting module BTFs and
replays the queued registrations, struct_ops ->init() included, under
whatever locks it holds at that point, e.g. event_mutex or
bpf_verifier_lock, or inside the module notifier.  So the
cand_cache_mutex ABBA you found may not be the only deadlock.  Besides
that, only x86_64 was touched so far, so it needs extending to the
other architectures as well.
