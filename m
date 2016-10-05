From: Frank Praznik <frank.praznik@gmail.com>
Subject: Re: [PATCH 4/5] HID: sony: Send ds4 output reports on output
 end-point
Date: Wed, 5 Oct 2016 16:35:16 -0400
Message-ID: <740B6F90-3CBB-45F6-AE7A-CA510D397B92@gmail.com>
References: <1475636338-3779-1-git-send-email-roderick@gaikai.com>
 <1475636338-3779-5-git-send-email-roderick@gaikai.com>
 <20161005083150.GB19261@mail.corp.redhat.com>
 <5FB6ED86-613A-449C-8D7C-60FD136075C3@gmail.com>
 <4f8de661a2a8be99ddcb284a89d4422c.squirrel@mungewell.org>
Mime-Version: 1.0 (Mac OS X Mail 10.0 \(3226\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35613 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755195AbcJEUfT (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 5 Oct 2016 16:35:19 -0400
Received: by mail-qk0-f196.google.com with SMTP id j129so13945898qkd.2
        for <linux-input@vger.kernel.org>; Wed, 05 Oct 2016 13:35:19 -0700 (PDT)
In-Reply-To: <4f8de661a2a8be99ddcb284a89d4422c.squirrel@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Wood <simon@mungewell.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Roderick Colenbrander <roderick@gaikai.com>, linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>, Frank Praznik <frank.praznik@oh.rr.com>, Antonio Ospite <ao2@ao2.it>


> On Oct 5, 2016, at 13:35, Simon Wood <simon@mungewell.org> wrote:
>=20
> On Wed, October 5, 2016 10:54 am, Frank Praznik wrote:
>> The best answer I can give is "not to my knowledge=E2=80=9D.  Rumble =
and LEDs
>> have standard kernel interfaces but obviously we can=E2=80=99t =
guarantee 100% that
>> nobody is using hidraw directly.  Commercial games and engines aren't
>> running as root and thus can=E2=80=99t use hidraw so I think we can =
safely say
>> that no major commercial software will be broken by this.
>=20
> There are a couple of projects I know of, but I am unable to say =
whether
> they are still active or whether proposed changes will affect them...
> https://thp.io/2010/psmove/
> http://moveonpc.blogspot.ca/
> https://github.com/chrippa/ds4drv
>=20
> Audio output is one area of the DS4 which is not supported in kernel,
> maybe some renewed interest can get this working.
>=20
> I agree with Frank that we should move forward, if something gets =
broken
> we can work a better solution.
> Simon.
>=20
> acked-by: Simon Wood <simon@mungewell.org>
>=20
>=20
>=20

This change only affects sending rumble/LED output reports to the DS4, =
so hidraw input reports and sending/receiving feature reports will be =
unchanged as will anything not in the DS4 codepath (ie. Move =
controllers).  It looks like ds4drv has both a hidraw backend and one =
which uses raw Bluetooth sockets.  The raw socket backend should be =
unaffected, but the hidraw backend will probably have issues.  It should =
be trivial to patch it to append the CRC to the raw data packet like the =
kernel module does though.  It also looks like hidraw isn=E2=80=99t the =
default Bluetooth backend which reduces the odds that it will be an =
issue even further.

I=E2=80=99m definitely in favor of moving toward more correct behavior =
as long as the ds4drv project is given a warning to start sending CRC-ed =
output reports.

acked-by: Frank Praznik <frank.praznik@gmail.com>=
