Received: from mail-43102.protonmail.ch (mail-43102.protonmail.ch [185.70.43.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8226A19B5A3
	for <linux-input@vger.kernel.org>; Mon,  7 Sep 2026 22:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788819133; cv=none; b=GKvmzGFKYxtzctJIGoqaH3p7uDSzwRZ8YOSP7R0ijipwSiX/flrFCcH0C6Goag+RgnwcGER85SgBYnQUppPRUMJop9AALq3vAADUZIx3azBBf1EFMK+FV5N3ihp8WC5f12y9zeSXYcpGitAwf2nHIQ3ZA8nYGo8wuMJcgu+s8Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788819133; c=relaxed/simple;
	bh=9jS3zDJDRELWxNOH6ecWRPwqMGBV7fhLIxor1HT8G5k=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=Kkm4MQlzhuTsrW9iuY6ZRZyOCkiAOs4fc3hb2hvN8mOafx1p7iuTY2P50tOKAwZAky3nzvMRyYQqPnCg4uqy+SYm7pEATW7RgkQSItfwrkwvFaFRvTi94+WvX3q74qonLeNZ4uh/6vNPzmlIDQUfTmNZXTo6HHczHwqRrp+4rx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=KTe/Z9lF; arc=none smtp.client-ip=185.70.43.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="KTe/Z9lF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1788819123; x=1789078323;
	bh=9jS3zDJDRELWxNOH6ecWRPwqMGBV7fhLIxor1HT8G5k=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=KTe/Z9lFJFIG6j4XpuiPd9HPxJ17Q7og6Zi5SoeB9/SMyIwqPsI7MWia9nMWOaYGJ
	 ZBiStz0GigXORTUj736mJZisof30NA1VNBfYfa+vywOFrBjFF2bpGYM39rtG53v2Ra
	 WxQK79tJd1SuDSXE2ErUegI+L5g6jghieCOz0EfSv9QcnJ705pOb6HDwANeEhyTaEZ
	 vOjSt2J+BsJQCnGp8zcIhsSGkw+VPNi65CGqS7lnaitN9QpW9T0qe/jOyZ+vDNr2XR
	 Ufhm7I423tVtjIMc/PK4UqsuV/JvfQMRLq5My7w/i5sbGuxeALYI+r/8vlMgtt2AmU
	 SpXiiE39A29eA==
Date: Mon, 07 Sep 2026 22:11:58 +0000
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
From: dontfindmymail <dontfindmymail@pm.me>
Subject: ASUS T302CHI keyboard dock (0b05:182f) missing from hid-asus, brightness keys dead
Message-ID: <3FT9KF4mQjCGoihBjuDz6W8sMNmawVCdABOi5wxAxpsxpStq8wWpWwJfA-f-3mqVT6kM1-2CpTTVzMi_PFihOEDrBvz9XIzHv4a6fOcSnh4=@pm.me>
Feedback-ID: 181967199:user:proton
X-Pm-Message-ID: 100da225a6023228e91ee1182fe382acefc54120
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,
The keyboard dock of the ASUS Transformer Book T302CHI is missing from
the hid-asus device table, so its brightness keys do not work.

The dock (USB 0b05:182f) reports brightness on the ASUS vendor usage
page 0xff31, usages 0x10 and 0x20, which hid-asus already maps to
KEY_BRIGHTNESSDOWN / KEY_BRIGHTNESSUP. Because the device is not in
asus_devices[], it is claimed by hid-generic, which ignores the vendor
page entirely, so Fn+F5 and Fn+F6 produce no input events at all - not
even a scancode. Keys on the standard consumer page (volume) on the
same device work fine, which makes this look like a backlight or ACPI
problem rather than a HID one.

From /sys/kernel/debug/hid/<dev>/events, pressing Fn+F5 then Fn+F6:

=C2=A0 report (size 6) (numbered) =3D =C2=A05a 10 00 00 00 00
=C2=A0 ff31.0010 =3D 1
=C2=A0 report (size 6) (numbered) =3D =C2=A05a 00 00 00 00 00
=C2=A0 ff31.0010 =3D 0
=C2=A0 report (size 6) (numbered) =3D =C2=A05a 20 00 00 00 00
=C2=A0 ff31.0020 =3D 1
=C2=A0 report (size 6) (numbered) =3D =C2=A05a 00 00 00 00 00
=C2=A0 ff31.0020 =3D 0

Confirmed fix: after

=C2=A0 echo "0003 0B05 182F" > /sys/bus/hid/drivers/asus/new_id

and rebinding that interface from hid-generic to hid-asus, both keys
work correctly in all desktop environments.

The device exposes three HID interfaces, one of which is a touchpad
handled by hid-multitouch, so I believe this wants the same
HID_GROUP_GENERIC match already used for the T101HA dock:

=C2=A0 hid-ids.h:
=C2=A0 =C2=A0 #define USB_DEVICE_ID_ASUSTEK_T302CHI_KEYBOARD 0x182f

=C2=A0 hid-asus.c, in asus_devices[]:
=C2=A0 =C2=A0 { HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_T3=
02CHI_KEYBOARD) },

Kernel: "7.2.2-zen1-1-zen", Arch Linux.

I am not set up to submit a proper patch, so I am reporting it here in
the hope that someone can pick it up.

Thanks!
