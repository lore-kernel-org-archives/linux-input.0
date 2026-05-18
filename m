Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA3E3502A4
	for <linux-input@vger.kernel.org>; Mon, 18 May 2026 15:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779118444; cv=none; b=FbLuKv/ttjcwb/xooszXq8AJ/No/MZUsZ952Psk3VXhgjODcnrwBFU5uJxd9x2e3+2c1ZNq+CX798CsQyaXh9cMUd/NiyHajNvLBKlriZNZtOqVkSOd8AKtAY2uQew6mizbowzC+6ZpSdmCeecNauVNZrGBkwEzpxquNi1H1GD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779118444; c=relaxed/simple;
	bh=gDi+K0Hfl3aI8hiPKzXEVmQRpT3lL0dCLr646l0d9cc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OE0DvrhTLfzUiyBRkpoKSNuTSyU45j1QJbwpEqlTi8EUnQiYQeNixF+hOYVXrMuwmGjGESJ5w79GPpqsklvtbuAbFTUGRbXTZ7iogdwCIxvggsPA/Sv4cQM10eqCkEugyAPLqliLdV2pE1yck91rtTMbyclLoOilnaCiPtENaXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bes.tel; spf=pass smtp.mailfrom=bes.tel; dkim=pass (2048-bit key) header.d=bes.tel header.i=@bes.tel header.b=NEGmblXf; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=OndSVl9k; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bes.tel
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bes.tel
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bes.tel header.i=@bes.tel header.b="NEGmblXf";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="OndSVl9k"
DKIM-Signature: a=rsa-sha256; b=NEGmblXfGQByOelQ5MF/xKwZEf6JyLaqqee8WNaoPYpIfMgSi0W6M2RxJ/ceYQqKGoEgmwSACgJv0GmvvRRQfTnFlMozYgDWKT4s8K6tx9HtIEtFiuPoXSGM1aX1/KHwKrGgW2fOGpSSeK8A4QIIX0wF8a5KsM5eWuUhIZEd4GWW3MDOp/OeGli/eXHYwzZmHm1FjKEKPy6nYRqkq5DGIX89trVoQqB8//BM8GAGgRHtCFJDb1pbHfTfexyMNgj4f1AeFodusjL2mQ5S6y7jT+OdFak+vmpG5j4yN67BRfnpt3YDMpfakWBtR7H/wMRIhbqkCz2guEpXzmzG95Vpiw==; s=purelymail2; d=bes.tel; v=1; bh=gDi+K0Hfl3aI8hiPKzXEVmQRpT3lL0dCLr646l0d9cc=; h=Received:Received:Subject:From:To:Date;
DKIM-Signature: a=rsa-sha256; b=OndSVl9k0Cndxrt6qFbQdJ8Dtk0YIOsQiTqEbQoYKwS6RIEl6HKV0bFg4kCu1caRsjSTuaGe/sjBfsemXL6rBrSPQOIOcxLXQO1EMfIE9TbZ9vCe4cm6tnm3w0g3eUlE11s40OSdBecmLT5c4yfT4gwn1U+jdBmVwn3P5x67JYmglc2Nb0tZMWePi/NeVW8vwPeQIliInL7PX5UdncNk3RGgOpsE0qJy7zZYLawzwHB62Ea/ev1QMSDwZvilY+eH9U8zLzRX6wK5YiXCrDL866/aYKObIMTFUqN0ll1En+z7ZJ/ig5I0dnW+AHTiH9RUy2j4V92dYCPdFymbGjpnBg==; s=purelymail2; d=purelymail.com; v=1; bh=gDi+K0Hfl3aI8hiPKzXEVmQRpT3lL0dCLr646l0d9cc=; h=Feedback-ID:Received:Received:Subject:From:To:Date;
Feedback-ID: 19882:3702:null:purelymail
X-Pm-Original-To: linux-input@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -376610946;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 18 May 2026 15:33:47 +0000 (UTC)
Received: from [10.2.161.35] (unknown [10.2.161.35])
	by awak.mobi (Postfix) with ESMTPSA id 240A4362E34;
	Mon, 18 May 2026 17:33:46 +0200 (CEST)
Message-ID: <866798e9e270aeadf1b91f28a816914ed7abde02.camel@bes.tel>
Subject: Re: [PATCH] HID: lg-g15: Add support for the Logitech G710/G710+
 gaming keyboards
From: Xavier Bestel <xav@bes.tel>
To: Hans de Goede <hansg@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires
	 <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 18 May 2026 17:33:44 +0200
In-Reply-To: <3a03ac01-3b82-4ad6-bd35-f91ce738847c@kernel.org>
References: <20260402075239.3829699-1-xav@bes.tel>
	 <094db7d8-eb0c-4103-86fb-beb11580d53b@kernel.org>
	 <3a03ac01-3b82-4ad6-bd35-f91ce738847c@kernel.org>
Autocrypt: addr=xav@bes.tel; prefer-encrypt=mutual;
 keydata=mDMEaBuzUBYJKwYBBAHaRw8BAQdAGHVrbf6OLBOo4PjYPoYLSIOV+u8/rKgFlLM4pk+rj
 eC0G1hhdmllciBCZXN0ZWwgPHhhdkBiZXMudGVsPoiWBBMWCgA+FiEEPYfp8pYhYROehNkEULR9s/
 9K9OgFAmgbs1ACGwMFCQWjmoAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQULR9s/9K9OgeJAD
 /aPp0IPj5ahqo7DGo1Xk8/t7afPAHYMBeV03Fte4f57EBAPKvhRUTyR4+CrPtGERWfoYlxNkp5yKr
 wwkjUbLon1AG
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Le vendredi 15 mai 2026 =C3=A0 09:52 +0200, Hans de Goede a =C3=A9crit=C2=
=A0:
> Hi,
>=20
> On 6-Apr-26 20:50, Hans de Goede wrote:
> > Hi Xavier,
> >=20
> > Thank you for your patch, it is always nice to have people helping
> > with improving Linux support for devices like this.
> >=20
> > On 2-Apr-26 09:52, Xavier Bestel wrote:
> > > Add support for the Logitech G710 and G710+ (USB ID 046d:c24d) gaming
> > > keyboards to the hid-lg-g15 driver.
> > >=20
> > > These keyboards have 6 G-keys (G1-G6), M-keys (M1-M3, MR), a game mod=
e
> > > toggle, and two independent backlights: one for the main keyboard and=
 one
> > > for the WASD keys, each with a physical button to cycle brightness th=
rough
> > > 5 levels (0-4).
> > >=20
> > > Key implementation details:
> > >=20
> > > =C2=A0- G-keys and M-keys are reported via HID input report 0x03 (4 b=
ytes)
> > > =C2=A0=C2=A0 using KEY_MACRO1-6, KEY_MACRO_PRESET1-3 and KEY_MACRO_RE=
CORD_START.
> > >=20
> > > =C2=A0- The WASD backlight LED is registered as
> > > =C2=A0=C2=A0 "g15::kbd_zoned_backlight-wasd" rather than with a
> > > =C2=A0=C2=A0 "::kbd_backlight" suffix, because UPower currently only =
supports a
> > > =C2=A0=C2=A0 single kbd_backlight LED per device. This follows the no=
menclature
> > > =C2=A0=C2=A0 from Documentation/leds/leds-class.rst
> >=20
> > Actually that nomenclature is something which was suggested in the past
> > but has never been agreed upon.
> >=20
> > Since the discussion about how to name the LED class devices for
> > multi-zone keyboard backlights keeps coming up I've submitted a patch
> > now to document how these should be named:
> >=20
> > https://lore.kernel.org/linux-leds/20260406174638.320135-1-johannes.goe=
de@oss.qualcomm.com/
> >=20
> > Since the new userspace API for this needs to be agreed upon first, tha=
t
> > patch should be accepted upstream first, before we can move forward wit=
h
> > the G710 support from this patch.
>=20
> My v2 patch with the LED naming scheme has been accepted into the
> leds maintainer git tree now, so this is no longer a blocker for this
> patch:
>=20
> https://lore.kernel.org/linux-leds/20260504145434.12746-1-johannes.goede@=
oss.qualcomm.com/
>=20

Ok, I'm sending a new version of the patch.

Thanks,

    Xavier
