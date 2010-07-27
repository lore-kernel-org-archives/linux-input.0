From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Problem: PS/2 keyboard dead at login
Date: Tue, 27 Jul 2010 01:14:54 -0700
Message-ID: <20100727081454.GA32084@core.coreip.homeip.net>
References: <201007270151.44236.joerg.schaible@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:56150 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753981Ab0G0IPA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Jul 2010 04:15:00 -0400
Received: by pzk26 with SMTP id 26so1266914pzk.19
        for <linux-input@vger.kernel.org>; Tue, 27 Jul 2010 01:14:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201007270151.44236.joerg.schaible@gmx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?J=F6rg?= Schaible <joerg.schaible@gmx.de>
Cc: linux-input@vger.kernel.org

Hi J=F6rg,

On Tue, Jul 27, 2010 at 01:51:44AM +0200, J=F6rg Schaible wrote:
> Hello,
>=20
> I am following the procedure of REPORTING-BUGS:
>=20
> 1/ Problem: PS/2 keyboard dead at login
>=20
> 2/ Description: Computer with a USB mouse and a PS/2 Microsoft Natura=
l=20
> Keyboard. The keyboard works fine in the grub bootmenu. However, at t=
he login=20
> prompt in the console (no X), the keyboard is dead. Plugging the keyb=
oard=20
> cable off and on resolves the problem, the keyboard is then initializ=
ed=20
> (according dmesg).
>=20

Could you please boot with i8042.debug kernel option and send me full
dmesg?

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
