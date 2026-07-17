Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5C6330662
	for <linux-input@vger.kernel.org>; Fri, 17 Jul 2026 04:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784261303; cv=none; b=oCfWYMt5985lRHs0KcqpSL2t0oEtcsWqxCBvj7+JKxLwqDpiNa7wWMHHXZqZJUgYcHqh7MYqAVi46Cw0dQPqK/R2qX3bTV1Ux0JacPmpdT1foZvXombo9u4NpyztRYEv8UwAz+eYMLRbLR9e6guMSRnooJ2hjqRLD6MZ3CDS51g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784261303; c=relaxed/simple;
	bh=m1mIj8ecyRUgwmnqfHlFCyj8EMlXqXT7HvWyFDjxAxo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V7wdbV1FbCChYNcl2n4XJIp7D4t+S/8EgzBK6lSH+qQ1UTX6Ro6WgrrQwKHK0Kprjc+9xEb06NQwSfkECFOlThUdMS3AbESIftChxj3HsYMrQPI6T/aL3wKdn/M7pR7lcfrC4Gj+xlEuOM3kN+5WcQDmKWQda/ePKTr3FrmiRrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8jLY8SG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8jLY8SG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2AA1F000E9;
	Fri, 17 Jul 2026 04:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784261301;
	bh=Kv5CNbxlGsoyKfoGoRalERA5AIr3cfSNxx5qF4vj9rU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D8jLY8SGn8uq0uyB33vgDcDndRGUPHAKWYSoNPy6BNlUrkd5PUgfZVndCl+JyycpV
	 Xv9b08ERtkvPZi08Z0cqmTDSmB782bFdcGq5K1i9dG0t1v6w6Ns6/QxL1wgXUbgDNB
	 YihjiXCCL8T7bijVujlVsYas9Dz9HwWLIdCxC+0l2NDCtxNBExC8lvk8I/Y5jiJS/W
	 pbRY1j4V0h9XipEwikHe1Ql8lxmxtlKjqd290509Vq4Al1ZULnjfNQm9+fakp1mQb7
	 M7I01N/slR/4aMAfVV9KaWSiNuGUjsidiOHx2KR1xK8A6sZz5oOLJFmFQ3B254jNhF
	 DtiMzWE+fNEKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/3] HID: Intel-thc-hid: Intel-quickspi: Refine
 recover callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Even Xu" <even.xu@intel.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260717035609.3874015-4-even.xu@intel.com>
References: <20260717035609.3874015-1-even.xu@intel.com>
 <20260717035609.3874015-4-even.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 04:08:20 +0000
Message-Id: <20260717040821.2D2AA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Race condition during device teardown allows the IRQ thread handle=
r to unconditionally schedule `recover_work` after `cancel_work_sync()` has=
 completed, leading to a Use-After-Free.
--

--- Patch [3]: [PATCH v4 3/3] HID: Intel-thc-hid: Intel-quickspi: Refine re=
cover callback ---
commit 476846b5d6215f9a1a461a86f427618ddd19b6d1
Author: Even Xu <even.xu@intel.com>

HID: Intel-thc-hid: Intel-quickspi: Refine recover callback

This patch updates the recovery flow to execute in a workqueue rather than
directly in the IRQ handler. It introduces a recover_work item and a
recovery_disabled flag to manage the teardown process.

> diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c b/dr=
ivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> index 4ae2e1718b30c..db7ede5cc7a29 100644
> --- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> +++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
[ ... ]
> @@ -337,11 +334,10 @@ static irqreturn_t quickspi_irq_thread_handler(int =
irq, void *dev_id)
>  	}
> =20
>  end:
>  	if (err_recover)
> -		if (try_recover(qsdev))
> -			qsdev->state =3D QUICKSPI_DISABLED;
> +		schedule_work(&qsdev->recover_work);

[Severity: High]
Can this schedule the work after it has been cancelled during device teardo=
wn?

Since the threaded IRQ handler doesn't check the recovery_disabled flag
before calling schedule_work(), if quickspi_irq_thread_handler() runs
concurrently with quickspi_dev_deinit():

CPU 1
quickspi_dev_deinit()
    WRITE_ONCE(qsdev->recovery_disabled, true);
    cancel_work_sync(&qsdev->recover_work);
    // returns, and eventually devres frees qsdev

CPU 2
quickspi_irq_thread_handler()
    ...
    if (err_recover)
        schedule_work(&qsdev->recover_work);

Could CPU 2 queue the work after CPU 1 finishes cancel_work_sync()?

If the scheduled work executes after qsdev has been freed, will this cause a
use-after-free when try_recover() reads qsdev->recovery_disabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717035609.3874=
015-1-even.xu@intel.com?part=3D3
