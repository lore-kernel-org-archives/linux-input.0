Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C767E3D16EF;
	Thu, 30 Jul 2026 08:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785400690; cv=none; b=gm8pBkA5CZ4qw6zg0E9+iGRyQtCfcQtUqiuuE/+P2/DGs4OJQQnWVZNNoAI9PeLjL+a8tJPgi8IW/lhG/ti1vv90DDQiYw2zhJ1KilD6GzjCdXcgTAY9hSVRdFdmOjJnUip5mogl5QIlNxpvlasXb3mXZqFQc0HhlsmQBRPCe5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785400690; c=relaxed/simple;
	bh=T1qzo7aXw52cWod1PVmGvRMtGLQnnkY+r9Nx82rqAC0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q259GIcUphdH8LJ2YJ8NAq4dxnTI99Uf1l7O7aDxGSOcZAzxS2j//xVDXHnnJ1ig5Jbv4HVoKBUlIIkSu0EXyaHXefY8GvcD2EKExQ2nITOtBtSsGH/Vv0CgNrdFjn1iAscaeVV114g5MDlIDhkDWyePZdZZMEo4tnDb3+2klcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0CCC33EBC0;
	Thu, 30 Jul 2026 08:38:02 +0000 (UTC)
Message-ID: <14807a258220aaa2bf4ae5020b452c7da4201168.camel@hadess.net>
Subject: Re: [PATCH v2 1/1] HID: logitech: add Bolt receiver support for
 Logitech HID++ devices
From: Bastien Nocera <hadess@hadess.net>
To: =?UTF-8?Q?Kate=C5=99ina_Medv=C4=9Bdov=C3=A1?= <k8ie@mcld.eu>, Erik
 =?ISO-8859-1?Q?H=E5kansson?=
	 <erikhakan@gmail.com>
Cc: bentiss@kernel.org, jikos@kernel.org, lains@riseup.net, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 30 Jul 2026 10:38:02 +0200
In-Reply-To: <54844d1b-636c-4896-8994-f4e960e57944@mcld.eu>
References: <bcbf28f0-a3da-454d-b05e-a554017fba0e@mcld.eu>
	 <20260714005441.472898-1-erikhakan@gmail.com>
	 <54844d1b-636c-4896-8994-f4e960e57944@mcld.eu>
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
X-GND-Score: -100
X-GND-Cause: dmFkZTEotOkHdf6LEhPH0PH+tTiCTwWM/XlMmlsYgSRK9Lgh1PTz1wghC0VanIUpMaYlHq/jpnvKd3tpEz7fgOIPiwmimRKKogyokqBTRmqjZS0ZXZRreaXvyD6MYrwDqeHhacx2LcvohrnJI3OBEgtnZGLtwwAaG7d56VRout2tRzseHKukzd8pS8xxJAOB8qBcp3e7Fe0kjrP1URiaj9gzb0aQDrvvRTBAbQzEn2CBWokEPy1P6K5Wv3yLu4VrzShhzFaHSG3bkOnGFbrqpVZkaXkf/2fgbtYzlflJlDh0yCmTu9k0ftwnb9kxJ+dKSmsw5shitBmmlHbPPaO8H74IBICUP+RDSRPhDomnSsssjPkMnN8Bx1vuyylQXbe2Lpz+V7Vo7o9QKmPWPClBiqjuwskMeXK33ddVwdDUupIf53DBTkZ/72yrdde1LZuYebEzQb1qT7tnBA3qLTGIg6OUemBdDBFCcAvtBMdBvMUffUTO2F8rLjCMhpoHj2BSiquIUhifgTVvWwPfzReCxHtTbbaHndrZFiNGTMbZccFcrkBoilhXZFnihngU9nZaXE8md+PbtL0DvURvB2Zz+GNEAh2sn5T41ThAGdKBywW5rmn9rc43v4uWXYxXXnvhMqBKbyLHxPR9V+WsBNJ7e9f2eV2Cf6b3STE4B7oulIEXF3QT+g
X-GND-State: clean

On Tue, 2026-07-14 at 12:32 +0200, Kate=C5=99ina Medv=C4=9Bdov=C3=A1 wrote:
> Hi,
>=20
> Just tested V1 again with both of the receiver versions I have on
> hand=20
> and the input issues I described happen on both.
>=20
> btw, thank you for pointing out that you can check the FW version in=20
> fwupd. This greatly simplified testing.
>=20
> I do have one find -- when a device gets powered off (yanked battery,
> switch moved to the off position, switching devices), the battery
> stays=20
> in upower. Unifying also does this, disconnected devices stay.

Unifying definitely didn't use to do this, I don't know whether it's a
problem in upower or the kernel.

"udevadm monitor -k -p" correctly shows the battery switching between
POWER_SUPPLY_ONLINE=3D0 and POWER_SUPPLY_ONLINE=3D1 when turning the device
off. Not sure whether that's what it used to do.

If someone has time, please test with older versions of upower (I would
say go back to 1.90.2 and start bisecting).

>  Either
> this was intentional or a bug. Either way the behavior is consistent=20
> with the existing code and isn't introduced by your changes. I'm just
> not sure what the correct behavior should be. Sorry if this pollutes
> the=20
> discussion, I'm completely new to the LKML.
>=20
> I'm not sure what else I could try, I'll keep your V2 on my system
> and=20
> let you know if any issues pop up.
>=20
> Regards,
> Kate
>=20
> On 7/14/26 2:54 AM, Erik H=C3=A5kansson wrote:
> > Hi,
> >=20
> > Thank you very much for your help.
> >=20
> > Unfortunately I don't have a Windows system easily accessible, so I
> > can't check my firmware version in Options+.
> > fwupdmgr says:
> > > Current version:=C2=A0=C2=A0=C2=A0 MPR05.03_B0020
> > so perhaps that means 5.03.20.
> >=20
> > Let me know if anything pops up if you dig some more,
> > Thanks,
> > Erik
