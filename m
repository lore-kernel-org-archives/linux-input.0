Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793371775;
	b=Dn8gh1E7c07saBwshGy1C6GT4C6cwcIig4Ttq7hA2s4IU7WqQrZenLibXaYWP46i7IVJ
	 DmmqhsOSSmCjaHVtMm9dmbkPK70a1BDPNOIzVymuwwx2rkP2UmXoezwCnMzoXFVUlBVWP
	 VJzdQ32jyf+DvkVHk56Gx6b7+Su298J60e6JkmAzEwft5Emq52+nFBuD28JP0rQLObsG2
	 O+pJt7E2NewZtuNP69E0SjDVLIC5SkbgHG0Rbgd+fQ2w3OSobaOEM933bQpz8+pIWFYH8
	 uZGNPI1oMefoytJMvckahZOR4GQxSZ/ANqugVzsQeyXPwVJ/i+cba72xoS7U7G+yROA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793371775;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=OWpSvmLxVyjHJDnY/ic5oIn7pg4FjtluY41trfB4Ge0=;
	b=CddsXqTbA3ugoNj7QdO95vEDg3pGT0qQ6BBWO/X7Y9Omc1mwtpBejg/H1m1WMpaTRYfy
	 z6Uig1SSk83KxciqxY/VVR2f0Ip0c57E1QB4YD3IHRekmPvJJnw34HaaOaKcRIrfD9MCo
	 TdH6v14ZMmRz9BYjR37kCj9lATRtC1FI5Bj1dzMAmV2A/k2eFpKyKdvw4ms+QE16ii+D1
	 d3JyVdJGgHCggDdsvVEIHJ7DyLn2iESKG463WaORj9rsKRcQIxWy2tVKVajlf4uRP0f4g
	 fCfSU02oepJk0wno/ApsE9iRkFn22BLlGpCD07QwGS9ekwhoaEsGm9cHcVctrLDGhUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=S6c4AqG7;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90C6606A31A;
	Fri, 30 Oct 2026 14:49:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C90C6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=S6c4AqG7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793371774; x=1824907774;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Doet1d1G+yKl57wfrg8ykSXvOY8cnDtwrnTipp+LGBY=;
  b=S6c4AqG7VGEUBjg7kt9PgUAAU+In/yLbd78fxPV1KnAKOL5RAkNAlEkL
   YQDlaInq1U+VBoFtkTCrkaoLPKQSNT4ulSa9qRuWKfVw9AyXytT1/q1yu
   +j+kO8lsrDb+4PjFyIh/PF4bLV9JbL8y6IHZxWVhLMhVbARZa4TNzmXOF
   +LcYqn0zjBtSxSe9XQB8ixUwhl4MePWsfV3RyOgEjA3ozbtiTBwVki7XR
   wO0tCTWkpbLmsdJaTlAbPmSUXZm+y5fWBEGLzj8c5csbu6Q0Rd5jR2mZ1
   uma6PtGhpEb1/T/xj3BUlIdiF/wfwcmGfu8UvgbzhEanneWWSssuEaGXj
   A==;
X-CSE-ConnectionGUID: 3zQLst2AQu6UWno95qlRqg==
X-CSE-MsgGUID: ZVfxr2dRQMe9yukAtsibWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2165495"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2165495"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 07:49:33 -0700
X-CSE-ConnectionGUID: Whl9C6Q1RimU+yAJRoGDNQ==
X-CSE-MsgGUID: Xbttx0NnQ+i6/lThYFFfqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="7280422"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.32])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 07:49:27 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 30 Oct 2026 16:49:23 +0200 (EET)
To: Denis Benato <denis.benato@linux.dev>
cc: LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, 
    linux-input@vger.kernel.org, kernel@lists.opengamingcollective.org, 
    Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
    "Luke D . Jones" <luke@ljones.dev>, 
    Mateusz Schwartz <matthew.schwartz@linux.dev>, 
    Denis Benato <benato.denis96@gmail.com>, 
    Jonathan LoBue <jlobue10@gmail.com>, 
    Khamunetri Clark <khamunetriclark@gmail.com>, 
    "Derek J. Clark" <derekjohn.clark@gmail.com>, 
    Joshua Leivenzon <hacker1024@users.sourceforge.net>, 
    Nathan Chancellor <nathan@kernel.org>, 
    =?ISO-8859-15?Q?Rebecca_Mara_M=FCller?= <rebecca.mara@posteo.de>, 
    Ivan Levchenko <me@livan.pro>, Corentin Chary <corentin.chary@gmail.com>, 
    Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH v11 07/18] HID: asus: add support for response curve
In-Reply-To: <6361f6a6-3cfb-4eaf-babf-be548f28f2c0@linux.dev>
Message-ID: <731ec199-d121-e16d-c112-0694555b41bc@linux.intel.com>
References: <20261025235232.129945-1-denis.benato@linux.dev> <20261025235232.129945-8-denis.benato@linux.dev> <7688fc40-c439-005f-6a78-efdc39356694@linux.intel.com> <6361f6a6-3cfb-4eaf-babf-be548f28f2c0@linux.dev>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2019838273-1793371763=:1187"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2019838273-1793371763=:1187
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 30 Oct 2026, Denis Benato wrote:

>=20
> On 10/26/26 14:06, Ilpo J=C3=A4rvinen wrote:
> > On Sun, 25 Oct 2026, Denis Benato wrote:
> >
> >> ROG ally devices allows configuring the response curve of both joystic=
ks,
> >> therefore add the ability of userspace to modify the response curve by
> >> exposing relevant sysfs attributes.
> >>
> >> Signed-off-by: Denis Benato <denis.benato@linux.dev>
> >> Signed-off-by: Luke Jones <luke@ljones.dev>
> >> ---
> >>  drivers/hid/hid-asus.c | 297 ++++++++++++++++++++++++++++++++++++++++=
-
> >>  1 file changed, 294 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> >> index b4bc89ec28bc..e1883ee20413 100644
> >> --- a/drivers/hid/hid-asus.c
> >> +++ b/drivers/hid/hid-asus.c
> >> @@ -22,6 +22,7 @@
> >> =20
> >>  #include <linux/acpi.h>
> >>  #include <linux/cleanup.h>
> >> +#include <linux/ctype.h>
> >>  #include <linux/device.h>
> >>  #include <linux/dmi.h>
> >>  #include <linux/hid.h>
> >> @@ -185,6 +186,18 @@ struct asus_touchpad_info {
> >>  =09int report_size;
> >>  };
> >> =20
> >> +struct ally_joystick_resp_curve_param {
> >> +=09u8 move;
> >> +=09u8 resp;
> >> +} __packed;
> > Add include (if I didn't mentioned it already with some earlier patch,
> > I don't recall anymore :-)).
>=20
> Which one? I only see drivers either not including it directly or highly =
hardware-coupled including the one
> for the architecture, what about a driver that must work for x86 and arm6=
4?

__packed comes through linux/compiler.h

It's actually in include/linux/compiler_attributes.h but I assume we can=20
rely on compiler.h including it for the foreseable future (guaranteed=20
indirect include path).

--=20
 i.

--8323328-2019838273-1793371763=:1187--
