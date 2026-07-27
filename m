Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D653ED128;
	Mon, 27 Jul 2026 11:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785150586; cv=none; b=E291bpc/5ZWlZMdcC6azvVJ/FHLMyEWDSX8vWyGigslPWn16GvUkoqXoN5ZnqY4xaXYBu17BmBgb2/ng9sh4Vil13IllE0QHN3TRzH/5+ZYbaWUJKe40LSXvHNuftX1ow3/CJUqa3sBKjmd861q1yC6Myal0cTTbUfVgZtJa7dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785150586; c=relaxed/simple;
	bh=kCaruWpI1pazM7Yg1cdPpCF1PesbaDM35iGMeirp03M=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EGBSR/IdhX3mlj61YZRgz5OqjszSg7hextokvlhJXEf+S8iPRZHlXC7ag7jzC7SxbLJpV3vPylBk+ywGaAN8uWG45A8K/tqhExcU+v0++GbfyVfekK4VOM5SzrFkqIzzH+CD2A1FwoywJ49KVJvuAhKVyF+9c6FWj2dSXCoaqTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PAAvMY0D; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PAAvMY0D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785150585; x=1816686585;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=kCaruWpI1pazM7Yg1cdPpCF1PesbaDM35iGMeirp03M=;
  b=PAAvMY0DKK7eZR6pLhuZpSAv1ThrOqCF+DfMMkvW+FB0heHlruxWFFTd
   3McgATw+q5FUlavPzC/eRbQOUG2C7QGp9zdNs1jGBL44G/ZH+3qvj7b5r
   vRHwyKfk8uhkyMjLn8+lYebcjStmAvEVGkVlv2/eFBCV/t6sdefOxK+NY
   JpOWuykKP+lNz4pQ5jQ/MVgYzcYYv5fWILUQdWw1aECndw0ctds6RAFtE
   ky4KjVR+vXJUMxpWI31k5AmQqIvS5Om2/+6qWFPkCsOXLBeqpM0472Xw7
   v3/RD53WCGEgaDhwTIM96KN40ke7Ka1HHOMMMkl8z8cL24ahGvhYu0LKM
   g==;
X-CSE-ConnectionGUID: TAMZIGm0TbC8Vvr0zckJhg==
X-CSE-MsgGUID: YjCtrnR9QmmPQYEMaNHeFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11857"; a="85478668"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="85478668"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 04:09:44 -0700
X-CSE-ConnectionGUID: AiDwzKjARSqaug0cAKr9EQ==
X-CSE-MsgGUID: 5Wk+8iKbRaGWO0eeVZKODA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="297611875"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.226])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 04:09:39 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 27 Jul 2026 14:09:34 +0300 (EEST)
To: =?ISO-8859-15?Q?Marcus_Gren=E4ngen?= <marcus@grenangen.se>
cc: platform-driver-x86@vger.kernel.org, denis.benato@linux.dev, 
    linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    luke@ljones.dev, Hans de Goede <hansg@kernel.org>, jikos@kernel.org, 
    bentiss@kernel.org, corentin.chary@gmail.com
Subject: Re: [PATCH v3 1/3] HID: asus: export asus_hid_fnlock_set() for direct
 fn-lock control
In-Reply-To: <20260507092911.8855-2-marcus@grenangen.se>
Message-ID: <ad587675-cef3-f5b5-eb39-0f76dea8d617@linux.intel.com>
References: <9b568ce0-93f7-4a7f-98e4-625e910f8a1d@linux.dev> <20260507092911.8855-1-marcus@grenangen.se> <20260507092911.8855-2-marcus@grenangen.se>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-771095002-1785150574=:1169"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-771095002-1785150574=:1169
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 7 May 2026, Marcus Gren=C3=A4ngen wrote:

> Some ASUS platforms cannot control fn-lock via WMI DEVS and must send a
> HID feature report directly to the N-Key keyboard device instead.
>=20
> Add a module-level fnlock_hdev pointer (protected by a mutex) that is set
> at probe time for devices with QUIRK_HID_FN_LOCK and cleared at remove.
> Export asus_hid_fnlock_set(bool) so that asus-armoury can call into
> hid-asus without a circular dependency.
>=20
> Signed-off-by: Marcus Gren=C3=A4ngen <marcus@grenangen.se>
> ---
>  drivers/hid/hid-asus.c                     | 44 +++++++++++++++++++++-
>  include/linux/platform_data/x86/asus-wmi.h | 15 ++++++++
>  2 files changed, 58 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index d34d74df3dc0..402ba9d5e982 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -584,6 +584,39 @@ static void asus_sync_fn_lock(struct work_struct *wo=
rk)
>  =09asus_kbd_set_fn_lock(drvdata->hdev, drvdata->fn_lock);
>  }
> =20
> +/*
> + * Module-level reference to the HID device that handles fn-lock via fea=
ture
> + * report. Set at probe and cleared at remove for QUIRK_HID_FN_LOCK devi=
ces.
> + * Protected by fnlock_hdev_lock.
> + */
> +static DEFINE_MUTEX(fnlock_hdev_lock);
> +static struct hid_device *fnlock_hdev;
> +
> +/**
> + * asus_hid_fnlock_set() - Set fn-lock state directly via HID feature re=
port.
> + * @enabled: true to lock fn (F1-F12 primary), false to unlock.
> + *
> + * Called by asus-armoury on platforms where the WMI DEVS path for fn-lo=
ck is
> + * non-functional (e.g. ASUS ProArt P16, N-Key keyboard product ID 0x19B=
6).
> + *
> + * Returns: 0 on success, -ENODEV if no fn-lock capable HID device is pr=
esent.
> + */
> +int asus_hid_fnlock_set(bool enabled)
> +{
> +=09int ret;
> +
> +=09guard(mutex)(&fnlock_hdev_lock);
> +=09if (!fnlock_hdev)
> +=09=09return -ENODEV;
> +
> +=09ret =3D asus_kbd_set_fn_lock(fnlock_hdev, enabled);
> +=09if (ret < 0)
> +=09=09return ret;
> +
> +=09return 0;
> +}
> +EXPORT_SYMBOL_GPL(asus_hid_fnlock_set);
> +
>  static void asus_schedule_work(struct asus_kbd_leds *led)
>  {
>  =09unsigned long flags;
> @@ -969,6 +1002,8 @@ static int asus_input_configured(struct hid_device *=
hdev, struct hid_input *hi)
>  =09=09drvdata->fn_lock =3D true;
>  =09=09INIT_WORK(&drvdata->fn_lock_sync_work, asus_sync_fn_lock);
>  =09=09asus_kbd_set_fn_lock(hdev, true);
> +=09=09guard(mutex)(&fnlock_hdev_lock);
> +=09=09fnlock_hdev =3D hdev;
>  =09}
> =20
>  =09if (drvdata->tp) {
> @@ -1008,6 +1043,8 @@ static int asus_input_configured(struct hid_device =
*hdev, struct hid_input *hi)
>  =09=09drvdata->fn_lock =3D true;
>  =09=09INIT_WORK(&drvdata->fn_lock_sync_work, asus_sync_fn_lock);
>  =09=09asus_kbd_set_fn_lock(hdev, true);
> +=09=09guard(mutex)(&fnlock_hdev_lock);
> +=09=09fnlock_hdev =3D hdev;

What's going on with this patch? Why this context appears more than once=20
on different lines???

I even wasted my time on checking what hid tree has queued, and came up=20
zero explanation (as expected).

--
 i.
--8323328-771095002-1785150574=:1169--
