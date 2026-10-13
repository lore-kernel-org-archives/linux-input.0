Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D66852189B;
	Tue, 13 Oct 2026 16:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791907245; cv=none; b=po60bvngk9OzjAbcY7ERlhk50/yYCzz3w9jsHOS2PNGrO07mIvSinEmCdOQAkMiAjsr33SglS2Y7OCaihfIFprc+ZnJHh8kqtVzce6E3OKD2hdxOKrH/MLCUSmYWWu7jbUBOVkYD4p6hSMTSjkQEpl+VeUJhz+ARUkGmMXbyDYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791907245; c=relaxed/simple;
	bh=1qu2uh3CZY0JT7r5gIUSNU+nY4jgeySPkXHgeH0JOpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCZpvR4ESjScrLFIxp3x7aQIprOB6S//PBw4erDA2bqxqh0f5ESmw/EB1n9hHyFdSJXmPnlDJ+rwH3Wn+1UtOZieZvkFoB/wBrHRQnFcmUVuh3PkEvaSfnzTelEkPEbzfk81r2P0G35Q23USUVHZbmso7goIA/C1/h7qiK2kuoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCV9Hlpa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCV9Hlpa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9B01F000FF;
	Tue, 13 Oct 2026 16:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791907242;
	bh=vbBBPcL6yB4r46XP1ZIa6OR56ps9QEjk24nUBenGNrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GCV9Hlpaz0APJvqMmbidbx1qVHrnBcrBMHBNdcI7rqNjED9odNUWndx8r67Tr+Cur
	 eAjLiwjZlfjKudHi5se+GuobKXSh2BD9/nrSm6PSo+c+1Yn2A5bPptNi5d8qEbhOw5
	 /RUvd/yqBPFCN8pRzih1OJK/S/J3Z7rqsiru/6VxMqp0soxMCY8AmCqCU8Fp2FMRNx
	 a1opty6cgUt/kvd/q+kLfp7RlbWXbE2VFSdxJNptkrpPyQz8xTb+NOC7jNGkbepVdR
	 GQiVN5V+PauFX0ZKmGt1sjpudc/aOfpasITAInlMSDOho0/vzs3CSV15hjP/Jx9igs
	 Ed9Mv+owuHzGw==
Date: Tue, 13 Oct 2026 18:00:39 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Shi Lecun <shilc2025@mail.sustech.edu.cn>
Cc: linux-input <linux-input@vger.kernel.org>, jikos <jikos@kernel.org>, 
	bpf <bpf@vger.kernel.org>
Subject: Re: HID-BPF: CAP_BPF-only process can inject input into host session
Message-ID: <asyhxnfwslRJVvlr@beelink>
References: <tencent_3B9FD2455BEBDF351B2CD453@qq.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_3B9FD2455BEBDF351B2CD453@qq.com>

Hi,

On Oct 12 2026, Shi Lecun wrote:
> Hi,
> 
> Granting a workload permission to manage eBPF can also grant it the
> ability to type on the host.
> 
> A process that holds only CAP_BPF, running as a non-root user inside a
> container with no device nodes and no X11 or Wayland socket, can load a
> BPF_PROG_TYPE_SYSCALL program that calls hid_bpf_allocate_context() and
> hid_bpf_input_report(), run it through BPF_PROG_TEST_RUN, and inject
> keyboard reports into an already-authorized HID device.  The reports
> travel the normal HID input path and reach the host's unlocked session
> (X11 desktop or text console) as if typed on the device, so the attacker
> executes commands as the logged-in user; on a server with a management
> controller, that session is the operator's console.  Container platforms
> grant CAP_BPF to networking and observability workloads, so the
> capability holder is realistic rather than contrived.

Yes, this is expected, somehow. HID-BPF is required to fix devices. But
it relies on mechanisms primarily used by networking tools, and when you
allow networking tools to monitor the container, they effectively can
alter HID devices as well. I'm not sure we want another CAP_*.

> 
> Detailed description:
> 
> - Problem: the unattached syscall path can inject input with CAP_BPF
>   alone.  Attaching a struct_ops program to a device requires
>   CAP_BPF+CAP_PERFMON, but a syscall program calling
>   hid_bpf_input_report() needs only CAP_BPF and leaves no per-device
>   record.
> 
> - Reachability: a non-root container holding CAP_BPF, one
>   already-authorized HID device, and an unlocked session.  No malicious
>   device, firmware, USB traffic, verifier flaw or memory-safety bug is
>   involved.
> 
> - Effect: arbitrary commands typed as the host user in the focused
>   session, including a server's BMC virtual console.  With CAP_PERFMON,
>   the struct_ops path can in addition rewrite the report descriptor so
>   an authorized mouse presents a keyboard collection.
> 
> - Method and testing: a reproducer built against the struct_ops HID-BPF
>   API, run in QEMU on Ubuntu 26.04 / kernel 7.0.0-28-generic
>   (CONFIG_HID_BPF=y, BTF enabled) and on an Arch 7.1.5 host.
>   Capability-restricted non-root runs with setpriv confirm the three
>   cases above; 1000 of 1000 injections were accepted; commands landed in

The contrary would have been problematic: this just says that the code
is working deterministically, which is expected :)

>   both an X session and a text console.  Older, pre-struct_ops kernels
>   are untested.
> 
> - Possible fix: a capability check on the syscall path that reaches
>   hid_bpf_input_report()/hid_bpf_try_input_report(), or a policy gate at
>   program load.  We implemented the latter as an LSM program on
>   security_bpf_prog_load that denies a load calling any of the seven
>   HID-BPF kfuncs; it stops the injector with -EPERM and costs about
>   24 us on a worst-case 4096-instruction load, with no input-path cost.

FWIW, Toke presented a policy for BPF at Plumbers last week[0]. Such
RBACd policy can allow a container to be restricted to use HID-BPF.
But the LSM might work just as well. I just don't want the module to
prevent HID-BPF from running on legitimate use case.

> 
> My reading is that this is not a kernel vulnerability: the program is
> verifier-clean, no check is bypassed and nothing is memory-unsafe -- the
> malice is in the report data.  The behavior also matches
> Documentation/hid/hid-bpf.rst, which documents hid_bpf_input_report()
> from syscall programs and already calls the tracing use case "god-mode".
> What I cannot settle myself is whether the capability split is what you
> intended.

There was nothing specifically intended for the split
CAP_BPF/CAP_PERFMON. But I don't really see why you are focusing on this
split when the report from above also mentions that CAP_PERFMON is also
used in conjunction with CAP_BPF to ease the injections of keys (without
needing to know in advance the report format).

I think the biggest issue IMO is that BPF was primarily introduced with
the network use case in mind, and CAP_BPF is probably too coarse.

That's where projects like RBACd and the LSM program you mentioned come
in handy.

> 
> The one point I would like an answer on is the asymmetry itself: if the
> CAP_PERFMON requirement is about the attach/IRQ context rather than
> about input, then this is expected and I have no further concern.  

struct_ops is classed as a perfmon program type because it has raw
kernel-memory access, independent of HID-BPF.

> If you
> would rather close it, I can post the LSM gate, though it is not the only
> possible fix.

I would be curious to see the LSM gate :)

> 
> What I am asking for:

FWIW, the convention on the list is to just discuss inline, so it feels
weird to ask summary questions at the end.

> 
> 1. Confirm or correct the reading above.

see above

> 2. If it is a bug: say so, and I will follow the security process
>    instead.

I wouldn't call it a bug. But yes, hid_bpf_input_report is intentionally
callable from a CAP_BPF-only syscall program; that was a deliberate
choice so fixup tooling doesn't need tracing privileges, and gating it
further is a policy question better solved with RBACd/LSM than a new
CAP_*.

However, Alexei and the other folks from the bpf community might
disagree with me.

> 3. If it is intended: a short statement on this thread would help, and
>    with your permission I would cite it as the maintainers' position.  I
>    am not asking for a CVE or for you to endorse the paper.

What kind of short statement are you asking for? To me, we all know that
there are way too many capabilities with BPF, and that's why the LSM
hook you used, and projects like RBACd [0] are useful.

> 
> This comes from a paper we are preparing. It is not submitted yet and
> nothing will be published for some time, so there is no deadline here.
> The reproducer, logs and code are available on request, and I am happy to
> discuss everything on the list.
> 
> Thanks,
> Shi Lecun <shilc2025@mail.sustech.edu.cn>

Cheers,
Benjamin

[0] https://lpc.events/event/20/contributions/2441/
