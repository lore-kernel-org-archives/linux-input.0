Received: from mail-10626.protonmail.ch (mail-10626.protonmail.ch [79.135.106.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E2C3D969D;
	Tue, 15 Sep 2026 05:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789449793; cv=none; b=pRcLek2SBrv6fzEXQ9ycX2xFN2g2m7nEKdZ0+MzpNskjS/0vkVTYyj3zjEPrCSJOYzjASA7o2Lp32ZyXCvPLfg82kPfiRSlvHmprP9u7GedbPnU0Nib3okdLzFAXTdiRJomS5cYKq4aryt6lO+tZ0CA/errmCNT76DRy/7QlmLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789449793; c=relaxed/simple;
	bh=jyHf8WbXjIhWw5PDgBgJVPysvBHwJ+Gb90CwBkglMqE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=chYvRstPV/M+5U+7fcs8ZQjpvmyo4zya99C6UMOnZC29XMOBuC69ZDuB4+q1YXKP/NWxHXPAXqAxjatcBE4JrbADoL8d2wlJUL7FNCarSh9Brfe90lgn8pNa6EYz2QoE0+GezAUZph3JLwS8+wiWHHBFkHLB5ag8bMrUWQ0B3es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=vasily.cc; spf=pass smtp.mailfrom=vasily.cc; dkim=pass (2048-bit key) header.d=vasily.cc header.i=@vasily.cc header.b=Ae8uSLrG; arc=none smtp.client-ip=79.135.106.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=vasily.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vasily.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vasily.cc header.i=@vasily.cc header.b="Ae8uSLrG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vasily.cc;
	s=protonmail2; t=1789449777; x=1789708977;
	bh=YOjkT0WRYH9ZTgYOKmI+YvNyNviW0Bc5NH9GRz2IL6Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Ae8uSLrGbsd9t0kQBv3LCjo8GHuqcon+ZBcqWs9vnJsPi4vBkUDe4P0FSJfIyfBJs
	 iqG/ZddFrrcd2h8h2pHR3Q5RWEMvcJQw2/S3I0FKePTedL8Gb+ym1hdzepvcQT4ogT
	 LIolXaTrvHzXSrQaNeVMVIQK0uBwRkBkqF2O4a+EFQa+auYJZ3tSpSFYPhr6Q/GYh2
	 +NObTKVpyM8HuLxWo6xNAnBIgbu6jqLYKJl6OE/ErfCe9EqFJZZ15FlM4w3EiF6y5z
	 phefRQ+YIDtMhQMslDJyHsv3G2YHvJcscigIqw1u2Q4Ot7Dl43Icocqd9PVu13Cs9i
	 AIKXXm21DUfdQ==
Date: Tue, 15 Sep 2026 05:22:52 +0000
To: Guenter Roeck <linux@roeck-us.net>
From: Vas Zayarskiy <contact@vasily.cc>
Cc: Aleksa Savic <savicaleksa83@gmail.com>, Jack Doan <me@jackdoan.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v3 1/4] HID: generic: Respect specialized drivers match callbacks
Message-ID: <5g3KauGo4e-yup8ACh6gfs0kZHbWatAAG3hXvT9HlYXSEbcNFslfWO7kfnaOtVtHPrl9w51LTnUhmOpLbAeoo8NfVaRIu2CU3GKsZcuW4nQ=@vasily.cc>
In-Reply-To: <feb99d33-074e-444b-8fc3-ae53ec365965@roeck-us.net>
References: <20260914233728.22725-1-contact@vasily.cc> <20260914233728.22725-2-contact@vasily.cc> <feb99d33-074e-444b-8fc3-ae53ec365965@roeck-us.net>
Feedback-ID: 162318860:user:proton
X-Pm-Message-ID: 78560f0f608a43a1f54be93cbb1ef2a516160b2a
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

> That was from 2022 and seems to have been abandoned, making me wonder
> if it is still broken for Logitech devices or if another solution
> was found.

The 2022 ->match() change was proposed to repair the fallback problem expos=
ed by wildcard enrollment of Logitech Bluetooth devices. Maintainers instea=
d reverted that wildcard enrollment in a9d9e46c755a, restoring the previous=
 explicit device matching (https://github.com/torvalds/linux/commit/a9d9e46=
c755a189ccb44d91b8cf737742a975de8). The way I understand it, the wildcard e=
nrollment was reverted, and that's why the ->match() change simply was not =
needed anymore.

In the hwmon-next base used for this series, Bluetooth devices are still se=
lected through explicit entries in hidpp_devices[], and hid-logitech-hidpp =
has no match callback. So the Logitech regression was resolved without adop=
ting the generic matching change.

For AMPINEL, the reason for patch 1 is to leave its separate keyboard inter=
face bound to hid-generic, so it can issue e.g. shutdown commands on abnorm=
al readings. Both interfaces match the hwmon driver's ID table. The existin=
g __check_hid_generic() therefore rejects the keyboard even when the hwmon =
match callback declines that interface. The hwmon fixes and sensor readings=
 do not depend on this HID change; it is needed by this design to preserve =
the keyboard's generic binding.

Jiri, Benjamin: is there a preferred way to express this per-interface sele=
ction while retaining hid-generic for the keyboard? I would welcome guidanc=
e on whether this callback check is the appropriate approach.


Thanks,
Vas




On Tuesday, September 15th, 2026 at 7:31 AM, Guenter Roeck <linux@roeck-us.=
net> wrote:

> On 9/14/26 16:37, Vas Zayarskiy wrote:
> > A driver can reject an interface in its match callback even when its ID
> > table matches. hid-generic currently yields based on the ID table alone=
,
> > leaving such an interface without a driver.
> >
> > Consult the callback after matching the ID table so hid-generic can kee=
p
> > interfaces declined by specialized drivers. This allows the AMPINEL
> > hwmon driver to leave the separate keyboard interface to hid-generic.
> >
> > The same callback check was proposed previously for Logitech devices:
> >
> > Link: https://lkml.iu.edu/hypermail/linux/kernel/2212.0/06724.html
>=20
> That was from 2022 and seems to have been abandoned, making me wonder
> if it is still broken for Logitech devices or if another solution
> was found.
>=20
> Guenter
>=20
> >
> > Assisted-by: LLM sparse
> > Signed-off-by: Vas Zayarskiy <contact@vasily.cc>
> > ---
> >   drivers/hid/hid-generic.c | 8 +++++++-
> >   1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/hid/hid-generic.c b/drivers/hid/hid-generic.c
> > index c2de91674..ebc38ae76 100644
> > --- a/drivers/hid/hid-generic.c
> > +++ b/drivers/hid/hid-generic.c
> > @@ -31,7 +31,13 @@ static int __check_hid_generic(struct device_driver =
*drv, void *data)
> >   =09if (hdrv =3D=3D &hid_generic)
> >   =09=09return 0;
> >
> > -=09return hid_match_device(hdev, hdrv) !=3D NULL;
> > +=09if (!hid_match_device(hdev, hdrv))
> > +=09=09return 0;
> > +
> > +=09if (hdrv->match)
> > +=09=09return hdrv->match(hdev, false);
> > +
> > +=09return 1;
> >   }
> >
> >   static bool hid_generic_match(struct hid_device *hdev,
>=20
> 
