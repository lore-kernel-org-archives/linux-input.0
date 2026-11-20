Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795176860;
	b=1nR5w23GuAihtmzKUwvk/ghhAPqRFQcrtqq2dXJdBcboFbEsZjRgEZWrAWwOP6evdTCC
	 poVh6tasD/UdTuS7IE3mf6AZXYC315Ay2HxQIQVbP9QgU07kWmH5ct33AgIOh76fR2kbf
	 +eHNA1oaRqUKC23lYAGFnM5j+8I0x3v8UZ1ipM3SI/ouXZ4khbFiSBwXRPjkMnEAdveAj
	 oEwfkI/3eKO8L/Y+mq5gRY7RtIiSrkBtkgCRmpXUFv1894NXG14yg2lsscJLtieeSEmxG
	 0ejlWFNF+MwROwIXHcRDa2oo1xwseRS36Oq8SIRH8Wo+6MOZRc5eruU5FqfHe2ufYdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795176860;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=spTeAx3QuEVFl0rUtsHN0Rg07Rtz4Dth2hzZ9qugW84=;
	b=D7cI5dm40dQyTKDzYcgcZdhRtHFZ53/eDS3rV6eyvZggAfzkYJKmlNtYFJf8lwQuky1d
	 BGJd/K5Oag5rghdF3FESSN10oCVFRVGxkfhDwzouAxdG7bT7rpa/r3REHgIr/+9xutPq8
	 NYsKsRDmkWRvdqwU6ZUX5U57W8g40DYPtEH2L/D1gCfN0/WYcvDF5WuJGv9gcv+uuv/Uu
	 ejf2XZq2k1fCnoK4V87eUyau7JXqPdHgpIMHRFU2+/AeVHnE4kg66nHcM/GPOuuW1byBE
	 U/6vVGJBCFpjta4Vm6QK6gWzNq4tCw4zAQgdNw9ilpfn0IgVzi9IO6h6ZgAoE2PTcpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TL+AC1cN;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA2A606A32C;
	Fri, 20 Nov 2026 12:14:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEA2A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TL+AC1cN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795176859; x=1826712859;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=WmnVUxj76RFc+DkngRN7+viDvVURtuN2uJbvDkFMWe4=;
  b=TL+AC1cNtLesIlyPUIRhXJtgW256pPE/Xg1MBHNXX/c30nhIiYMqRxdG
   x+Ccli5AGcCscLJEPlOLUCFTD3BgsJviCQtQfBhkQJul6XygGySZp9MDL
   9suVGtA0Uw29pas3S9KXqlPX5IXq6TluIg7nvshx7O3lzKI99qKhNNwR2
   LpVk8yxaDbfIZ38IpJ5oynJ1lLWL7SZOza/XSRd0m3/mbT9TSBPBZChVL
   KfOtgbLXuvvXaPLPn5tXjgtuwnJdI3VTQiXyIJE8XJOQLdUMD5Cp/AidB
   VVt8ENYN+2ATEn/cN0QH5ewW4oSsrwPH66c5NKhEEZKTwfhR5O5m4rxfR
   A==;
X-CSE-ConnectionGUID: /jnGWz31QKeqrrCNfWO2fQ==
X-CSE-MsgGUID: LMshFvSTSAWADnARZPmgRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="4095487"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="4095487"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 04:14:18 -0800
X-CSE-ConnectionGUID: J6vxtUC/QuyFBg7NFJSKXg==
X-CSE-MsgGUID: y7dNkHLoTQmjjnktM9s2cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="10948041"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO [10.124.220.9]) ([10.124.220.9])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 04:14:17 -0800
Message-ID: <04f2db47461eca6911038bbdb3d8e036dd92776f.camel@linux.intel.com>
Subject: Re: [PATCH] HID: sensor-hub: Avoid holding spinlock across child
 iteration
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Zheng Shuhao <viennaoffh@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
	ayaanmirzabaig85@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>, Benjamin Tissoires
 <bentiss@kernel.org>, 	linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, 	linux-kernel@vger.kernel.org, 
	syzbot+c7c429f6851638ece81338f90c5b29ac9c0dea1f@syzkaller.appspotmail.com
Date: Fri, 20 Nov 2026 04:14:16 -0800
In-Reply-To: <1795161418.hid-sensor-hub@viennaoffh.gmail.com>
References: <1795161418.hid-sensor-hub@viennaoffh.gmail.com>
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

On Fri, 2026-11-20 at 15:56 +0800, Zheng Shuhao wrote:
> syzbot reports a SOFTIRQ-safe -> SOFTIRQ-unsafe lock order warning
> during
> sensor hub removal.
>=20
> sensor_hub_remove() currently holds sensor_data->lock while calling
> device_for_each_child(). The child iteration enters the device core
> and may
> acquire the klist lock. Since sensor_data->lock is also acquired with
> interrupts disabled by sensor_hub_raw_event(), lockdep reports a
> possible
> lock-order inversion.
>=20
> The callback only needs sensor_data->lock while checking
> pending.status and
> completing pending.ready. Pass sensor_data to the callback and take
> the lock
> only around that short critical section instead of holding it across
> device_for_each_child().
>=20
> This preserves synchronization of pending.status while avoiding the
> lock-order
> dependency between sensor_data->lock and the device core's klist
> lock.
>=20
> The syzbot report is available at:
> https://syzkaller.appspot.com/bug?id=3Dc7c429f6851638ece81338f90c5b29ac9c=
0dea1f
>=20

Ayaan posted a similar patch yesterday.

Thanks,
Srinivas


> Testing:
> - Reproduced the target lockdep warning with the unmodified kernel in
> 3/3
> =C2=A0 two-CPU QEMU runs.
> - The warning was absent with this patch in 3/3 equivalent runs.
> - Ran the HID selftests against both baseline and patched kernels:
> =C2=A0 hid_bpf: 45 passed, 1 skipped, 0 failed
> =C2=A0 hidraw: 27 passed, 0 failed
> =C2=A0 hid-core, hid-apple, hid-gamepad, hid-ite, hid-keyboard, hid-mouse=
,
> =C2=A0 hid-multitouch, hid-sony, and hid-tablet all passed in both runs.
> - hid-usb_crash.sh and hid-wacom.sh produced TAP 1..0 / rc=3D2 in both
> =C2=A0 kernels because no executable test cases were collected in this
> minimal
> =C2=A0 QEMU environment.
> - No KASAN report, use-after-free, Oops, BUG, panic, or general
> protection
> =C2=A0 fault was observed.
> - checkpatch.pl --strict --no-signoff reports 0 errors and 0
> warnings.
>=20
> Reported-by:
> syzbot+c7c429f6851638ece81338f90c5b29ac9c0dea1f@syzkaller.appspotmail.com
> Closes:
> https://syzkaller.appspot.com/bug?id=3Dc7c429f6851638ece81338f90c5b29ac9c=
0dea1f
> Signed-off-by: Zheng Shuhao <viennaoffh@gmail.com>
> Tested-by: Zheng Shuhao <viennaoffh@gmail.com>
> ---
> =C2=A0drivers/hid/hid-sensor-hub.c | 9 +++++----
> =C2=A01 file changed, 5 insertions(+), 4 deletions(-)
> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-
> hub.c
> index 6470a290ebfc5..62799c26e6ec3 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -804,9 +804,13 @@ static int sensor_hub_probe(struct hid_device
> *hdev,
> =C2=A0static int sensor_hub_finalize_pending_fn(struct device *dev, void
> *data)
> =C2=A0{
> =C2=A0	struct hid_sensor_hub_device *hsdev =3D dev->platform_data;
> +	struct sensor_hub_data *sensor_data =3D data;
> +	unsigned long flags;
> =C2=A0
> +	spin_lock_irqsave(&sensor_data->lock, flags);
> =C2=A0	if (hsdev->pending.status)
> =C2=A0		complete(&hsdev->pending.ready);
> +	spin_unlock_irqrestore(&sensor_data->lock, flags);
> =C2=A0
> =C2=A0	return 0;
> =C2=A0}
> @@ -814,16 +818,13 @@ static int
> sensor_hub_finalize_pending_fn(struct device *dev, void *data)
> =C2=A0static void sensor_hub_remove(struct hid_device *hdev)
> =C2=A0{
> =C2=A0	struct sensor_hub_data *data =3D hid_get_drvdata(hdev);
> -	unsigned long flags;
> =C2=A0
> =C2=A0	hid_dbg(hdev, " hardware removed\n");
> =C2=A0	hid_hw_close(hdev);
> =C2=A0	hid_hw_stop(hdev);
> =C2=A0
> -	spin_lock_irqsave(&data->lock, flags);
> -	device_for_each_child(&hdev->dev, NULL,
> +	device_for_each_child(&hdev->dev, data,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sensor_hub_finalize_pending_fn);
> -	spin_unlock_irqrestore(&data->lock, flags);
> =C2=A0
> =C2=A0	mfd_remove_devices(&hdev->dev);
> =C2=A0	mutex_destroy(&data->mutex);
