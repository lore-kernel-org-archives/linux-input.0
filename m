Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795188650;
	b=Ixj3IV6Eknwr0oD1skD00XUEBguViwjsx1nJ+7R/Oz/ZcicNuQxPY5DiTumXKR2KpZwL
	 rHvJvDG9ZkN/uZFn1IJIMUrTRCoBilaJrJsM9h0sOXuR27KwT4JbOqEkta/P3qT7RQR76
	 Sg1K/dqrL7Dnh75kRprjtJdaqrI4zg7jQgu6KWsDC1NFkVD3i5tyLvdAS/s1pjy+NNem6
	 zu27o3X1pfFcZ2d39vrvRhsPIkQT1XB9GuX1xHaxcO6zJAtv+7UPxIidri5AWAQSmCm8e
	 HSn0Ys458xOdiK+XX8mKw78C1OFqNF3z9DvTswb0IH5hiYxs7UrxZqXC2LKFMFor8qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795188650;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=9VHUTJFromlNupJTN9EogGGtF4tFwW8uTiqdpeHhdZg=;
	b=tvnkizBan2O5q541+fAmY8xpPQZaI11DxTzhVoVsGfDeBIAd4y31IXdrx+0pJZlzuBPd
	 Cf+Yujc/XWyLgn1JnMoiDbIeaI45TdrFw+R+XGYn8Uie8eHDl4JHH/eIuzLRyNNW2klwz
	 sqViThYBhPzPvGfxsxgXaqjBGirYIZ1Ue1a0FtneLQW/NYXqszJBoQlCnlfTeOcTwdCfj
	 tQMmWEJGPGdlLAzX+/dHu9UuhiCT9SY1hFMJzHMPteiLmG7mqTYoVHY5oyQDFLM27umEj
	 GSPVn2MWa5oqdZLG/aklgHJcjOwj6MAtm3SorTncBuEjOSZQNAlQHekUzoX6TPfCqHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="J4ZXvZ/M";
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78240606A32A;
	Fri, 20 Nov 2026 15:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78240606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=J4ZXvZ/M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795188649; x=1826724649;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=BjNTMayYfvOZeResDLWItELyMpG32CjhnX3n8/TjTsI=;
  b=J4ZXvZ/M5oYHLByPgd4JZkvSZ3veWfUuoye8kEUVK+5Ew8DLPkdreTTv
   nrjM/meTlCsBjbkWsGUF61jG27hX1H+fXdK9lABUP01w0DG9ingaNNDg2
   h5QvOE301nIjeARajZ79xbufsk+2ZDEOf8XCLMIodtpE7P41f5OmslOda
   ttRsz18lYXm8nXRMYhnz+/MgMC6mHSgPfa59/F0vcwnHU5AYonQDp4Ys0
   u9P44qUSqSjOCfyf3Mb9NUHUmBgL7am4wVdWWB+OZK5JPVewA/2WVSv43
   HlCwPwt+0HSC/jSPeTqYBW5w7w4iAEa7x8egw4WLN+sFuQlEOGs/U+Gri
   Q==;
X-CSE-ConnectionGUID: WvH6cdGWQtKpQ5EDOB2dgg==
X-CSE-MsgGUID: 7nWIoLkOQgO8aIOd3qvOzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4083501"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4083501"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 07:30:48 -0800
X-CSE-ConnectionGUID: vvluQiiNQq2EnWrIfbLPMg==
X-CSE-MsgGUID: +wOSsbS4TPCvqeywlujzMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="11063467"
Received: from spandruv-mobl5.amr.corp.intel.com (HELO [10.124.220.9]) ([10.124.220.9])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 07:30:46 -0800
Message-ID: <0165ee623890e4d3778390e46ad955956c512812.camel@linux.intel.com>
Subject: Re: [PATCH v2] HID: sensor-hub: Avoid holding spinlock across child
 iteration
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Zheng Shuhao <viennaoffh@gmail.com>, linux-input@vger.kernel.org, Zhang
 Lixu <lixu.zhang@intel.com>
Cc: jikos@kernel.org, jic23@kernel.org, bentiss@kernel.org, heiko@sntech.de,
 	lee@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ayaanmirzabaig85@gmail.com, 
	syzbot+fb951970a334aaff00ba@syzkaller.appspotmail.com
Date: Fri, 20 Nov 2026 07:30:44 -0800
In-Reply-To: <573f3eb75601c17d6e766fc47a7cce1bc2274998.camel@linux.intel.com>
References: <1795161418.hid-sensor-hub@viennaoffh.gmail.com>
		 <20261120135005.566-1-viennaoffh@gmail.com>
	 <573f3eb75601c17d6e766fc47a7cce1bc2274998.camel@linux.intel.com>
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

On Fri, 2026-11-20 at 07:12 -0800, Srinivas Pandruvada wrote:
> +Lixu
>=20
> On Fri, 2026-11-20 at 21:50 +0800, Zheng Shuhao wrote:
> > sensor_hub_remove() holds sensor_data->lock while walking the HID
> > device's
> > children with device_for_each_child(). The child iteration takes
> > the
> > device
> > core's klist lock, while sensor_hub_raw_event() takes
> > sensor_data->lock with interrupts disabled. This creates a lock-
> > order
> > inversion.
> >=20

In reality this can't happen as the
hid_hw_close() and hid_hw_stop() is called before, so there can't be
any raw_event.

> > Pass sensor_data to the callback and take the lock only while
> > examining
> > pending.status and completing pending.ready.
> >=20
> > The callback also visits non-Sensor Hub children. When HID battery
> > strength
> > support is enabled, the HID input layer may register a power-supply
> > child
> > without platform_data. Skip children without Sensor Hub data before
> > dereferencing it.
> >=20

How come this is possible? The HID sensor hub is only deleting its own
children. Can you give an example here?

Thanks,
Srinivas


> > Testing:
> > - With CONFIG_HID_BATTERY_STRENGTH=3Dy, ran a UHID Sensor
> > Hub/Joystick
> > device
> > =C2=A0 exposing Battery Strength through 15 create/destroy cycles acros=
s
> > three
> > =C2=A0 QEMU boots. The power-supply child was found each time; no Oops,
> > BUG, or
> > =C2=A0 KASAN report occurred.
> > - In the same configuration, hid_bpf passed 45 tests with 1 skip,
> > hidraw
> > =C2=A0 passed 27 tests, and hid-core, hid-apple, hid-gamepad, hid-ite,
> > =C2=A0 hid-keyboard, and hid-mouse passed.
> > - The full HID suite was not completed; it stopped during hid-
> > multitouch.
> > - The #syz test request was rejected because syzbot's automated
> > patch
> > =C2=A0 testing is temporarily unavailable.
>=20
> None of the above tested devices are HID SENSOR HUB related, so need
> some tests.
> Hi Lixu,
>=20
> Please give a try.
>=20
> Thanks,
> Srinivas
>=20
> >=20
> > Fixes: 8a5b38c3fd70 ("HID: hid-sensor-hub: don't use stale
> > platform-
> > data on remove")
> > Reported-by: syzbot+fb951970a334aaff00ba@syzkaller.appspotmail.com
> > Closes:
> > https://syzkaller.appspot.com/bug?extid=3Dfb951970a334aaff00ba
> > Signed-off-by: Zheng Shuhao <viennaoffh@gmail.com>
> > ---
> > Changes in v2:
> > - Pass sensor_data to the callback instead of NULL.
> > - Skip children without Sensor Hub platform_data; add a battery-
> > child
> > test.
> > - Add Fixes and correct the syzbot address; remove the self-added
> > Tested-by.
> >=20
> > =C2=A0drivers/hid/hid-sensor-hub.c | 12 ++++++++----
> > =C2=A01 file changed, 8 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-
> > hub.c
> > index 6470a290ebfc5..4c447f62480b5 100644
> > --- a/drivers/hid/hid-sensor-hub.c
> > +++ b/drivers/hid/hid-sensor-hub.c
> > @@ -804,9 +804,16 @@ static int sensor_hub_probe(struct hid_device
> > *hdev,
> > =C2=A0static int sensor_hub_finalize_pending_fn(struct device *dev, voi=
d
> > *data)
> > =C2=A0{
> > =C2=A0	struct hid_sensor_hub_device *hsdev =3D dev->platform_data;
> > +	struct sensor_hub_data *sensor_data =3D data;
> > +	unsigned long flags;
> > +
> > +	if (!hsdev)
> > +		return 0;
> > =C2=A0
> > +	spin_lock_irqsave(&sensor_data->lock, flags);
> > =C2=A0	if (hsdev->pending.status)
> > =C2=A0		complete(&hsdev->pending.ready);
> > +	spin_unlock_irqrestore(&sensor_data->lock, flags);
> > =C2=A0
> > =C2=A0	return 0;
> > =C2=A0}
> > @@ -814,16 +821,13 @@ static int
> > sensor_hub_finalize_pending_fn(struct device *dev, void *data)
> > =C2=A0static void sensor_hub_remove(struct hid_device *hdev)
> > =C2=A0{
> > =C2=A0	struct sensor_hub_data *data =3D hid_get_drvdata(hdev);
> > -	unsigned long flags;
> > =C2=A0
> > =C2=A0	hid_dbg(hdev, " hardware removed\n");
> > =C2=A0	hid_hw_close(hdev);
> > =C2=A0	hid_hw_stop(hdev);
> > =C2=A0
> > -	spin_lock_irqsave(&data->lock, flags);
> > -	device_for_each_child(&hdev->dev, NULL,
> > +	device_for_each_child(&hdev->dev, data,
> > =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sensor_hub_finalize_pending_fn)=
;
> > -	spin_unlock_irqrestore(&data->lock, flags);
> > =C2=A0
> > =C2=A0	mfd_remove_devices(&hdev->dev);
> > =C2=A0	mutex_destroy(&data->mutex);
