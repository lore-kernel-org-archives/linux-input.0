Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793829892;
	b=P33o2QqqpDdnkYAkrxqDktcjR6Ts/GKbP9Qa45/YsaynbNLPjGEWrAYIoHSELzp8XZoU
	 lCh5+DrgQy7CdI5qkT3Np0wjXLMzbAL9IzUX8nunq4iJCjWXftbeR+vS41YHQqFV3wDie
	 3Sklp3/KB9d/0E13gxK1F0LEcjEjQmBiDTO93++rvDmK82ynU6PvvEBzWAVoL+mfHl40z
	 qg8ivhQtv8NvUzjrdf1VHzW18gGze0ao0x4382vvAQVqRPiolFW4twWuyAH2sqZ09qxb2
	 CefTteRcjAfq93TfUgjkFHjUU8+ntkRMrPU9YUPglHXylbYIPoTZ2uyggVlyd2z80mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793829892;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=bmgdedAngAFoIFwO3WI5k0FYP50TIySMVLKbAoooDiA=;
	b=zkLKYmYJlGHscZbewSNuYbUTIIJIRR6jDCgZXSD1xPmy7DxyPl8MDyL4qvvPPVBLCIIY
	 aoJEO8/9QPpRKtHrhiF7V6ggVUMr5GqJOjzJ/2HZdg6CYSDfgcqEISzYXNOc9mBO6W8Yy
	 KWJOre8owVQo5lxM+0MF0jAelaiVFvARdjkYQ2a6mhUrconFUmPvO023v4Hfrnojfu6gx
	 oMTQVw1uuAHYJCpPgF6+t59qfuVqGUuD6w1K5jfbi+Rh8pJw6zvwH3NxHLPXY3zqBZYNv
	 7mmzFQN7rQ3OvXQF9vNvQfdjlpLHTmUO5hWjaUBAmGvCg2JP7XJahlbwKX+Qw1fr6Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Z7TEKmRq;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35BD606A335
	for <linux-input@vger.kernel.org>; Wed,  4 Nov 2026 22:04:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B35BD606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Z7TEKmRq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793829892; x=1825365892;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=ISKGUOX8IMj4CFP4ZkXUCJAAAaK/obCJ37UwHxQHNIo=;
  b=Z7TEKmRqgweeBY4w2gKQNkvQtFcWD/0uY+O3Cq41GBSCjuPoPSRIj+OT
   yG3Z+aXwpSAQHc/BprIWnGDuww+fEoPuNmCOx3kae2PRghD6FomPU19ow
   /yvkHQ6ndvEXipkAeIKf+sILBknC6p2qFyvSGDs1QRJHAVLnmGXVGtflk
   9lCWHgJiriio3qj4yn45oc9/L5xqverfLLIgFyLMUJGKMalRMPxcl7cml
   dPorPfy+NZqYO0Sp6fp+osUXMqTV13uhBoB09SlPyfaJK0RnBnk2lC0NE
   zQTCr5+mC3P+bABY73pusqIgUX/lz27pNm++IKdGDSEuhwDKCtQUtUANa
   w==;
X-CSE-ConnectionGUID: ZfCOPp/2RWGNAq6n+JuCQQ==
X-CSE-MsgGUID: urqlWYUxRkiE56ZsBzuz9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2489539"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2489539"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 14:04:51 -0800
X-CSE-ConnectionGUID: Y9yJlD5XSdqeBRKRZd8fHg==
X-CSE-MsgGUID: Sq5qcaQ9SOi9mMi68YYwWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="6665640"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [10.125.110.69]) ([10.125.110.69])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 14:04:51 -0800
Message-ID: <dcfc4211abe66f13f23cb546c478acb862a00d4d.camel@linux.intel.com>
Subject: Re: [PATCH v2 6/7] HID: sensor: custom: Register enable attribute
 after misc device
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Date: Wed, 04 Nov 2026 14:04:50 -0800
In-Reply-To: <sashiko-outbox-198009@kernel.org>
References: <20261104201403.2039921-1-srinivas.pandruvada@linux.intel.com>
	 <20261104201403.2039921-7-srinivas.pandruvada@linux.intel.com>
	 <sashiko-outbox-198009@kernel.org>
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

On Wed, 2026-11-04 at 20:25 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> - [Low] HID: sensor: custom: duplicate callback removal in
> hid_sensor_custom_probe()
> --
>=20
> commit 3c6fa7005fd38bc50c4da9b69a1182ec5457915f
> Author: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>=20
> HID: sensor: custom: Register enable attribute after misc device
>=20
> This commit reorders hid_sensor_custom_probe() so
> enable_sensor_attr_group is
> registered after hid_sensor_custom_dev_if_add() succeeds, preventing
> userspace
> from enabling the sensor hub while probe can still fail.
>=20

Will fix in next rev as this a minor issue to readjust code.

Thanks,
Srinivas

> > diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-
> > sensor-custom.c
> > index 4f824cadd370a..990e653995e15 100644
> > --- a/drivers/hid/hid-sensor-custom.c
> > +++ b/drivers/hid/hid-sensor-custom.c
> > @@ -1059,20 +1059,21 @@ static int hid_sensor_custom_probe(struct
> > platform_device *pdev)
> > =C2=A0	if (ret)
> > =C2=A0		goto err_remove_callback;
> > =C2=A0
> > -	ret =3D sysfs_create_group(&sensor_inst->pdev->dev.kobj,
> > -				 &enable_sensor_attr_group);
> > +	ret =3D hid_sensor_custom_dev_if_add(sensor_inst);
> > =C2=A0	if (ret)
> > =C2=A0		goto err_remove_attributes;
> > =C2=A0
> > -	ret =3D hid_sensor_custom_dev_if_add(sensor_inst);
> > +	ret =3D sysfs_create_group(&sensor_inst->pdev->dev.kobj,
> > +				 &enable_sensor_attr_group);
> > =C2=A0	if (ret)
> > -		goto err_remove_group;
> > +		goto err_remove_dev_if;
> > =C2=A0
> > =C2=A0	return 0;
> > =C2=A0
> > -err_remove_group:
> > -	sysfs_remove_group(&sensor_inst->pdev->dev.kobj,
> > -			=C2=A0=C2=A0 &enable_sensor_attr_group);
> > +err_remove_dev_if:
> > +	sensor_hub_remove_callback(hsdev, hsdev->usage);
> > +	hid_sensor_custom_dev_if_remove(sensor_inst);
> > +	goto err_remove_attributes;
> > =C2=A0err_remove_attributes:
> > =C2=A0	hid_sensor_custom_remove_attributes(sensor_inst);
> > =C2=A0err_remove_callback:
>=20
> [Severity: Low]
> In hid_sensor_custom_probe() in drivers/hid/hid-sensor-custom.c, when
> sysfs_create_group() for enable_sensor_attr_group fails and jumps to
> err_remove_dev_if, sensor_hub_remove_callback(hsdev, hsdev->usage) is
> called
> before hid_sensor_custom_remove_attributes(sensor_inst), followed by
> a goto to
> the immediately following err_remove_attributes label and a
> fallthrough to
> err_remove_callback:
>=20
> err_remove_dev_if:
> 	sensor_hub_remove_callback(hsdev, hsdev->usage);
> 	hid_sensor_custom_dev_if_remove(sensor_inst);
> 	goto err_remove_attributes;
> err_remove_attributes:
> 	hid_sensor_custom_remove_attributes(sensor_inst);
> err_remove_callback:
> 	sensor_hub_remove_callback(hsdev, hsdev->usage);
>=20
> Because hid_sensor_custom_probe() still holds the initial reference
> on
> sensor_inst until err_free (where kref_put() calls
> hid_sensor_custom_free() to
> free sensor_inst->data_fifo and sensor_inst), removing the callback
> at
> err_remove_dev_if unregisters the callback while the field sysfs
> attributes are
> still exposed, and then calls sensor_hub_remove_callback() a second
> time at
> err_remove_callback.
>=20
> Should err_remove_dev_if just call
> hid_sensor_custom_dev_if_remove(sensor_inst)
> and fall through to err_remove_attributes and err_remove_callback?
