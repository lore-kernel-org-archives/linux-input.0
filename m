Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793375845;
	b=Fu25r//a6pREDs1KqEBgzz3VeBjaPPm8r3slNmvvfqYtsEf2nLNkrbqVrS0gdPsjmQdw
	 g+uHFhGqJrY7ebUQ3t+/SIUDPvyXIRKMAeMsfqCq1Hc1NsKQCCDIK8ucDyU/iQatpbS/Y
	 7dB9gbG2hl9GiT53sLE8H7bkM5soOP4qJpMBjLebyZ2I1qrF0wGWKWXLu5MLn1c7Qgm7+
	 +RGymiXpDwYWp5Y85N22ptmSyLLYrp3HFpctVomRKKgUftkgNqrYsJkKwmB5n73oQNLOI
	 571ftBDTrMlw/UPupRgK1sN5gwaXanJE7D4rDoq8V6kq8D0fdxSD1LE7LC7//mp6Tew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793375845;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=7t+WwoE8mtBkAzM2jdrUk70XLwl9S3Mo2QUTwJYyNXQ=;
	b=lSyg5VtCkWF6BZno+jF2rjx6le6idXhDmaDJTRPPVL8M9baARZbRjZ2XvQ9YhNpoA1Qk
	 0DmN/yftgxA19O5OfmWmFVeaMRsGQ8GQgTYHHVRWgQBp5Xb5Zo6Mneg2sDuCySTKBmwjf
	 Zi4thWOSiG+kEHw7Gz/RdOrftYnQlcmglBFYOBGouyV9F4B5PrBaV+bNxgzRKIe4Z8y/j
	 IczgtqhPozCOpqCkgKAxTf27aoOm+C2StLxCGfS9CZstHwIeLCVc1dKxFdYcv2tuPbrnR
	 8lcX9O7FHBsuIQY+B9n/BEHoQFhLKuo3Iahd4zMXgjSXTA9BoI/s5CngAdl8yXQHSxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=D6qVI0Me;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4BA606A320;
	Fri, 30 Oct 2026 15:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A4BA606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=D6qVI0Me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793375844; x=1824911844;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/H1Ccz4OfSkt8FeLmbcs7pahhdtzpfHfSBFEFqeOizk=;
  b=D6qVI0MeeIc15vHzK1f79mo/Zwty9mFmZtn9XbZXuSSjp2q3MqJkn5Np
   IkAyBFVEPGWMmKLR3KwQh8su1VFW5t2Cpo1S+rg2ebRkR2FiPIDpYee+Y
   qrtGrB4HsVeiVv6J6V1RpJwVvKCI2rmUScr5lCmH19NKG44rzk6wAwSWW
   XMLWw2kn3uornZILViaaZF6wMld8R4QTjCQxhBJFbgxEM0v2BdGSXYuNN
   u7jT08zfOw0HZCTXPO9uNOHdpOrHAoyNLQGXDHiLKkL2CU7+GVGkd/GtA
   y2eUzNrT7x9IYB5Ez4vt4yjXTpeUQ9OqH0bauxrioSYXCax39Nrtsq/E9
   w==;
X-CSE-ConnectionGUID: qESZNq8uT1GLQJwSawmA3Q==
X-CSE-MsgGUID: CDywpmmyQsiA7zQ6MUdopw==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2019694"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2019694"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 08:57:23 -0700
X-CSE-ConnectionGUID: jCa8Id8GRXW8ogvWFjKocQ==
X-CSE-MsgGUID: wlrgckAFTY++CUWUEBZJxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="7298055"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.32])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 08:57:18 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 30 Oct 2026 17:57:15 +0200 (EET)
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
Subject: Re: [PATCH v11 11/18] HID: asus: add support for btn remapping
In-Reply-To: <7adf0345-14a9-4dac-ad1d-863a7ae4b6e5@linux.dev>
Message-ID: <46c0df09-9a3c-62f5-322e-6fea93b9c3da@linux.intel.com>
References: <20261025235232.129945-1-denis.benato@linux.dev> <20261025235232.129945-12-denis.benato@linux.dev> <8db19c77-735a-1f21-ff08-f3254108d07e@linux.intel.com> <7adf0345-14a9-4dac-ad1d-863a7ae4b6e5@linux.dev>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2004668212-1793375835=:1187"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2004668212-1793375835=:1187
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 30 Oct 2026, Denis Benato wrote:

>=20
> On 10/26/26 15:03, Ilpo J=C3=A4rvinen wrote:
> > On Sun, 25 Oct 2026, Denis Benato wrote:
> >
> >> Add support for buttons remapping: the ability to assign different
> >> button events to each one of the physical button on the device.
> >>
> >> Each button exposes a remap_index sysfs attribute listing the valid
> >> remap target names for the current gamepad mode: M1 and M2 can be
> >> remapped to anything at any time, while other buttons may only be
> >> remapped to gamepad codes in gamepad mode and keyboard/mouse/media
> >> codes in desktop mode.
> >>
> >> When the gamepad mode is changed the firmware automatically restores
> >> its internal defaults, so the software cache is refreshed to reflect
> >> the hardware state.
> >>
> >> Signed-off-by: Luke Jones <luke@ljones.dev>
> >> Signed-off-by: Denis Benato <denis.benato@linux.dev>
> >> Signed-off-by: Jonathan LoBue <jlobue10@gmail.com>
> >> ---
> >>  drivers/hid/hid-asus.c | 1059 +++++++++++++++++++++++++++++++++++++++=
-
> >>  1 file changed, 1037 insertions(+), 22 deletions(-)
> >>
> >> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> >> index ed95b2cdec81..ea27495c3df6 100644
> >> --- a/drivers/hid/hid-asus.c
> >> +++ b/drivers/hid/hid-asus.c
> >> @@ -275,9 +275,25 @@ struct ally_turbo_config {
> >>  =09struct ally_btn_turbo_params btn_m1;
> >>  };
> >> =20
> >> +/* Button remap attribute structure */
> >> +struct button_remap_attr {
> >> +=09struct device_attribute dev_attr;
> >> +=09enum ally_button_id button_id;
> >> +=09bool is_macro;
> >> +=09/*
> >> +=09 * The attributes are created while hid_asus_ally_probe() is still
> >> +=09 * running, before asus_probe() publishes drvdata->rog_ally: carry
> >> +=09 * the pointer like the turbo entries do, so the callbacks work
> >> +=09 * from the moment the files exist.
> >> +=09 */
> >> +=09struct ally_handheld *ally;
> >> +};
> >> +
> >> +#define to_button_remap_attr(x) container_of(x, struct button_remap_a=
ttr, dev_attr)
> >> +
> >>  struct ally_btn_sysfs_entry {
> >>  =09struct attribute_group group;
> >> -=09struct attribute *attrs[5]; /* turbo_period + toggle_period + rang=
es + NULL */
> >> +=09struct attribute *attrs[8]; /* turbo + ranges + remap + macro + re=
map_index + NULL */
> >>  =09/*
> >>  =09 * The entries are created while hid_asus_ally_probe() is still ru=
nning,
> >>  =09 * before asus_probe() publishes drvdata->rog_ally: carrying the s=
hared
> >> @@ -289,6 +305,9 @@ struct ally_btn_sysfs_entry {
> >>  =09enum ally_button_id btn;
> >>  =09struct device_attribute attr_turbo_period;
> >>  =09struct device_attribute attr_toggle_period;
> >> +=09struct button_remap_attr *remap_attr;
> >> +=09struct button_remap_attr *macro_attr;
> >> +=09struct device_attribute attr_remap_index;
> >>  };
> >> =20
> >>  enum ally_gamepad_mode_index {
> >> @@ -296,6 +315,35 @@ enum ally_gamepad_mode_index {
> >>  =09ALLY_GAMEPAD_MODE_KEYBOARD =3D 0x02,
> >>  };
> >> =20
> >> +/* Button pair indexes for mapping commands */
> >> +enum btn_pair_index {
> >> +=09BTN_PAIR_DPAD_UPDOWN    =3D 0x01,
> >> +=09BTN_PAIR_DPAD_LEFTRIGHT =3D 0x02,
> >> +=09BTN_PAIR_STICK_LR       =3D 0x03,
> >> +=09BTN_PAIR_BUMPER_LR      =3D 0x04,
> >> +=09BTN_PAIR_AB             =3D 0x05,
> >> +=09BTN_PAIR_XY             =3D 0x06,
> >> +=09BTN_PAIR_VIEW_MENU      =3D 0x07,
> >> +=09BTN_PAIR_M1M2           =3D 0x08,
> >> +=09BTN_PAIR_TRIGGER_LR     =3D 0x09,
> >> +};
> >> +
> >> +struct button_map {
> >> +=09const struct btn_code_map *remap;
> >> +=09const struct btn_code_map *macro;
> >> +};
> >> +
> >> +struct button_pair_map {
> >> +=09enum btn_pair_index pair_index;
> >> +=09struct button_map first;
> >> +=09struct button_map second;
> >> +};
> >> +
> >> +/* Store button mapping per gamepad mode */
> >> +struct ally_button_mapping {
> >> +=09struct button_pair_map button_pairs[9]; /* 9 button pairs */
> >> +};
> >> +
> >>  struct ally_config {
> >>  =09/* Must be locked if the data is being changed */
> >>  =09struct mutex config_mutex;
> >> @@ -331,6 +379,8 @@ struct ally_config {
> >> =20
> >>  =09struct ally_turbo_config turbo;
> >>  =09struct ally_btn_sysfs_entry *button_entries;
> >> +=09/* Button mappings of the current gamepad mode */
> >> +=09struct ally_button_mapping button_mappings;
> >> =20
> >>  =09struct ally_joystick_resp_curve left_curve;
> >>  =09struct ally_joystick_resp_curve right_curve;
> >> @@ -1072,6 +1122,295 @@ static int ally_set_gamepad_mode(struct ally_h=
andheld *ally, struct hid_device *
> >>  =09return 0;
> >>  }
> >> =20
> >> +enum btn_map_type {
> >> +=09BTN_TYPE_NONE =3D 0,
> >> +=09BTN_TYPE_PAD =3D 0x01,
> >> +=09BTN_TYPE_KB =3D 0x02,
> >> +=09BTN_TYPE_MOUSE =3D 0x03,
> >> +=09BTN_TYPE_MEDIA =3D 0x05,
> >> +};
> >> +
> >> +struct btn_code_map {
> >> +=09unsigned char type;
> >> +=09unsigned char value;
> >> +=09const char *name;
> >> +};
> >> +
> >> +static const struct btn_code_map ally_btn_codes[] =3D {
> >> +=09{ BTN_TYPE_NONE, 0x00, "NONE" },
> >> +=09/* Gamepad button codes */
> >> +=09{ BTN_TYPE_PAD, 0x01, "BTN_SOUTH" },
> >> +=09{ BTN_TYPE_PAD, 0x02, "BTN_EAST" },
> >> +=09{ BTN_TYPE_PAD, 0x03, "BTN_NORTH" },
> >> +=09{ BTN_TYPE_PAD, 0x04, "BTN_WEST" },
> >> +=09{ BTN_TYPE_PAD, 0x05, "BTN_TL" },
> >> +=09{ BTN_TYPE_PAD, 0x06, "BTN_TR" },
> >> +=09{ BTN_TYPE_PAD, 0x07, "BTN_THUMBL" },
> >> +=09{ BTN_TYPE_PAD, 0x08, "BTN_THUMBR" },
> >> +=09{ BTN_TYPE_PAD, 0x09, "ABS_HAT0Y_NEG" },
> >> +=09{ BTN_TYPE_PAD, 0x0A, "ABS_HAT0Y_POS" },
> >> +=09{ BTN_TYPE_PAD, 0x0B, "ABS_HAT0X_NEG" },
> >> +=09{ BTN_TYPE_PAD, 0x0C, "ABS_HAT0X_POS" },
> >> +=09{ BTN_TYPE_PAD, 0x0D, "ABS_Z" },
> >> +=09{ BTN_TYPE_PAD, 0x0E, "ABS_RZ" },
> >> +=09{ BTN_TYPE_PAD, 0x11, "BTN_SELECT" },
> >> +=09{ BTN_TYPE_PAD, 0x12, "BTN_START" },
> >> +=09{ BTN_TYPE_PAD, 0x13, "BTN_MODE" },
> >> +
> >> +=09/* Keyboard button codes */
> >> +=09{ BTN_TYPE_KB, 0x8E, "FN_M2" },
> >> +=09{ BTN_TYPE_KB, 0x8F, "FN_M1" },
> >> +=09{ BTN_TYPE_KB, 0x76, "KEY_ESC" },
> >> +=09{ BTN_TYPE_KB, 0x05, "KEY_F1" },
> >> +=09{ BTN_TYPE_KB, 0x06, "KEY_F2" },
> >> +=09{ BTN_TYPE_KB, 0x04, "KEY_F3" },
> >> +=09{ BTN_TYPE_KB, 0x0C, "KEY_F4" },
> >> +=09{ BTN_TYPE_KB, 0x03, "KEY_F5" },
> >> +=09{ BTN_TYPE_KB, 0x0B, "KEY_F6" },
> >> +=09{ BTN_TYPE_KB, 0x80, "KEY_F7" },
> >> +=09{ BTN_TYPE_KB, 0x0A, "KEY_F8" },
> >> +=09{ BTN_TYPE_KB, 0x01, "KEY_F9" },
> >> +=09{ BTN_TYPE_KB, 0x09, "KEY_F10" },
> >> +=09{ BTN_TYPE_KB, 0x78, "KEY_F11" },
> >> +=09{ BTN_TYPE_KB, 0x07, "KEY_F12" },
> >> +=09{ BTN_TYPE_KB, 0x08, "KEY_F13" },
> >> +=09{ BTN_TYPE_KB, 0x10, "KEY_F14" },
> >> +=09{ BTN_TYPE_KB, 0x18, "KEY_F15" },
> >> +=09{ BTN_TYPE_KB, 0x0E, "KEY_GRAVE" }, // backtick
> >> +=09{ BTN_TYPE_KB, 0x16, "KEY_1" },
> >> +=09{ BTN_TYPE_KB, 0x1E, "KEY_2" },
> >> +=09{ BTN_TYPE_KB, 0x26, "KEY_3" },
> >> +=09{ BTN_TYPE_KB, 0x25, "KEY_4" },
> >> +=09{ BTN_TYPE_KB, 0x2E, "KEY_5" },
> >> +=09{ BTN_TYPE_KB, 0x36, "KEY_6" },
> >> +=09{ BTN_TYPE_KB, 0x3D, "KEY_7" },
> >> +=09{ BTN_TYPE_KB, 0x3E, "KEY_8" },
> >> +=09{ BTN_TYPE_KB, 0x46, "KEY_9" },
> >> +=09{ BTN_TYPE_KB, 0x45, "KEY_0" },
> >> +=09{ BTN_TYPE_KB, 0x4E, "KEY_MINUS" }, // hyphen
> >> +=09{ BTN_TYPE_KB, 0x55, "KEY_EQUAL" },
> >> +=09{ BTN_TYPE_KB, 0x66, "KEY_BACKSPACE" },
> >> +=09{ BTN_TYPE_KB, 0x0D, "KEY_TAB" },
> >> +=09{ BTN_TYPE_KB, 0x15, "KEY_Q" },
> >> +=09{ BTN_TYPE_KB, 0x1D, "KEY_W" },
> >> +=09{ BTN_TYPE_KB, 0x24, "KEY_E" },
> >> +=09{ BTN_TYPE_KB, 0x2D, "KEY_R" },
> >> +=09{ BTN_TYPE_KB, 0x2C, "KEY_T" },
> >> +=09{ BTN_TYPE_KB, 0x35, "KEY_Y" },
> >> +=09{ BTN_TYPE_KB, 0x3C, "KEY_U" },
> >> +=09{ BTN_TYPE_KB, 0x43, "KEY_I" },
> >> +=09{ BTN_TYPE_KB, 0x44, "KEY_O" },
> >> +=09{ BTN_TYPE_KB, 0x4D, "KEY_P" },
> >> +=09{ BTN_TYPE_KB, 0x54, "KEY_LEFTBRACE" },
> >> +=09{ BTN_TYPE_KB, 0x5B, "KEY_RIGHTBRACE" },
> >> +=09{ BTN_TYPE_KB, 0x5D, "KEY_BACKSLASH" },
> >> +=09{ BTN_TYPE_KB, 0x58, "KEY_CAPSLOCK" },
> >> +=09{ BTN_TYPE_KB, 0x1C, "KEY_A" },
> >> +=09{ BTN_TYPE_KB, 0x1B, "KEY_S" },
> >> +=09{ BTN_TYPE_KB, 0x23, "KEY_D" },
> >> +=09{ BTN_TYPE_KB, 0x2B, "KEY_F" },
> >> +=09{ BTN_TYPE_KB, 0x34, "KEY_G" },
> >> +=09{ BTN_TYPE_KB, 0x33, "KEY_H" },
> >> +=09{ BTN_TYPE_KB, 0x3B, "KEY_J" },
> >> +=09{ BTN_TYPE_KB, 0x42, "KEY_K" },
> >> +=09{ BTN_TYPE_KB, 0x4B, "KEY_L" },
> >> +=09{ BTN_TYPE_KB, 0x4C, "KEY_SEMICOLON" },
> >> +=09{ BTN_TYPE_KB, 0x52, "KEY_APOSTROPHE" },
> >> +=09{ BTN_TYPE_KB, 0x5A, "KEY_ENTER" },
> >> +=09{ BTN_TYPE_KB, 0x88, "KEY_LEFTSHIFT" },
> >> +=09{ BTN_TYPE_KB, 0x1A, "KEY_Z" },
> >> +=09{ BTN_TYPE_KB, 0x22, "KEY_X" },
> >> +=09{ BTN_TYPE_KB, 0x21, "KEY_C" },
> >> +=09{ BTN_TYPE_KB, 0x2A, "KEY_V" },
> >> +=09{ BTN_TYPE_KB, 0x32, "KEY_B" },
> >> +=09{ BTN_TYPE_KB, 0x31, "KEY_N" },
> >> +=09{ BTN_TYPE_KB, 0x3A, "KEY_M" },
> >> +=09{ BTN_TYPE_KB, 0x41, "KEY_COMMA" },
> >> +=09{ BTN_TYPE_KB, 0x49, "KEY_DOT" },
> >> +=09{ BTN_TYPE_KB, 0x4A, "KEY_SLASH" },
> >> +=09{ BTN_TYPE_KB, 0x89, "KEY_RIGHTSHIFT" },
> >> +=09{ BTN_TYPE_KB, 0x82, "KEY_LEFTMETA" },
> >> +=09{ BTN_TYPE_KB, 0x8A, "KEY_LEFTALT" },
> >> +=09{ BTN_TYPE_KB, 0x29, "KEY_SPACE" },
> >> +=09{ BTN_TYPE_KB, 0x8B, "KEY_RIGHTALT" },
> >> +=09{ BTN_TYPE_KB, 0x84, "KEY_COMPOSE" },
> >> +=09{ BTN_TYPE_KB, 0x8D, "KEY_RIGHTCTRL" },
> >> +=09{ BTN_TYPE_KB, 0xC3, "KEY_SYSRQ" },
> >> +=09{ BTN_TYPE_KB, 0x7E, "KEY_SCROLLLOCK" },
> >> +=09{ BTN_TYPE_KB, 0x91, "KEY_PAUSE" },
> >> +=09{ BTN_TYPE_KB, 0xC2, "KEY_INSERT" },
> >> +=09{ BTN_TYPE_KB, 0x94, "KEY_HOME" },
> >> +=09{ BTN_TYPE_KB, 0x96, "KEY_PAGEUP" },
> >> +=09{ BTN_TYPE_KB, 0xC0, "KEY_DELETE" },
> >> +=09{ BTN_TYPE_KB, 0x95, "KEY_END" },
> >> +=09{ BTN_TYPE_KB, 0x97, "KEY_PAGEDOWN" },
> >> +=09{ BTN_TYPE_KB, 0x98, "KEY_UP" },
> >> +=09{ BTN_TYPE_KB, 0x99, "KEY_DOWN" },
> >> +=09{ BTN_TYPE_KB, 0x9A, "KEY_LEFT" },
> >> +=09{ BTN_TYPE_KB, 0x9B, "KEY_RIGHT" },
> >> +
> >> +=09/* Numpad button codes */
> >> +=09{ BTN_TYPE_KB, 0x77, "KEY_NUMLOCK" },
> >> +=09{ BTN_TYPE_KB, 0x90, "KEY_KPSLASH" },
> >> +=09{ BTN_TYPE_KB, 0x7C, "KEY_KPASTERISK" },
> >> +=09{ BTN_TYPE_KB, 0x7B, "KEY_KPMINUS" },
> >> +=09{ BTN_TYPE_KB, 0x70, "KEY_KP0" },
> >> +=09{ BTN_TYPE_KB, 0x69, "KEY_KP1" },
> >> +=09{ BTN_TYPE_KB, 0x72, "KEY_KP2" },
> >> +=09{ BTN_TYPE_KB, 0x7A, "KEY_KP3" },
> >> +=09{ BTN_TYPE_KB, 0x6B, "KEY_KP4" },
> >> +=09{ BTN_TYPE_KB, 0x73, "KEY_KP5" },
> >> +=09{ BTN_TYPE_KB, 0x74, "KEY_KP6" },
> >> +=09{ BTN_TYPE_KB, 0x6C, "KEY_KP7" },
> >> +=09{ BTN_TYPE_KB, 0x75, "KEY_KP8" },
> >> +=09{ BTN_TYPE_KB, 0x7D, "KEY_KP9" },
> >> +=09{ BTN_TYPE_KB, 0x79, "KEY_KPPLUS" },
> >> +=09{ BTN_TYPE_KB, 0x81, "KEY_KPENTER" },
> >> +=09{ BTN_TYPE_KB, 0x71, "KEY_KPDOT" },
> >> +
> >> +=09/* Mouse button codes */
> >> +=09{ BTN_TYPE_MOUSE, 0x01, "BTN_LEFT" },
> >> +=09{ BTN_TYPE_MOUSE, 0x02, "BTN_RIGHT" },
> >> +=09{ BTN_TYPE_MOUSE, 0x03, "BTN_MIDDLE" },
> >> +=09{ BTN_TYPE_MOUSE, 0x04, "REL_WHEEL_HI_RES_UP" },
> >> +=09{ BTN_TYPE_MOUSE, 0x05, "REL_WHEEL_HI_RES_DOWN" },
> >> +
> >> +=09/* Media button codes */
> >> +=09{ BTN_TYPE_MEDIA, 0x16, "MEDIA_SCREENSHOT" },
> >> +=09{ BTN_TYPE_MEDIA, 0x19, "MEDIA_SHOW_KEYBOARD" },
> >> +=09{ BTN_TYPE_MEDIA, 0x1C, "MEDIA_SHOW_DESKTOP" },
> >> +=09{ BTN_TYPE_MEDIA, 0x1E, "MEDIA_START_RECORDING" },
> >> +=09{ BTN_TYPE_MEDIA, 0x01, "MEDIA_MIC_OFF" },
> >> +=09{ BTN_TYPE_MEDIA, 0x02, "MEDIA_VOL_DOWN" },
> >> +=09{ BTN_TYPE_MEDIA, 0x03, "MEDIA_VOL_UP" },
> >> +};
> >> +
> >> +static const size_t keymap_len =3D ARRAY_SIZE(ally_btn_codes);
> > Why is this a variable???? Can't the users just directly use ARRAY_SIZE=
 on=20
> > the array????
>=20
> Not understood: you say variable, but both are const(s), isn't const
> the exact opposite of variable?

My point was that you should use ARRAY_SIZE(ally_btn_codes) directly in=20
the 2 place (IIRC) instead of keymap_len. Then you can just drop=20
keymap_len entirely.

> I am stepping away for today, but I have cleaned up much of this
> mess.
>
> > At v11 it's odd to find this much garbage still remaining... :-(
>=20
> At a certain (late) point of the development I noticed that remapping
> buttons on the X applied immediately, while on my Ally 1 it had
> to go through apply_all old sysfs interface, so I attempted to
> unify them late on development, sorry.

I think my comment was a bit uncalled for anyway, but please see it in=20
the light how much lines I had read at that point.

--=20
 i.

--8323328-2004668212-1793375835=:1187--
