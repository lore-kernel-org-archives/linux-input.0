From: =?UTF-8?B?SsO2cmc=?= Schaible <joerg.schaible@gmx.de>
Subject: Re: Problem: PS/2 keyboard dead at login
Date: Fri, 06 Aug 2010 22:36:54 +0200
Message-ID: <i3hrp6$lcs$1@dough.gmane.org>
References: <201007270151.44236.joerg.schaible@gmx.de> <20100727081454.GA32084@core.coreip.homeip.net> <i2skut$d73$2@dough.gmane.org>
Reply-To: joerg.schaible@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:55501 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761742Ab0HFUhM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 6 Aug 2010 16:37:12 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glki-linux-input-2@m.gmane.org>)
	id 1OhTfA-0004QC-Al
	for linux-input@vger.kernel.org; Fri, 06 Aug 2010 22:37:08 +0200
Received: from hsi-kbw-091-089-184-136.hsi2.kabel-badenwuerttemberg.de ([91.89.184.136])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Fri, 06 Aug 2010 22:37:08 +0200
Received: from joerg.schaible by hsi-kbw-091-089-184-136.hsi2.kabel-badenwuerttemberg.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Fri, 06 Aug 2010 22:37:08 +0200
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

J=C3=B6rg Schaible wrote:

> Hi Dimtry,
>=20
> Dmitry Torokhov wrote:
>=20
>> Hi J=C3=B6rg,
>>=20
>> On Tue, Jul 27, 2010 at 01:51:44AM +0200, J=C3=B6rg Schaible wrote:
>>> Hello,
>>>=20
>>> I am following the procedure of REPORTING-BUGS:
>>>=20
>>> 1/ Problem: PS/2 keyboard dead at login
>>>=20
>>> 2/ Description: Computer with a USB mouse and a PS/2 Microsoft Natu=
ral
>>> Keyboard. The keyboard works fine in the grub bootmenu. However, at=
 the
>>> login prompt in the console (no X), the keyboard is dead. Plugging =
the
>>> keyboard cable off and on resolves the problem, the keyboard is the=
n
>>> initialized (according dmesg).
>>>=20
>>=20
>> Could you please boot with i8042.debug kernel option and send me ful=
l
>> dmesg?
>=20
> Thanks for taking your time. Attached dmesg was sent with privat emai=
l.

Just to report back: 2.6.35 works fine now. Thanks!

- J=C3=B6rg

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
