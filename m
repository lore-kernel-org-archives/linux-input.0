Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1455678C9;
	Thu, 10 Sep 2026 18:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789064925; cv=none; b=pI6jGWozEJCxeihY2jDEhsDe4HUNQmbYtUq/ErVuUe9F3KJzhBrv8URtkWUfE1DEp4FkMV4s4/In6t3XiG6OoA719s4Qdd6ZmTjXV3Px8osBYnSy8aSrEBd5EDgldwjJ1kiDPsvdL5pnkXdWAH5jaT1d62XE+H6U7NYNHReByTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789064925; c=relaxed/simple;
	bh=P6r8qL8JM02zCM7xElGZ6ujGdsdo355IYFvW1YpAx5c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KKZpzBoRmiLCHs+h9efxiQdZ/r1/Mvj+oAqRFF83p02AMZqNsWcpoX9QkF7IPZgaxoDi0gsiVLiG5sTX+4tjenUHgJKSz92dzYDIDfzhWryIq1ClOprCHGRRav1NEOL7vA8WHhgpb4haZ9vClMryu8ZpMJg/DAehgdN1Dq/aAbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fEJjTob+; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fEJjTob+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789064918; x=1820600918;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=P6r8qL8JM02zCM7xElGZ6ujGdsdo355IYFvW1YpAx5c=;
  b=fEJjTob+c+CfaneMReWCzcgbdzFK+QLMFOOCW20PzE99oattk72TECnI
   Qkafp8ClpWU9LODS4jvKMCq/DPeoVEO1zZGHcLq6/5xp0WEhbrLmPT/0G
   7+Msm80+GtmceT8NO0c8ku+KCBOPLoltH1WDb6ZNUSbfMJ12rpF+vU0Lz
   f89rJwZqccLMDcp+qpVfcE6bb89uGBlLirflirYiJSY53fSDZYe6MNuFB
   Ui/au8/sKOVJ2zWtey327Qwzu7X5OZ0JCEevZfHpg+gRmF/DdMLBOkkOV
   8ne68pDVGRfTczAIp/YwPxcLUSAyQrXuFkJxYkADaDQuE70voW3DtvDqX
   Q==;
X-CSE-ConnectionGUID: Vu41G5FyQQ+t6UXcrQ34aA==
X-CSE-MsgGUID: +AMxJoH6Q5y1RyvwLre1aQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="89290569"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="89290569"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 11:28:33 -0700
X-CSE-ConnectionGUID: cXjgPvKtQaCdAn2j+rRl9w==
X-CSE-MsgGUID: hx2gbnyTRlWT3b+wa77yAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="72484"
Received: from spandruv-desk1.amr.corp.intel.com ([10.124.222.115])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 11:28:33 -0700
Message-ID: <9ae8e6b44ffaf5affb7324f802a3626c581ac461.camel@linux.intel.com>
Subject: Re: [PATCH v1] HID: sensor-hub: synchronize multi-value read
 cancellation
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Yibo Tan <lhfff@tju.edu.cn>, Jiri Kosina <jikos@kernel.org>, Jonathan
 Cameron <jic23@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: Zhang Lixu <lixu.zhang@intel.com>, Andy Shevchenko
	 <andriy.shevchenko@intel.com>, linux-input@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 10 Sep 2026 11:28:32 -0700
In-Reply-To: <20260910112338.4171983-1-lhfff@tju.edu.cn>
References: <20260910112338.4171983-1-lhfff@tju.edu.cn>
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

On Thu, 2026-09-10 at 19:23 +0800, Yibo Tan wrote:
> sensor_hub_input_attr_read_values() publishes a caller-owned buffer
> to the
> raw-event path. If its interruptible wait times out or is
> interrupted, it
> clears pending.status without taking data->lock and returns.
>=20

Hi Lixu,

Please give me quick test. Change itself looks good, not sure if we
need something more.

Thanks,
Srinivas


> sensor_hub_raw_event() may already have observed pending.status while
> holding that lock. The caller can then release its buffer before raw-
> event
> finishes copying into it.
>=20
> Take data->lock when cancelling the request. The raw-event path now
> either
> sees the request retired or finishes the copy before cancellation can
> return.
>=20
> On an uninstrumented PREEMPT_RT kernel, a valid 16-byte quaternion
> report
> overwrote a live futex waiter's plist node with the report's 0x41
> payload.
> Two vulnerable runs produced the same general protection fault in
> plist_del(), after 471 and 91 completed trials. The locking fix
> completed
> two 10,000-trial runs without an Oops, panic, warning or payload
> signature.
>=20
> The virtual provider setup and FIFO assignment require privilege. The
> IIO
> read, signal handling and futex operations run as uid 65534 without
> effective capabilities. No physical-device or normal-priority hit was
> tested.
>=20
> A source reproducer, kernel configuration, complete serial logs and
> the
> vulnerable/fixed result table are available at:
>=20
> https://github.com/kimaiden1984-boop/linux-kernel-poc-collections/tree/ma=
in/cases/hid-sensor-quaternion-root-a
>=20
> Fixes: f784fcea4506 ("HID: sensor-hub: Add
> sensor_hub_input_attr_read_values() for multi-byte reads")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link:
> https://lore.kernel.org/r/20260610083849.067A11F00893@smtp.kernel.org/
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:GPT-5
> Signed-off-by: Yibo Tan <lhfff@tju.edu.cn>
> ---
> =C2=A0drivers/hid/hid-sensor-hub.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-
> hub.c
> index 6470a290ebfc..80f18aff6f1f 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -335,7 +335,9 @@ int sensor_hub_input_attr_read_values(struct
> hid_sensor_hub_device *hsdev,
> =C2=A0		else if (cycles < 0)
> =C2=A0			ret =3D cycles;
> =C2=A0
> +		spin_lock_irqsave(&data->lock, flags);
> =C2=A0		hsdev->pending.status =3D false;
> +		spin_unlock_irqrestore(&data->lock, flags);
> =C2=A0	}
> =C2=A0	mutex_unlock(hsdev->mutex_ptr);
> =C2=A0
