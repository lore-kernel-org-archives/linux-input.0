Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793368582;
	b=l95C2yn0jddOjvqGuiQfWTlHtHx0SOlbcjSozgd2kVpkMu8EuCvbC9DGaddbWFYuSQHY
	 ejdNQZEUw0Pnj9omJSYpsqHljtucjrW28bKd2Ug5CzVC23H7bjifLz+OhRIGfcEwXn842
	 LqF2K5LarcANaT9I3EEwbFymdki6kFaK0ZRjDP8ujJZUH5DUisAy6sO2/SgyybXVQinq7
	 V3qrAxyh5bJ/0VyWcEQLWyntK1YAlupMMMpfWYrfXLyKZjbx5TuEdw3FVg01Du0wGbHkj
	 jBwJ7J3Dz5OxVQezwcrOa3/Opu4U7kBnX4k86rxIhh3MpR5QW6BBQPKIFlG/IISFfsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793368582;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:
	 Content-ID;
	bh=w1kqOyDDIUKrhtOCJmGJYi+BUT1Og4QY4onzDyYjeyU=;
	b=cFG68uvzOs3ZSovHTlPs94pQzulHDfQh4ebsvZGVggxnjePUPiOdpETud1k5r5zQNIfb
	 TiV6J2WQ6auJl8x9LuRdIHVGqD0j8Q6QF+ZF/5ASkJPfkuFKuEbaEb67atydWdn2aoEHG
	 xx+xzeEtLVzXpvqEEheYfp4ryhiTedW2X2jXHajRCxbQdUJ364aDXJ4dWYC6mxACxDbYM
	 /okuryhOjjcpzo6zz9NjX5z3Xgl2TbYeGLTQuy/ox/G94Uig2lEj6Lag0+Dsi326VIzXo
	 Ei36/3JCPDsFbnkhINDe+SV4jpwxzSLiFNd0nsDU1xoDjMs/WCCWk9agQPNiIbzTR5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hZPb1bfh;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2370606A31A;
	Fri, 30 Oct 2026 13:56:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2370606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hZPb1bfh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793368581; x=1824904581;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=tSrR83xmYSA2BSZqQe/R73Z6YlF/aFH/BPV381rMTpg=;
  b=hZPb1bfhXeM1DuDqUF8c/RYPKzKHR5DqVtOM8PH11jzC0W0dObKXsDau
   OqmBAWg8dOe+0A2wk2Kw5cA+Lc+jgMTMkyP1sIs/rVyPxxhY10ot1JAjl
   DehFKVPP5I5wrcoJiYcSvn8drH+OnR6H97VDriLLBpCt0J2aNdm5cZmkY
   2rTLc4IU/eqlsHuFRaEunoSX/vN9AEssWlgPm4zGbnJT2BPZ0s0VBTNnX
   E3zi0FYeWVbfWgU4zln8WAZwGKUnI4LTGoaJm89akbalVxWDs1DpGhWS7
   8ntt2mRHA/SURcfNbRo0Xig54Jrzoo2D4zt7rTrM4EM7g6vqvS3NiIGBi
   Q==;
X-CSE-ConnectionGUID: w2Vkw13QSGO/9N4H8a5DeA==
X-CSE-MsgGUID: vYTjEp2KRdKXiMMdvU9JJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2235830"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2235830"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 06:56:20 -0700
X-CSE-ConnectionGUID: /nJK04mTQk6xXF/K80kNog==
X-CSE-MsgGUID: 2pQcFYS0RUGFkPbjkXruZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5333988"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.32])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 06:56:04 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 30 Oct 2026 15:56:01 +0200 (EET)
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
Subject: Re: [PATCH v11 01/18] HID: asus: add support for ROG Ally
 handhelds
In-Reply-To: <3791151b-8530-4c38-a9a5-77f415625116@linux.dev>
Message-ID: <e78dc7ed-a23a-7f84-ce77-7aec3eee62ac@linux.intel.com>
References: <20261025235232.129945-1-denis.benato@linux.dev> <20261025235232.129945-2-denis.benato@linux.dev> <088f5d2a-c5e1-5805-1872-27aa70b556dd@linux.intel.com> <3791151b-8530-4c38-a9a5-77f415625116@linux.dev>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-2025089043-1793368272=:1187"
Content-ID: <187ef955-790a-d80a-f165-d2de080c5e8c@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2025089043-1793368272=:1187
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <dad506c7-13f4-29bf-a712-d28df967e311@linux.intel.com>

On Fri, 30 Oct 2026, Denis Benato wrote:

>=20
> On 10/26/26 13:38, Ilpo J=E4rvinen wrote:
> > On Sun, 25 Oct 2026, Denis Benato wrote:
> >
> >> Implement the core functionality for ASUS handhelds:
> >> - extend functionality of hid-asus if driver is enabled
> >> - initialise the device to a "ready" state
> >> - implement Ally X input mapping
> >> - emit a single proper event for AC button long press
> >> - reject probes from a different controller and from duplicated
> >>   interfaces of the same one, which could evict the shared state
> >>
> >> Signed-off-by: Khamunetri Clark <khamunetriclark@gmail.com>
> >> Signed-off-by: Denis Benato <denis.benato@linux.dev>
> >> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> >> Signed-off-by: Luke Jones <luke@ljones.dev>
> >> Signed-off-by: Jonathan LoBue <jlobue10@gmail.com>
> > Shouldn't you be using some Co-developed-by tags too?

> >> +/**
> >> + * ally_gamepad_check_ready() - Wait for the gamepad MCU to report re=
ady
> >> + * @ally: ally handheld structure
> >> + * @hdev: HID device
> >> + *
> >> + * This should be called before any remapping attempts, and on driver
> >> + * init/resume, after the asus handshake has been performed on the
> >> + * configuration endpoint.
> >> + *
> >> + * Return: 0 on success, negative errno on failure
> >> + */
> >> +static int ally_gamepad_check_ready(struct ally_handheld *ally, struc=
t hid_device *hdev)
> >> +{
> >> +=09u8 payload[] =3D { 0x00 };
> > =3D {} is enough to initialize.
> >
> >> +=09int ret;
> >> +
> >> +=09for (int i =3D 0; i < HID_ALLY_READY_MAX_TRIES; i++) {
> >> +=09=09u8 *buf __free(kfree) =3D ally_alloc_cmd(CMD_CHECK_READY, paylo=
ad, sizeof(payload));
> >> +=09=09if (!buf)
> >> +=09=09=09return -ENOMEM;
> >> +
> >> +=09=09ret =3D ally_gamepad_send_receive_packet(ally, hdev, buf, ROG_A=
LLY_REPORT_SIZE);
> > ally_gamepad_send_packet()'s buf is const so why you need to alloc it o=
ver=20
> > and over again?
> >
> > Arguably, I'm not sure if this retry loop is expected to execute many=
=20
> > times.
>=20
> no the used buffer is u8 *buf (non const) and it gets overwritten by the =
method
> with the MCU response.

Ah, yes the buf arg seems not const now that I double check. I must have=20
accidently searched for some other function name which inputed const buf=20
(e.g. old function name in the copy-paste buffer for some reason). I'm=20
sorry about that.

> Since I am not sure if while not ready it can write other bytes I have op=
ted to
> free it and reallocate it with correct data sice it is what gets sent and=
 also
> what is returned.
>=20
> Also yes, that cycle has to run many times to await for the MCU to come b=
ack:
> it has caused quite a few troubles in the past.
>=20
> >> +=09=09if (ret < 0) {
> >> +=09=09=09hid_dbg(hdev, "ROG Ally check %d/%d failed: %d\n", i,
> >> +=09=09=09=09HID_ALLY_READY_MAX_TRIES, ret);
> >> +=09=09=09continue;
> >> +=09=09}
> >> +
> >> +=09=09if (buf[2] =3D=3D CMD_CHECK_READY)
> >> +=09=09=09return 0;
> >> +
> >> +=09=09usleep_range(1000, 2000);
> >> +=09}
> >> +
> >> +=09hid_err(hdev, "ROG Ally never responded with a ready\n");
> >> +=09return -ENODEV;
> >> +}


> >> +=09byte =3D in_report->buttons[0];
> >> +=09input_report_key(input, BTN_A, byte & BIT(0));
> >> +=09input_report_key(input, BTN_B, byte & BIT(1));
> >> +=09input_report_key(input, BTN_X, byte & BIT(2));
> >> +=09input_report_key(input, BTN_Y, byte & BIT(3));
> >> +=09input_report_key(input, BTN_TL, byte & BIT(4));
> >> +=09input_report_key(input, BTN_TR, byte & BIT(5));
> >> +=09input_report_key(input, BTN_SELECT, byte & BIT(6));
> >> +=09input_report_key(input, BTN_START, byte & BIT(7));
> >> +
> >> +=09byte =3D in_report->buttons[1];
> >> +=09input_report_key(input, BTN_THUMBL, byte & BIT(0));
> >> +=09input_report_key(input, BTN_THUMBR, byte & BIT(1));
> >> +=09input_report_key(input, BTN_MODE, byte & BIT(2));

BTW, while cutting text I noticed these BIT()s should be named with=20
defines.



--=20
 i.
--8323328-2025089043-1793368272=:1187--
