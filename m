Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C163CF678;
	Mon, 13 Jul 2026 15:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783956471; cv=none; b=ohPJrF3TxV88B/g1ueExcRsGWqeUUGGxTwoW77YshiEENgHFI3ltAlf9YwXG+tYoF1M/cEFutacDs5qbjPfwX6gZ0NAcqHjx9tLEId2XSCdPtnJ7ponVzJ+MEG2BjAS9Fqdmql2rtQxeUJj5A7eGx/dnPgEBoHj7fSZnXCdATHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783956471; c=relaxed/simple;
	bh=qKbOgPp91Tg/6U0UtfGI0wfLJS14YDNiyFhJrkiuxPc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hVIcB6QV9m05i0tTKb2+PRcu7+QO3Yx8fZ1GNBLulsUvPmG/x7yLRNv1wSMwJbLJhv9D9GTRIn5jFipDKQkxBnG78xlyLgSZtleaBma3k4NbKgE9q1qWsgsk75zMiMR5TKsZvqeANX/wxuJvUrrdBLCayGcePcCLef0BUSDGVuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bzVGi64O; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bzVGi64O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783956469; x=1815492469;
  h=message-id:subject:from:to:date:in-reply-to:references:
   content-transfer-encoding:mime-version;
  bh=qKbOgPp91Tg/6U0UtfGI0wfLJS14YDNiyFhJrkiuxPc=;
  b=bzVGi64O7vNiSjnqfUuuySq7EaebIJUiGmopxAczttdsPls8y6eCgzPA
   S92MxiiwjOEG8mav2fFJ3hEDgRTNGUi8B5i2AlHZbfL9+cs/TkFX8Js6s
   etIsKessmzsG0w5zKZn8bN5fObcZfQeglsKNDJJ5dbkNSiEvrn+u7ZOwd
   8mOJNBsmi9jvZS05sF+QHHr+dGUdiesUsegv52cs8FIPQmcU8LYYwzu7j
   TkNIejN71pPzazUoQvm5sqwyRiXiJOD0n4z+X0p6gBGRmYBBJga85+eOR
   88Y7p/WODjBVD7TNXSB9OAOdtl3Y3LOjN1MwBZpwrtEXlrM/gUAqEY8Rh
   Q==;
X-CSE-ConnectionGUID: xWAbtrgrSveybiNWFF7UFg==
X-CSE-MsgGUID: NOjIrJEZQ3KxTrSgPjIVBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="83685122"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="83685122"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 08:27:48 -0700
X-CSE-ConnectionGUID: W7FykZLnSduPGjdWSMH7yw==
X-CSE-MsgGUID: +3JkVlt/SzKMrdtF4dc9EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="253850208"
Received: from spandruv-desk2.jf.intel.com ([10.88.27.176])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 08:27:48 -0700
Message-ID: <110c68edbd94d2c14f5231d6a7cb596474cf6696.camel@linux.intel.com>
Subject: Re: [PATCH 3/4] HID: intel-ish-hid: ipc: Remove redundant dev_err()
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Pan Chuang <panchuang@vivo.com>, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires
	 <bentiss@kernel.org>, Zhang Lixu <lixu.zhang@intel.com>, Andy Shevchenko
	 <andriy.shevchenko@intel.com>, Vineeth Pillai <vineeth@bitbyteword.org>, 
 "open list:INTEL INTEGRATED SENSOR HUB DRIVER"
	 <linux-input@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Date: Mon, 13 Jul 2026 08:27:47 -0700
In-Reply-To: <20260713132439.380121-4-panchuang@vivo.com>
References: <20260713132439.380121-1-panchuang@vivo.com>
	 <20260713132439.380121-4-panchuang@vivo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-07-13 at 21:24 +0800, Pan Chuang wrote:
> Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()"), devm_request_irq() automatically logs
> detailed error messages on failure. Remove the now-redundant
> driver-specific dev_err() calls.
>=20
> Signed-off-by: Pan Chuang <panchuang@vivo.com>

Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> =C2=A0drivers/hid/intel-ish-hid/ipc/pci-ish.c | 4 +---
> =C2=A01 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> index 8d36ae96a3ee..e7196e429c8b 100644
> --- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> +++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> @@ -232,10 +232,8 @@ static int ish_probe(struct pci_dev *pdev, const
> struct pci_device_id *ent)
> =C2=A0
> =C2=A0	ret =3D devm_request_irq(dev, pdev->irq, ish_irq_handler,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 irq_flag, KBUILD_MODNAME, i=
shtp);
> -	if (ret) {
> -		dev_err(dev, "ISH: request IRQ %d failed\n", pdev-
> >irq);
> +	if (ret)
> =C2=A0		return ret;
> -	}
> =C2=A0
> =C2=A0	dev_set_drvdata(ishtp->devc, ishtp);
> =C2=A0
