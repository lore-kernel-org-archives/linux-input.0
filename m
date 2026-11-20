Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795187527;
	b=NTknBJhwmnmbHLQl+7ksjzflcfDx3cW1cIH/dcprvyONBvRjq8EBqT2GFGwigf9bLPBp
	 U0jmKVAwnKLP471k4U/8KS7+4Lj950K2hRjsx3NT6yTjyqkAxG7uEEKgFVN76q4GjuwYC
	 1il5gK5Y+/3928g0NTHaBcNYR0x8wlGc8jBgEWHmSte4AyRrCTs7magZghcniHGm9Wx7O
	 ixEJ5p/2pCzBxbcYUKLwcypsU2GLHLMrWfB3TydGV7SHFWCzwIPta09iqZJz+xpfbgMG3
	 SMCoy/zGZdS4h5s3yA79o4YSD/vSVA/h7JRPRYECK2Mw4Yx9bNH/4ubApf9aJGkfMbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795187527;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=e/a9F5q98Qa6z80IK9g/WSjwbLQnLJABDsAr0iUyvAw=;
	b=VUVqKydAvizaNi/POb8r9KXK6oCxJCdJR4Uw5YN1gVFplIt39UIrJvoGGKooBgzyod92
	 l+RGIjv9aOyGy4EKWkC9jrNpPX8ZBBbETZHzVmCVpjrLu0pT+zoR7AOe0TXv4D115A2Ce
	 Ymvo13fnEsy1hU8bIj9hWIwmkMuXo1CO9FREeefu/FgH8kYkxL68tqBqVLGCwNZi3xJ/M
	 1mTEcvmXiNeF0wAWU8uSp0E2ha5tE+JVXqP22vCqQKJ5VspgdmkvA5gCGZHZF8Z7mhxqp
	 ZXBHARHZZjIMWPuC8PFnYD6okUitIaLudKWXejCAOQAvctMjGUm9tyYKQDUsvHPWPgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YJW7zYtu;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2694606A331;
	Fri, 20 Nov 2026 15:12:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2694606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YJW7zYtu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795187527; x=1826723527;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=4tDq/UJDGdiMKt1hyVpjA1SmRbS+RV6aFhVYsoH/sxo=;
  b=YJW7zYtuehuKWTVD9wJ+PE9idB2r5fdz/UvsiUMU+RIuto9CPxA/KcX+
   Kgf0kx7zkNyIM961dW3Qd1eTJlZsvmsP/iQ5k356V20vS/P443kUCO49U
   9hKmA509YhFX2W5Ywq999MvgYYe2lb3WLvcBAFnDCy5q1TDQKNRCZxKx1
   G4V0ON38patPes2s6SxgS2j+rcafLGQFB7GUspILdaEhtdsod/vG4ThCb
   JUWsvVwkztsHSmFqHXlEOhoJOTtaQ9/6ZYNzgJ0yxcMgsw2mhe4Kci75D
   bpQcNnvTi676XVdMBm/u6x25oIx/5LCR4bO6Guk2B4cg1wBNtlTAqCemp
   g==;
X-CSE-ConnectionGUID: r52Au8osTRyHNX+gS8FWqw==
X-CSE-MsgGUID: 0YQk2lBAQl2dzI3H5i+h+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="3912614"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="3912614"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 07:12:06 -0800
X-CSE-ConnectionGUID: 4ZMpcId7T/C0ndFpfz0dKA==
X-CSE-MsgGUID: T83+wdovRBeUoUI61VUGzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="11072965"
Received: from spandruv-mobl5.amr.corp.intel.com (HELO [10.124.220.9]) ([10.124.220.9])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 07:12:05 -0800
Message-ID: <573f3eb75601c17d6e766fc47a7cce1bc2274998.camel@linux.intel.com>
Subject: Re: [PATCH v2] HID: sensor-hub: Avoid holding spinlock across child
 iteration
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Zheng Shuhao <viennaoffh@gmail.com>, linux-input@vger.kernel.org, Zhang
 Lixu <lixu.zhang@intel.com>
Cc: jikos@kernel.org, jic23@kernel.org, bentiss@kernel.org, heiko@sntech.de,
 	lee@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ayaanmirzabaig85@gmail.com, 
	syzbot+fb951970a334aaff00ba@syzkaller.appspotmail.com
Date: Fri, 20 Nov 2026 07:12:03 -0800
In-Reply-To: <20261120135005.566-1-viennaoffh@gmail.com>
References: <1795161418.hid-sensor-hub@viennaoffh.gmail.com>
	 <20261120135005.566-1-viennaoffh@gmail.com>
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

+Lixu

On Fri, 2026-11-20 at 21:50 +0800, Zheng Shuhao wrote:
> sensor_hub_remove() holds sensor_data->lock while walking the HID
> device's
> children with device_for_each_child(). The child iteration takes the
> device
> core's klist lock, while sensor_hub_raw_event() takes
> sensor_data->lock with interrupts disabled. This creates a lock-order
> inversion.
>=20
> Pass sensor_data to the callback and take the lock only while
> examining
> pending.status and completing pending.ready.
>=20
> The callback also visits non-Sensor Hub children. When HID battery
> strength
> support is enabled, the HID input layer may register a power-supply
> child
> without platform_data. Skip children without Sensor Hub data before
> dereferencing it.
>=20
> Testing:
> - With CONFIG_HID_BATTERY_STRENGTH=3Dy, ran a UHID Sensor Hub/Joystick
> device
> =C2=A0 exposing Battery Strength through 15 create/destroy cycles across
> three
> =C2=A0 QEMU boots. The power-supply child was found each time; no Oops,
> BUG, or
> =C2=A0 KASAN report occurred.
> - In the same configuration, hid_bpf passed 45 tests with 1 skip,
> hidraw
> =C2=A0 passed 27 tests, and hid-core, hid-apple, hid-gamepad, hid-ite,
> =C2=A0 hid-keyboard, and hid-mouse passed.
> - The full HID suite was not completed; it stopped during hid-
> multitouch.
> - The #syz test request was rejected because syzbot's automated patch
> =C2=A0 testing is temporarily unavailable.

None of the above tested devices are HID SENSOR HUB related, so need
some tests.
Hi Lixu,

Please give a try.

Thanks,
Srinivas

>=20
> Fixes: 8a5b38c3fd70 ("HID: hid-sensor-hub: don't use stale platform-
> data on remove")
> Reported-by: syzbot+fb951970a334aaff00ba@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dfb951970a334aaff00ba
> Signed-off-by: Zheng Shuhao <viennaoffh@gmail.com>
> ---
> Changes in v2:
> - Pass sensor_data to the callback instead of NULL.
> - Skip children without Sensor Hub platform_data; add a battery-child
> test.
> - Add Fixes and correct the syzbot address; remove the self-added
> Tested-by.
>=20
> =C2=A0drivers/hid/hid-sensor-hub.c | 12 ++++++++----
> =C2=A01 file changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-
> hub.c
> index 6470a290ebfc5..4c447f62480b5 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -804,9 +804,16 @@ static int sensor_hub_probe(struct hid_device
> *hdev,
> =C2=A0static int sensor_hub_finalize_pending_fn(struct device *dev, void
> *data)
> =C2=A0{
> =C2=A0	struct hid_sensor_hub_device *hsdev =3D dev->platform_data;
> +	struct sensor_hub_data *sensor_data =3D data;
> +	unsigned long flags;
> +
> +	if (!hsdev)
> +		return 0;
> =C2=A0
> +	spin_lock_irqsave(&sensor_data->lock, flags);
> =C2=A0	if (hsdev->pending.status)
> =C2=A0		complete(&hsdev->pending.ready);
> +	spin_unlock_irqrestore(&sensor_data->lock, flags);
> =C2=A0
> =C2=A0	return 0;
> =C2=A0}
> @@ -814,16 +821,13 @@ static int
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
