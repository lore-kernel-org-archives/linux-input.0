Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794245528;
	b=x0QzpY0iJFcBAZz6g/pGHl69YKrxRe8HIu1rZNbMzN2BRAUSK18gbwITKCsEwR+20Xwt
	 Pk6uPEJFz40gth2mAM8Wgt65/J4m1WzHTuEIeM+7Qsk7jajcYFq0rEHzj6o766L680CP3
	 Hp9AgvWbSvneDbue+zmWxiu6ypLF6LlH+LsAclYxfCCJH+N3Msc0FE9WqqVVMJEt6ZVPh
	 hae3x9exvixwSXv+OTnpUJBUHKXOPEJ0MGZvLgcB5ahUbR9VQcufCiphzq3Tjt7dnwt6Z
	 otO0i6rNXuWW7krPoiV3OwBak2sYktJRpqG46HjS1lI1z1Tlo7vpM3L5QVZ+Gx0POaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794245528;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=2qu43I+RoEH+OT0sDV9VPfe4bpn8kTW9uXAIjMppvGo=;
	b=yl+ShkuT9dPc53aa26Dl4Te4w3eWrtdJ1AyuG3aYg52ugOxkpvY4kXGN+LpKdFc+PLxq
	 hIf4JaI5Vr5q906yW5xoMhTBH3x7nahVkUUa/Vsvw6n7V0xsjJ4yGXVxfkawASwToBFVL
	 JbbGTp7fYqFBUfiyPGkmw5jx68bD1itd6qbUg3cHb0QiXu9wipvPy/ygiJnBLoDPFy0iM
	 gYIuthtepBMUEdmkim5rZ6BXZHjVSVPmQ7ISjF+G87zHZyEA3IUR80YHsWMTmhTrj1sbO
	 l0HZAQ1X8VAwD7IvKqLyP2Y+GybyIq1FcVtZzUCAa+VWoMrBhMd/kdIgGym6+6+ByYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Jeesut3w;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649B3606A32A;
	Mon,  9 Nov 2026 17:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 649B3606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Jeesut3w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794245527; x=1825781527;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=AY4akx4T8fYslyCNt1w+Vo9SD2n8tIz75sbQc+tCbCg=;
  b=Jeesut3wjXwIH1lLX9ZJR00/aqCVSfLtXce7jp43aW+iSOQyyNhCMtCv
   9iY+YVxnVJMUAkdaRoxKBZt8SnsmTuZYmc5QYd1448gI2LCXwYRd2hEE1
   lQFvt5bkWVD6TL+qZidh2fQWS+iOVXg/UbmV6ybsBIAj3rlUIZj6pr77T
   JzZchDUDE8hOKfsQSblq3qDGGEqC1kF6fiX4q7Y769SkPGuDauuSsrbBY
   LRHpBwDk9lQ4ZJKY5n+igJ06VW/TCuXxPlIinJgHhgTfHuJELO1HmHWjl
   b+i9aiqoJeF8BDF1i/fkZ0HzAdYDAVn2uab7IFGBoFM1/SipjKSzWoOr+
   w==;
X-CSE-ConnectionGUID: Z3Jzftd1QHiwpRfYwR3nDA==
X-CSE-MsgGUID: HnQMt8ujS5aUEhRLlylquQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2876033"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2876033"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 09:32:07 -0800
X-CSE-ConnectionGUID: 9JTIpCErScWOd0t4WcRFTA==
X-CSE-MsgGUID: mqu9ShSyTgGmL7FVhHc5CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="7970217"
Received: from spandruv-desk2.jf.intel.com ([10.24.80.14])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 09:32:07 -0800
Message-ID: <4a773d0d614a7bed29fc7e2ab7f6e40d63407531.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/7] HID: sensor: hub: Synchronize callback removal
 with raw events
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: jikos@kernel.org, bentiss@kernel.org, linux-input@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 simeon@maryasin.name, 	lixu.zhang@intel.com, crofts@kernel.org
Date: Mon, 09 Nov 2026 09:32:06 -0800
In-Reply-To: <20261107201319.0f496662@jic23-hlaptop>
References: <20261104201403.2039921-1-srinivas.pandruvada@linux.intel.com>
		<20261104201403.2039921-2-srinivas.pandruvada@linux.intel.com>
	 <20261107201319.0f496662@jic23-hlaptop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sat, 2026-11-07 at 20:13 +0000, Jonathan Cameron wrote:
> On Wed,=C2=A0 4 Nov 2026 12:13:57 -0800
> Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
>=20
> > Raw-event processing holds pdata->lock across callback lookup and
> > invocation, and takes dyn_callback_lock during lookup. Removal must
> > prevent both active callbacks and future lookups before client
> > state can
> > be released.
> >=20
> > Take pdata->lock before dyn_callback_lock, matching raw-event
> > order,
> > and unlink the callback while holding both locks. This ensures
> > active
> > raw-event callbacks have finished and prevents future lookups.
> >=20
> > Fixes: 401ca24fb34a ("HID: sensors: introduce sensor framework")
> > Reported-by: =D0=A1=D0=B5=D0=BC=D1=91=D0=BD =D0=9C=D0=B0=D1=80=D1=8C=D1=
=8F=D1=81=D0=B8=D0=BD <simeon@maryasin.name>
> > Closes:
> > https://lore.kernel.org/all/CAM2dg7ewfVJSP4rFyhkCB1Rmd1+X56sAg=3DeUdbPt=
hG2xrLqwQQ@mail.gmail.com/
> > Signed-off-by: Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com>
>=20
> Maybe a minimal fix is good for now, but I do note that we can
> make this code nicer with some guard() magic.

Yes guard() will be better here.
guard() can be a different cleanup as this should be done in whole
driver instead of this one function here. I will do a clean up patch
instead of fixes.

Thanks,
Srinivas

>=20
> Perhaps a follow up series to tidy this up.
>=20
> Things are getting very messy around this driver wrt to fix vs
> cleanup.=C2=A0 Hopefully it won't cause too much of a problem in next
> until I can merge the fixes back after they go upstream.
>=20
> > ---
> > =C2=A0drivers/hid/hid-sensor-hub.c | 7 +++++--
> > =C2=A01 file changed, 5 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-
> > hub.c
> > index 6470a290ebfc..0c4884c5821f 100644
> > --- a/drivers/hid/hid-sensor-hub.c
> > +++ b/drivers/hid/hid-sensor-hub.c
> > @@ -173,7 +173,9 @@ int sensor_hub_remove_callback(struct
> > hid_sensor_hub_device *hsdev,
> > =C2=A0	struct sensor_hub_data *pdata =3D hid_get_drvdata(hsdev-
> > >hdev);
> > =C2=A0	unsigned long flags;
> > =C2=A0
> > -	spin_lock_irqsave(&pdata->dyn_callback_lock, flags);
> > +	/* Serialize callback removal with raw-event callback
> > execution. */
> > +	spin_lock_irqsave(&pdata->lock, flags);
> > +	spin_lock(&pdata->dynfunction_callback_lock);
>=20
> Do both of those with appropriate guard()=20
>=20
> > =C2=A0	list_for_each_entry(callback, &pdata->dyn_callback_list,
> > list)
> > =C2=A0		if (callback->usage_id =3D=3D usage_id &&
> > =C2=A0						callback->hsdev =3D=3D
> > hsdev) {
> I'd just go long!
> =C2=A0		if (callback->usage_id =3D=3D usage_id && callback-
> >hsdev =3D=3D hsdev) {
>=20
>=20
> > @@ -181,7 +183,8 @@ int sensor_hub_remove_callback(struct
> > hid_sensor_hub_device *hsdev,
> > =C2=A0			kfree(callback);
> > =C2=A0			break;
> And we can return here.
>=20
> > =C2=A0		}
> > -	spin_unlock_irqrestore(&pdata->dyn_callback_lock, flags);
> > +	spin_unlock(&pdata->dyn_callback_lock);
> > +	spin_unlock_irqrestore(&pdata->lock, flags);
> > =C2=A0
> > =C2=A0	return 0;
> > =C2=A0}
