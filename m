Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795443676;
	b=mzrahvuRu8QEokEx20q+rcG9rLirTBrdDqMX+HD+XHUywJtDUAMtFs6aBG1QbFNOST1j
	 SHmo4+ZbBQ0HRT/1N3HqBf33upcqygES4qd6TUxS4+BX7TZ39vNed3d3+yRI1it8Eyato
	 PhltYtqJ7EFtgc+l+J7RHpVeZCgbSG/8MJs0LBK3XFnGkGr6C1/YkrAKwvBPCPDWcWoTI
	 2reh6H6xk8BsLuK2fxWzyQImtZq7qHGB+UvQXXNciazr33vt+nZWDTGCMJoZvpYeEmTns
	 boHBRHtpJm+SDdhBT2Tlqr6deuXDXnYjhpA5Svv4ykK2PguFTzhvSUeXjTYopxauWLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795443676;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=yiAShk857UHrziL4yG9wJZEirsFk53j6ZB0m2dkAIaE=;
	b=bzQdWbO9ddC9Awh8gYm6X83ZhqUmhIChpK3cHWJnzRVuTdAeTgeSU2Gu6ot0AYzUvUpY
	 9Uufkujq5NZQOyqmnAtffdMvSiZ2FtOoJ6xej7bP6X1dJFgNvaKJN2Du8KVvJDCkJDT3L
	 nV4SNwB35/xqYtII/MoC7TBS68bwSx4I8Fw0pUkmse3EKgXyCoo7E84vi3xhgtLx4UTkj
	 xX0lR/f6THDwc7d/JQM5lRKYtUZ4MFeBqeDmmgdj1qg+376uu3eWLiZBi9uMHgkVA0Yar
	 iqUXacInoisQ67H7iT4S1VM15MWWIeu0R8fBZNvqJ30gXNadPgpUjpX4lRN4c+22upA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="EsM9K/rh";
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC96606A31A;
	Mon, 23 Nov 2026 14:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CC96606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EsM9K/rh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795443676; x=1826979676;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=uOnAdYGAKwtdFMh1IEJyXNKhjlMEOwk9h1WPy3NE2PA=;
  b=EsM9K/rhOpLCyIOdoG5beSZ+CmT7701XAm+jXZILIG6rkqfIE5iBojMJ
   Lc7C6Jh+QCMKQtEdhuzfSKoA3NU1xCmFZ9AhpwCeUhISxvSQVoSCVICIy
   esfyKB2po69V8k91B5Vis83nFkxCY4P9eWSGuwW56qavsp5sEO3jb4FlQ
   Jrh57WtnjRIQeW0kYY9XNAU3iq4qWPYKuCmUH6l4Ye5f5JauHGqn/Y1SU
   cSClSAmIhONyo+MkdhOGk0fA3+3QEOQ9GlRiaZ5F9+BcTr0KS6W9KwQve
   73BleaDmfQMJKMLf/hwonwWmaCLmpRPlaoXl2RswaRSwRIM5qkR5wnmej
   A==;
X-CSE-ConnectionGUID: wKKOYWvRRP+K2PZbjcEePw==
X-CSE-MsgGUID: 2zeC8cg3QjKLn/rgwmjD0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4358102"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4358102"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 06:21:15 -0800
X-CSE-ConnectionGUID: lh7kW8LBT06SblzEz/2FEQ==
X-CSE-MsgGUID: fbT19V47RsSZhj8amLOedQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="13010864"
Received: from spandruv-mobl5.amr.corp.intel.com (HELO [10.124.220.112]) ([10.124.220.112])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 06:21:13 -0800
Message-ID: <3d83eafc370354cef4280fd70d1228191486a212.camel@linux.intel.com>
Subject: Re: [PATCH v3] HID: hid-sensor-hub: avoid lock inversion in
 sensor_hub_remove()
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>, Jiri Kosina	
 <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, Jonathan
 Cameron	 <jic23@kernel.org>
Cc: Zhang Lixu <lixu.zhang@intel.com>, Zheng Shuhao <viennaoffh@gmail.com>, 
 Arnav Kapoor <kapoorarnav43@gmail.com>, Lee Jones <lee@kernel.org>, Heiko
 Stuebner <heiko@sntech.de>, 	linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, 	linux-kernel@vger.kernel.org, 
	syzbot+fb951970a334aaff00ba@syzkaller.appspotmail.com
Date: Mon, 23 Nov 2026 06:21:12 -0800
In-Reply-To: <20261123124715.351511-1-ayaanmirzabaig85@gmail.com>
References: <20261123124715.351511-1-ayaanmirzabaig85@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, 2026-11-23 at 18:17 +0530, Ayaan Mirza Baig wrote:
> In sensor_hub_remove(), spin_lock_irqsave(&data->lock, flags) is held
> while calling device_for_each_child(), which iterates child devices
> via
> klist_next() and acquires the driver core's &k->k_lock.
>=20
> Because &data->lock is acquired in softirq context by
> sensor_hub_raw_event() while &k->k_lock is acquired elsewhere with
> softirqs enabled, nesting &k->k_lock under &data->lock triggers a
> SOFTIRQ-safe -> SOFTIRQ-unsafe lockdep warning and risks an ABBA
> deadlock between process context and softirq context.
>=20
> Move spin_lock_irqsave()/spin_unlock_irqrestore() into
> sensor_hub_finalize_pending_fn() and pass data through
> device_for_each_child(), so &data->lock is only held while inspecting
> and completing each child's pending state after klist_next() releases
> &k->k_lock.
>=20
> Fixes: 8a5b38c3fd70 ("HID: hid-sensor-hub: don't use stale platform-
> data on remove")
> Reported-by: syzbot+fb951970a334aaff00ba@syzkaller.appspotmail.com
> Closes:
> https://lore.kernel.org/all/6afddf21.a11fe2ad.1b4426.0003.GAE@google.com/=
T/
> Suggested-by: Zheng Shuhao <viennaoffh@gmail.com>
> Signed-off-by: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
> ---
> Changes in v3:
> =C2=A0- Actually pass 'data' instead of NULL to device_for_each_child()
> =C2=A0=C2=A0 (missed in the v2 submission).

Are you sending correct patch?

=20
-	spin_lock_irqsave(&data->lock, flags);
 	device_for_each_child(&hdev->dev, NULL,
 			      sensor_hub_finalize_pending_fn);
-	spin_unlock_irqrestore(&data->lock, flags);
=20


Thanks,
Srinivas

> =C2=A0- Drop the NULL platform_data guard since hid/for-next already
> checks
> =C2=A0=C2=A0 dev_is_platform() and !hsdev.
>=20
> Changes in v2:
> =C2=A0- Attempted to pass 'data' instead of NULL to
> device_for_each_child().
>=20
> =C2=A0drivers/hid/hid-sensor-hub.c | 7 ++++---
> =C2=A01 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-
> hub.c
> index e9d6eb3b3831..090e5a232efa 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -808,6 +808,8 @@ static int sensor_hub_probe(struct hid_device
> *hdev,
> =C2=A0static int sensor_hub_finalize_pending_fn(struct device *dev, void
> *data)
> =C2=A0{
> =C2=A0	struct hid_sensor_hub_device *hsdev;
> +	struct sensor_hub_data *sd =3D data;
> +	unsigned long flags;
> =C2=A0
> =C2=A0	if (!dev_is_platform(dev))
> =C2=A0		return 0;
> @@ -816,8 +818,10 @@ static int sensor_hub_finalize_pending_fn(struct
> device *dev, void *data)
> =C2=A0	if (!hsdev)
> =C2=A0		return 0;
> =C2=A0
> +	spin_lock_irqsave(&sd->lock, flags);
> =C2=A0	if (hsdev->pending.status)
> =C2=A0		complete(&hsdev->pending.ready);
> +	spin_unlock_irqrestore(&sd->lock, flags);
> =C2=A0
> =C2=A0	return 0;
> =C2=A0}
> @@ -825,14 +829,11 @@ static int
> sensor_hub_finalize_pending_fn(struct device *dev, void *data)
> =C2=A0static void sensor_hub_remove(struct hid_device *hdev)
> =C2=A0{
> =C2=A0	struct sensor_hub_data *data =3D hid_get_drvdata(hdev);
> -	unsigned long flags;
> =C2=A0
> =C2=A0	hid_dbg(hdev, " hardware removed\n");
> =C2=A0
> -	spin_lock_irqsave(&data->lock, flags);
> =C2=A0	device_for_each_child(&hdev->dev, NULL,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sensor_hub_finalize_pending_fn);
> -	spin_unlock_irqrestore(&data->lock, flags);
> =C2=A0
> =C2=A0	mfd_remove_devices(&hdev->dev);
> =C2=A0	/* Clients share one HID open; release it if references
> remain. */
