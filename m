Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4813B27D7;
	Thu, 16 Jul 2026 14:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784212831; cv=none; b=btM0aKI/ogJ2dFb1x4eucRHlSw0sGZoUwlRADpsufPyGRxgaXDJW5icvEa8YkMaOsCAqiquAa+mmaY4p6SfKaq3/l3rRX+Jgzh4Q6yW1vCVojRnKD/suj2ufQD1YTKhXfncud9//lSmW3OeM4HF58TINmG7aWMS0La4zQTEfDuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784212831; c=relaxed/simple;
	bh=mw95JkaGyUbYTllBtNQBKf7/9nrFEE72vUNdlnGvGUg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JN5E7RBMMXsudPjfSv+9YsrYwOVSAo5cJrUyMaBy8M+leDb7qPXpeWycsEi5z4JwpqWEFBXr23ySY2RE8nvekQCxH6hlTid0CS5nZY6xJgGgRx2ibzbhFfnXlGqaT3ovUgKp8iBAdUKp1Fbd0zNPjcXWl8ajLa2RX7uwXG30jaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WauP/0A9; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WauP/0A9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784212829; x=1815748829;
  h=message-id:subject:from:to:date:in-reply-to:references:
   content-transfer-encoding:mime-version;
  bh=mw95JkaGyUbYTllBtNQBKf7/9nrFEE72vUNdlnGvGUg=;
  b=WauP/0A9j/VBUzncBiSNAwHMIpX3fskbGXA8OfUkH03nQD2Rj7rxsJIz
   zmmJLSIkPnpjlfgJLuZE46HtpxZUj8xMQTLfFTYMQFVubSg8a1OT59atz
   /376T/IotVCnTfF+QoS9efkeW2g8fnHD/WdNts7QOOZ6G9ospO1MQmqBq
   4U4L3K510AtpHxVAUrgG65jhFLmbRlafN5pNsb/iDedDmbo+HVp5UgkkX
   qSXKsLKngTJt+E87OlPtA79DdprJxD5zlPqZmrjgIbb8km4fNo8vTEO/o
   VQuQmZP6oSdkakDL9ZmKlJiCh4RM1AjEgn7DIDfng2MCdXUFQUC0u3kdg
   g==;
X-CSE-ConnectionGUID: 1Qe0o5AdTwKXzkpiEvhHLA==
X-CSE-MsgGUID: FjtlxB9iQTS3+ZP6i1pm+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84754410"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="84754410"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 07:40:28 -0700
X-CSE-ConnectionGUID: pQ3OXG8CRxKsGVZISLru0Q==
X-CSE-MsgGUID: KFRe8Z4+TUeG5/nw5ypWuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="252535263"
Received: from spandruv-desk2.jf.intel.com ([10.88.27.176])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 07:40:28 -0700
Message-ID: <5b9914e89920e8b047cb16ecf552b2ea005aa26d.camel@linux.intel.com>
Subject: Re: [PATCH v2 3/4] HID: intel-ish-hid: ipc: Remove redundant
 dev_err()
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Pan Chuang <panchuang@vivo.com>, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires
	 <bentiss@kernel.org>, Zhang Lixu <lixu.zhang@intel.com>, Andy Shevchenko
	 <andriy.shevchenko@intel.com>, Vineeth Pillai <vineeth@bitbyteword.org>, 
 "open list:INTEL INTEGRATED SENSOR HUB DRIVER"
	 <linux-input@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Date: Thu, 16 Jul 2026 07:40:27 -0700
In-Reply-To: <20260716075203.593012-4-panchuang@vivo.com>
References: <20260716075203.593012-1-panchuang@vivo.com>
	 <20260716075203.593012-4-panchuang@vivo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-07-16 at 15:51 +0800, Pan Chuang wrote:
> Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()"), devm_request_irq() automatically logs
> detailed error messages on failure. Remove the now-redundant
> driver-specific dev_err() calls.
>=20
> Signed-off-by: Pan Chuang <panchuang@vivo.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

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
