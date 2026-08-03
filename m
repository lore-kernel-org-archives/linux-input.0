Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD183331A6E;
	Mon,  3 Aug 2026 19:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785784163; cv=none; b=JCGAgaRSgHxjq/wAVl0s2FdWGbSBfWbXfbqWV31ehHJknzTiHh153ETqmO8FjKDExHbMAcHd4unUwIc2cVNsVqi85D+jATpJE5BPc9ud2thL3ywfyN+Zcz+NV6ACqFFZ0RpI52VWplIkE8lqusBP7Rx52AjZ+CR5dkGRpBUG5l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785784163; c=relaxed/simple;
	bh=SYggAMA0C2fYu1JJCQWeZxTDuNeGNOjkXEpMQoEOPh0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=abzrm1gxQYgMEQ7wA1LwxH1kHko4p66VoAWNDOtgRCIy6dUhJB8C/p1m5JWYhTiP7qw7Ux/ElulSzpyd2hAwMyg7GATaOBudwSk/lk39TTwV/d2JPZhYRQFPl593MXvcUD94etXzNTCDdSDqui4Z8/Lj1V9xFHemhwNqkeP7dZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id A7E733EE25;
	Mon,  3 Aug 2026 19:09:11 +0000 (UTC)
Message-ID: <374dc28d39d9247e8d07eb037672f928879b3156.camel@hadess.net>
Subject: Re: [PATCH] HID: logitech-hidpp: Remove duplicate ID for the G703
 Hero over USB
From: Bastien Nocera <hadess@hadess.net>
To: Jiri Kosina <jikos@kernel.org>
Cc: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Benjamin
 Tissoires	 <bentiss@kernel.org>, Filipe =?ISO-8859-1?Q?La=EDns?=
 <lains@riseup.net>
Date: Mon, 03 Aug 2026 21:09:11 +0200
In-Reply-To: <s8p49rsp-1772-7rp9-4543-o5762rps432o@xreary.bet>
References: <20260721173710.500368-2-stuart.a.hayhurst@gmail.com>
	 <21e8047a869d9d15eaae927fc0282bf0689b69f3.camel@hadess.net>
	 <s8p49rsp-1772-7rp9-4543-o5762rps432o@xreary.bet>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTEVArF00GQf85zxSvAb7VULuTCBNU+rAT5xNfitqnu9ucrBuxoL6AN1CFzAhF/cZs0Ya7fHOoignzz/X903HwxC204o4JcNHK8qppUGcmYnT3fIjJaMTnoVyIFFGZxVMXHiySfTkXWlaEFZpE3qcUB49fFi1KJEn8ifWTmcjcJAb8R1HsGQ3hL3f87+tviGYJ65GHwRruXPnm9grvWXTydhbkz3icI1OoQGS6DB+mtInTInIZFDpgAkjc4yYto1RxtaZRsh+mmPwaDTTijy5XykGD998oCq096PDX+aoDQBPWGOu+4j6VRu2j5rmXQwEk4zXh+4bHuJaUL/WpQtoGsahpUH+/AAKT4BAVPWrXfPDWfnWdftxKKS57H9iqcIxjoi7QgnRI6elTn0SnS1tS44989mtkWh3mjR3gH4faISM+8r10tnsjurb7JORsIeh/GJnzsXwwTtsaMq7JpWoPQSxI9Xc0pMsPBsdPj68/3twxUbl1RN3cB57mP+jo00bXQHtp6gqK2sIm9Jagwv/zHahU+nFN2evFLdwwm1YD4jyY21b1U+8P7UNish/GqogOXxA4M8Ww7jI9VsbOpi3PCZn9GVDUXJH/HWQ9hmI+D8tFjF6L/x1vMcouFTmb5Uyd7ll7o+kkjuDgLtPb5n7aCLeFgpWWjWaxVKqQts1KBpaA

On Mon, 2026-08-03 at 20:25 +0200, Jiri Kosina wrote:
> On Mon, 27 Jul 2026, Bastien Nocera wrote:
>=20
> > > The ID appears to be given twice, remove the duplicate
> > >=20
> > > Signed-off-by: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
> >=20
> > Indeed, at line 4652:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { /* Logitech G703 Hero Gami=
ng Mouse over USB */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HID_USB_DEVICE(U=
SB_VENDOR_ID_LOGITECH, 0xC090) },
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { /* Logitech G900 Gaming Mo=
use over USB */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HID_USB_DEVICE(U=
SB_VENDOR_ID_LOGITECH, 0xC081) },
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { /* Logitech G903 Gaming Mo=
use over USB */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HID_USB_DEVICE(U=
SB_VENDOR_ID_LOGITECH, 0xC086) },
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { /* Logitech G Pro Gaming M=
ouse over USB */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HID_USB_DEVICE(U=
SB_VENDOR_ID_LOGITECH, 0xC088) },
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { /* MX Vertical over USB */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HID_USB_DEVICE(U=
SB_VENDOR_ID_LOGITECH, 0xC08A) },
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { /* Logitech G703 Hero Gami=
ng Mouse over USB */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HID_USB_DEVICE(U=
SB_VENDOR_ID_LOGITECH, 0xC090) },
> >=20
> > Benjamin, Jiri, is there not a way to detect duplicates like this?
>=20
> I think the modern way to do this is to ask some LLM to find all of
> them=20
> :)

I meant a deterministic way, so I guess that's a no.

Cheers

>=20
> > In any case, looks good to me.
> >=20
> > Reviewed-by: Bastien Nocera <hadess@hadess.net>
>=20
> Thanks a lot, now queued.
