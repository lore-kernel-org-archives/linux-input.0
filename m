Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B746A1F8AC5;
	Sat, 31 Jan 2026 01:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769823144; cv=none; b=c27YWpripBp3kPbxzbEHLYr9IJdR2AfEAr8rdcSO4Tmz50ZktX9NuRaZWvyX04zkwvp/IiTzN5HVCH0JH0d1tyGHFADk2LScSpYbSqtzEmCIuzPIJF8ck65NeE0fQQqeb6sP526XWTVOdjpUBOyqp2iP9PCzoiK2P9mz3RmbzAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769823144; c=relaxed/simple;
	bh=bimcp6MApRiJBt1uTQePrYV3Gu4PGQjRWTMHsOHoKR8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NxcUXkpyuN842Xyd04GqSGXZYjy0vXajpR4qLR8ps4QPanNbYaCHhb8Pcpj6pZgLTDsSptHd1kHTJaioUsT5U89DuRUk8mfngOdpn2tpdkGNCukrpbs9bSN1pECrLC2d1chN1HTNk7Nr86OOVohFWy+kahEtWbplXCIZFIidX4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ty4vyUOf; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ty4vyUOf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769823143; x=1801359143;
  h=message-id:subject:from:to:date:in-reply-to:references:
   content-transfer-encoding:mime-version;
  bh=bimcp6MApRiJBt1uTQePrYV3Gu4PGQjRWTMHsOHoKR8=;
  b=Ty4vyUOfh2uL50lm4LFzthBFEXVDAwbeu5IU56occeVXOcCBGEFkYt9f
   lz8/ZJKfLJ26oOAo8Tn+s8P5LOdjJR8x9qt1ifdpaGmuAHRu0iIHS+pT6
   Sv7gOTMComNwcmgDhsfCtvOvlLvJNam5ETzegNu4SRs+wVVnidsqAUmrX
   HjPfNMROCMrfkHp3a68U6mt2t2ykKu/yNhbta0LxwGA3os5aBHclUJ6Eo
   ufAyFzq6NqbvtX4iBfEEEgtKOWCamFY9PaPQcnhZ0W7wBVu6yxAg/ND3A
   q8+LU4BgIPwvsTogRkEWjeQhWRbZMcWIVdKip8mhYYX0gjGewGZctziCY
   Q==;
X-CSE-ConnectionGUID: 4lOoP1kqRMm27P4wqczULg==
X-CSE-MsgGUID: zoMKkuv5QaueSRYEQaqdJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11687"; a="88652168"
X-IronPort-AV: E=Sophos;i="6.21,264,1763452800"; 
   d="scan'208";a="88652168"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 17:32:22 -0800
X-CSE-ConnectionGUID: sraEmNO7SWK4SDbASLrnSA==
X-CSE-MsgGUID: YRh9Ie2cSmaUnwW51Jn0mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,264,1763452800"; 
   d="scan'208";a="208908066"
Received: from spandruv-desk1.amr.corp.intel.com ([10.247.118.122])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 17:32:17 -0800
Message-ID: <381d44f303b9dd51e0d5063a805868eb601145f2.camel@linux.intel.com>
Subject: Re: [linux-drivers-review] [PATCH] HID: intel-ish-hid: fix
 NULL-ptr-deref in ishtp_bus_remove_all_clients
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Ryan Lin <ryan.lin@intel.com>, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-drivers-review@eclists.intel.com, 
	lixu.zhang@intel.com, Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina
	 <jikos@kernel.org>
Date: Fri, 30 Jan 2026 17:32:04 -0800
In-Reply-To: <20260130052544.4784-1-ryan.lin@intel.com>
References: <20260130052544.4784-1-ryan.lin@intel.com>
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

On Fri, 2026-01-30 at 13:25 +0800, Ryan Lin wrote:
> During a warm reset flow, the cl->device pointer may be NULL if the
> reset occurs while clients are still being enumerated. Accessing
> cl->device->reference_count without a NULL check leads to a kernel
> panic.
>=20
> This issue was identified during multi-unit warm reboot stress
> clycles.
> Add a defensive NULL check for cl->device to ensure stability under
> such intensive testing conditions.
>=20
> KASAN: null-ptr-deref in range [0000000000000000-0000000000000007]
> Workqueue: ish_fw_update_wq fw_reset_work_fn
>=20
> Call Trace:
> =C2=A0ishtp_bus_remove_all_clients+0xbe/0x130 [intel_ishtp]
> =C2=A0ishtp_reset_handler+0x85/0x1a0 [intel_ishtp]
> =C2=A0fw_reset_work_fn+0x8a/0xc0 [intel_ish_ipc]
>=20
> Fixes: 3703f53b99e4a ("HID: intel_ish-hid: ISH Transport layer")
> Signed-off-by: Ryan Lin <ryan.lin@intel.com>

You need to use get_maintainer.pl to get all TO and CC list.

You missed=20
Jiri Kosina <jikos@kernel.org>
Benjamin Tissoires <bentiss@kernel.org>


> ---
> =C2=A0drivers/hid/intel-ish-hid/ishtp/bus.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/hid/intel-ish-hid/ishtp/bus.c
> b/drivers/hid/intel-ish-hid/ishtp/bus.c
> index c3915f3a060e..b890fbf97a75 100644
> --- a/drivers/hid/intel-ish-hid/ishtp/bus.c
> +++ b/drivers/hid/intel-ish-hid/ishtp/bus.c
> @@ -730,7 +730,7 @@ void ishtp_bus_remove_all_clients(struct
> ishtp_device *ishtp_dev,
> =C2=A0	spin_lock_irqsave(&ishtp_dev->cl_list_lock, flags);
> =C2=A0	list_for_each_entry(cl, &ishtp_dev->cl_list, link) {
> =C2=A0		cl->state =3D ISHTP_CL_DISCONNECTED;
> -		if (warm_reset && cl->device->reference_count)
> +		if (warm_reset && cl->device && cl->device-
> >reference_count)
> =C2=A0			continue;
> =C2=A0
> =C2=A0		/*
