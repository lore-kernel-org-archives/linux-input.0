Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289AA368950;
	Fri, 28 Aug 2026 15:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787931915; cv=none; b=pDLLE2PXQLD8VBDKsxGbY8pbh9eZCgUVgZHwnA8MdC7EjCyTzftGZdykHAmfMRy3AsXeCowG2/gmZ4TMLrat+CdiwQmJWeMSZ30ED89JZPCIJt5VnP1+D/MhaxSGVc2PHyFUPDgBd4KpKVIEq3mw6NsmDp5A7zicnUF+hQ4qpRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787931915; c=relaxed/simple;
	bh=oEGD98eP5LuYUS7ScktmqudS+PymyQ1EvYYYUzfHpHM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cbLfQER41Gikg4b0Nmo5HtWPcoby/7/RKFSjWPjnPLV1Xe8tSRbiQvxC8rGDyPndHMuWJcPey0Gs5ZQ4lYlLiMHtv0zHppDHgdwTOzMNPBMl5OB7UI4gHkzKYYqHeamVqT7LaLzByMO0P7K4X5+udD8CBTv40ynkDzhuwcW/8Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xm2W10pb; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xm2W10pb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787931913; x=1819467913;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=oEGD98eP5LuYUS7ScktmqudS+PymyQ1EvYYYUzfHpHM=;
  b=Xm2W10pbcxn8MNhYIiKUXolsGF+SAdcct4KNdOYyi1puBuAcuNX6JvqB
   6EnLNVSzy/7+G2iz0/ZJloVQC4WFYzINMSq6KTW+aRS4esxpFy7b3ztE2
   87h18ksdJdhM1Rk3MzFM7KHabnmaEQuCG4fOSOm+HO+6c/r/T+mRe3Plt
   Li7dx8St3Pi9+l7a3RCWzI+hXr1PtJkjQ1V8hOl7rNcAXTLfJcT9bWzT2
   7yozzinQwdVH1nsCVCl5Fv60Kjq5BlaTxwI70ojh01b31Xt7c4Wdm1crz
   CzVl2CrGhxxdbagKVp5k3ClHuyUTPYeSJgrtCQi9PvU+drm5OQcnwGsyE
   g==;
X-CSE-ConnectionGUID: NLiP/h42T+axTpT8ZZYyKw==
X-CSE-MsgGUID: ebz6XvMaQq65YJQX7YFcCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11889"; a="88648712"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="88648712"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 08:45:13 -0700
X-CSE-ConnectionGUID: ktkROrMOT+KLwjalPUsyag==
X-CSE-MsgGUID: sDIX/640RzOLCN7lCTUGJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="268228672"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.124.223.143])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 08:45:12 -0700
Message-ID: <42d7b3ad68ed7870e141fcfa62a483356e7c5b7f.camel@linux.intel.com>
Subject: Re: [BUG] ish_hw_start -- page fault on a PIO cookie: intel_ish_ipc
 maps an I/O BAR and dereferences it
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Farhad Alemi <farhad.alemi@berkeley.edu>, Jiri Kosina
 <jikos@kernel.org>,  Benjamin Tissoires	 <bentiss@kernel.org>, Zhang Lixu
 <lixu.zhang@intel.com>
Cc: falemi@asu.edu, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 28 Aug 2026 08:45:11 -0700
In-Reply-To: <CA+0ovCgaya8JEc4xmBKPbe5AbrPuaK0tUKxuOxQYMsPTQT1ALw@mail.gmail.com>
References: 
	<CA+0ovCgaya8JEc4xmBKPbe5AbrPuaK0tUKxuOxQYMsPTQT1ALw@mail.gmail.com>
Autocrypt: addr=srinivas.pandruvada@linux.intel.com; prefer-encrypt=mutual;
 keydata=mQGNBGYHNAsBDAC7tv5u9cIsSDvdgBBEDG0/a/nTaC1GXOx5MFNEDL0LWia2p8Asl7igx
 YrB68fyfPNLSIgtCmps0EbRUkPtoN5/HTbAEZeJUTL8Xdoe6sTywf8/6/DMheEUzprE4Qyjt0HheW
 y1JGvdOA0f1lkxCnPXeiiDY4FUqQHr3U6X4FPqfrfGlrMmGvntpKzOTutlQl8eSAprtgZ+zm0Jiwq
 NSiSBOt2SlbkGu9bBYx7mTsrGv+x7x4Ca6/BO9o5dIvwJOcfK/cXC/yxEkr1ajbIUYZFEzQyZQXrT
 GUGn8j3/cXQgVvMYxrh3pGCq9Q0Q6PAwQYhm97ipXa86GcTpP5B2ip9xclPtDW99sihiL8euTWRfS
 TUsEI+1YzCyz5DU32w3WiXr3ITicaMV090tMg9phIZsjfFbnR8hY03n0kRNWWFXi/ch2MsZCCqXIB
 oY/SruNH9Y6mnFKW8HSH762C7On8GXBYJzH6giLGeSsbvis2ZmV/r+LmswwZ6ACcOKLlvvIukAEQE
 AAbQ5U3Jpbml2YXMgUGFuZHJ1dmFkYSA8c3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5j
 b20+iQHRBBMBCAA7FiEEdki2SeUi0wlk2xcjOqtdDMJyisMFAmYHNAsCGwMFCwkIBwICIgIGFQoJC
 AsCBBYCAwECHgcCF4AACgkQOqtdDMJyisMobAv+LLYUSKNuWhRN3wS7WocRPCi3tWeBml+qivCwyv
 oZbmE2LcxYFnkcj6YNoS4N1CHJCr7vwefWTzoKTTDYqz3Ma0D0SbR1p/dH0nDgN34y41HpIHf0tx0
 UxGMgOWJAInq3A7/mNkoLQQ3D5siG39X3bh9Ecg0LhMpYwP/AYsd8X1ypCWgo8SE0J/6XX/HXop2a
 ivimve15VklMhyuu2dNWDIyF2cWz6urHV4jmxT/wUGBdq5j87vrJhLXeosueRjGJb8/xzl34iYv08
 wOB0fP+Ox5m0t9N5yZCbcaQug3hSlgp9hittYRgIK4GwZtNO11bOzeCEMk+xFYUoa5V8JWK9/vxrx
 NZEn58vMJ/nxoJzkb++iV7KBtsqErbs5iDwFln/TRJAQDYrtHJKLLFB9BGUDuaBOmFummR70Rbo55
 J9fvUHc2O70qteKOt5A0zv7G8uUdIaaUHrT+VOS7o+MrbPQcSk+bl81L2R7TfWViCmKQ60sD3M90Y
 oOfCQxricddC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Farhad,

On Thu, 2026-08-27 at 22:36 -0700, Farhad Alemi wrote:
> Hello,
>=20
> As part of the kernel research at ASU's SEFCOM
> lab, we hit the crash below. Crash reports can be found here:
>=20
> =C2=A0
> https://github.com/farhad-alemi/public_bug_reports/tree/main/152-hid-inte=
l-ish-ioport-bar-deref/
>=20
> =C2=A0 BUG: unable to handle page fault for address: 000000000001c078
> =C2=A0 #PF: supervisor read access in kernel mode
> =C2=A0 #PF: error_code(0x0000) - not-present page
> =C2=A0 Oops: Oops: 0000 [#1] SMP KASAN NOPTI
> =C2=A0 RIP: 0010:ish_hw_start+0x41/0x2d0
> =C2=A0 Call Trace:
> =C2=A0=C2=A0 <TASK>
> =C2=A0=C2=A0 ish_probe+0x34d/0x460
> =C2=A0=C2=A0 pci_device_probe+0x436/0xc90
> =C2=A0=C2=A0 really_probe+0x267/0xaf0
> =C2=A0=C2=A0 __driver_probe_device+0x1e2/0x350
> =C2=A0=C2=A0 driver_probe_device+0x4f/0x240
> =C2=A0=C2=A0 __device_attach_driver+0x270/0x410
> =C2=A0=C2=A0 bus_for_each_drv+0x258/0x2f0
> =C2=A0=C2=A0 __device_attach+0x2c5/0x450
> =C2=A0=C2=A0 drivers_probe_store+0x11c/0x220
>=20
> Our reproducer.c is available upon request.
>=20
> Happy to test a patch if that would help.

Thanks for reporting.

Please submit a patch.
https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html

Thanks,
Srinivas

>=20
> Regards,
