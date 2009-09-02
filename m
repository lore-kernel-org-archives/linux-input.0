From: "Song, Barry" <Barry.Song@analog.com>
Subject: RE: [Uclinux-dist-devel] [PATCH 1/2] add ad714x platform_datadefinition
Date: Wed, 2 Sep 2009 13:24:33 +0800
Message-ID: <0F1B54C89D5F954D8535DB252AF412FA04A96A80@chinexm1.ad.analog.com>
References: <1251777330-16994-1-git-send-email-21cnbao@gmail.com> <200909011857.37755.david-b@pacbell.net> <0F1B54C89D5F954D8535DB252AF412FA04A96A41@chinexm1.ad.analog.com> <200909012214.27637.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail11.analog.com ([137.71.25.57]:62777 "EHLO
	nwd2mail11.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113AbZIBFYg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Sep 2009 01:24:36 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <200909012214.27637.david-b@pacbell.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Barry Song <21cnbao@gmail.com>, dbrownell@users.sourceforge.net, dtor@mail.ru, dmitry.torokhov@gmail.com, spi-devel-general@lists.sourceforge.net, linux-input@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org

=20

>-----Original Message-----
>From: David Brownell [mailto:david-b@pacbell.net]=20
>Sent: Wednesday, September 02, 2009 1:14 PM
>To: Song, Barry
>Cc: Barry Song; dbrownell@users.sourceforge.net; dtor@mail.ru;=20
>dmitry.torokhov@gmail.com;=20
>spi-devel-general@lists.sourceforge.net;=20
>linux-input@vger.kernel.org; uclinux-dist-devel@blackfin.uclinux.org
>Subject: Re: [Uclinux-dist-devel] [PATCH 1/2] add ad714x=20
>platform_datadefinition
>
>On Tuesday 01 September 2009, Song, Barry wrote:
>> >Doesn't belong under SPI since this is also used by the
>> >I2C version of the chip. =A0Likely include/linux/input/*h
>> >is best.
>>=20
>> I really wanted to place it to include/linux/input, but the
>> include/linux/input doesn't exist and current input header files are
>> placed in the parent dir "include/linux".
>>=20
>
>$ ls include/linux/input
>matrix_keypad.h
Thanks. A sync issue. A recent commit adds this file.

author	Eric Miao <eric.y.miao@gmail.com>
	Mon, 29 Jun 2009 07:20:52 +0000 (00:20 -0700)
committer	Dmitry Torokhov <dmitry.torokhov@gmail.com>
	Mon, 29 Jun 2009 07:30:16 +0000 (00:30 -0700)
commit	bab7614d6d1b1fc96ec6c5a7ca34c8641060e659
tree	f7b493a73b03d39e982a325117a14a04b712d1c0=09
parent	cb589529f74d69abc111887b45308f333f950ade

>$=20
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
