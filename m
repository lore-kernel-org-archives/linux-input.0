Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3BB34DB6D;
	Mon, 22 Jun 2026 20:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782161425; cv=none; b=u8bAg9cX5tJQy5QKzlKefLEnmtm5G67eZd59st22+0pPmTCgzSUQq2pIs7FVFS7Ja2ShI57d22U+Btw7aGmAWRfP5rI01qC7U6IkLENb75UZulRV2RHrKBfc8ptLp6Qn+UJrsziLr0qrZiASJjj8vXrVvKKVGJYSrZSmpIFFkDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782161425; c=relaxed/simple;
	bh=4UN0FYYUlyJKlj3muD2DkUJLBcMwl+r7FmRyfnAROpI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S+R1uXiziNyk8pxhdlRMb1BhbTrqguKmK0uQ2vIVkAK/Egjkm1yRLCWFktctLzOLYzeX6rKPhyC4DP7DkHPzXb+bPexYmXtQbBQR80RYWoqjBIjlkcisXTHOZqHBVW8lLDM2+Bs4QNstsfPk8q3HfXV3XzLGV1KPOzZITC0iurg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jXEz11FU; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jXEz11FU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782161424; x=1813697424;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=4UN0FYYUlyJKlj3muD2DkUJLBcMwl+r7FmRyfnAROpI=;
  b=jXEz11FUzEKMFN8/zdIU8ePa34MjYtQn5pxiSvnWCpkR3WXyNk0ts6Vu
   3Cvs4LNsSXoGiWKgm12LPSOn+7+GPMgzYkPlSWrg+iCBhDpFVZlBLcldA
   Reb0XHymTgyWY0Okcy323GeiaX1PTj9AAH6A0avniNpCwBibw7tKoy8SV
   EAsNWhnLxXnDV/bLb5IsU2iJe5xeum1JleuBGOfsioEWWmKpocVfkVt+P
   K6/Z1wiu34mHyA2gvvOMMv3JJNDfPnvgwjZsOKWDPgo8MCmonAMIrbRON
   eoixd0Ch8DEAfTh2TKOqWy3YmZvd9kBtPwq4YXbbcjdatSUgGlcQ1/S4v
   w==;
X-CSE-ConnectionGUID: sCAY4N4AQ968DHjCusAEIQ==
X-CSE-MsgGUID: nv9c7nAzQfyTnve0ghypbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="85452194"
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="85452194"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 13:50:23 -0700
X-CSE-ConnectionGUID: PPxJxrSmStKavq/SUtumdQ==
X-CSE-MsgGUID: u+ixyGcDQlSydsqmXYZM6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="287455780"
Received: from schen9-mobl4.amr.corp.intel.com (HELO [10.125.108.85]) ([10.125.108.85])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 13:50:22 -0700
Message-ID: <0e198f80c6f28e448611e02e1fe20af632931dd3.camel@linux.intel.com>
Subject: Re: [PATCH v1] iio: temperature: hid-sensor-temperature: switch to
 non-devm iio_device_register()
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>, jikos@kernel.org, 
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, 	hongyan.song@intel.com, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Mon, 22 Jun 2026 13:50:22 -0700
In-Reply-To: <CAKqfh0Hk12rA7wkU9wbse=n9qbOgbmxK0vhP6Enj-R2yKCohuQ@mail.gmail.com>
References: <20260622052135.1804135-1-sanjayembedded@gmail.com>
		 <767892206bf6a10de4122f5e1faa8481541170ca.camel@linux.intel.com>
	 <CAKqfh0Hk12rA7wkU9wbse=n9qbOgbmxK0vhP6Enj-R2yKCohuQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-06-22 at 10:27 -0500, Maxwell Doose wrote:
> On Mon, Jun 22, 2026 at 10:26=E2=80=AFAM srinivas pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> >=20
> > On Mon, 2026-06-22 at 10:51 +0530, Sanjay Chitroda wrote:
> > > From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> > >=20
> > > Avoid using devm_iio_device_register(), as this driver requires
> > > explicit
> > > error handling and teardown ordering.
> > >=20
> > > Mixing devm_* APIs with goto-based error unwinding breaks the
> > > expected
> > > LIFO resource release model and can introduce race windows during
> > > device
> > > removal. In particular, the IIO device may remain visible to
> > > userspace
> > > while dependent resources are already being freed, potentially
> > > leading
> > > to use-after-free issues.
> >=20
> > Please explain this use after free case here.
> >=20
> > Thanks,
> > Srinivas
>=20
> My guess is that because the device would still be registered but
> would actually be removed, sysfs still has "wild" pointers to
> read_raw() and write_raw() (which don't exist anymore), causing the
> UAF. If I'm wrong feel free to correct me though.

iio_device_unregister() will be last one to be called after device
removal from devm action handler. This will cleanup attributes. So,
read_raw() or write_raw() can be called. The problem can be handlers
for read_raw() and write_raw() if anything there which are dependent on
clean done by hid_temperature_remove(). Here callbacks are cleaned up,
so nothing to respond to read  sensor_hub_input_attr_get_raw_value(),
so it has to wait for 5 seconds to timeout, which is not great. So
nothing against change done here.

But still not sure any use after free case, unless I am missing
something.

Thanks,
Srinivas


