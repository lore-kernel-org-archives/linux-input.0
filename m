From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 2/2] input/joystick: new Blackfin
	rotary input driver
Date: Thu, 23 Jul 2009 02:46:11 -0400
Message-ID: <8bd0f97a0907222346x7e80799fkf88c7b59c61091b7@mail.gmail.com>
References: <1247592827-16878-1-git-send-email-vapier@gentoo.org>
	<1247592827-16878-2-git-send-email-vapier@gentoo.org> <20090723044338.GB2782@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f213.google.com ([209.85.217.213]:62264 "EHLO
	mail-gx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753050AbZGWGqb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jul 2009 02:46:31 -0400
Received: by gxk9 with SMTP id 9so1354988gxk.13
        for <linux-input@vger.kernel.org>; Wed, 22 Jul 2009 23:46:31 -0700 (PDT)
In-Reply-To: <20090723044338.GB2782@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, Michael Hennerich <michael.hennerich@analog.com>, linux-input@vger.kernel.org

On Thu, Jul 23, 2009 at 00:43, Dmitry Torokhov wrote:
> On Tue, Jul 14, 2009 at 01:33:47PM -0400, Mike Frysinger wrote:
>> +struct platform_driver bfin_rotary_device_driver =3D {
>> + =C2=A0 =C2=A0 .probe =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D bfin_ro=
tary_probe,
>> + =C2=A0 =C2=A0 .remove =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D __devexit_p(=
bfin_rotary_remove),
>> + =C2=A0 =C2=A0 .suspend =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D bfin_rotary_=
suspend,
>> + =C2=A0 =C2=A0 .resume =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D bfin_rotary_=
resume,
>
> Need to use dev_pm_ops so platform code won;t yell at us.

looks like something new post 2.6.30 ... guess i'll have to keep this
in mind for migrating drivers when 2.6.31 comes out

> I also think that this driver should too live in drivers/input/misc s=
o I
> moved it there. I did a bit of reshuffling in the patch, could you
> please give it a try and if it still works I'll apply to the 'next'
> branch.

could you toss like a standard dev_info("initialized") into the end of
bfin_rotary_probe ?  otherwise, builds and works fine for me with
2.6.31-rc4.  thanks!
-mike
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
