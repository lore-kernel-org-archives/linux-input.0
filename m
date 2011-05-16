From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC PATCH] input: Add wiichuck driver
Date: Mon, 16 May 2011 15:01:49 -0600
Message-ID: <BANLkTikKPZwYWeMGsU+F0TJGa+1TCbp84g@mail.gmail.com>
References: <20110512042218.12859.66600.stgit@localhost6.localdomain6>
 <20110516164427.GA21232@core.coreip.homeip.net> <20110516183124.GA4875@ponder.secretlab.ca>
 <20110516194401.GB18110@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42795 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179Ab1EPVCJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 May 2011 17:02:09 -0400
In-Reply-To: <20110516194401.GB18110@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Mon, May 16, 2011 at 1:44 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Mon, May 16, 2011 at 12:31:24PM -0600, Grant Likely wrote:
>> > > + struct i2c_msg data_msg =3D
>> > > + =A0 =A0 =A0 =A0 { .addr =3D i2c->addr, .flags =3D I2C_M_RD, .l=
en =3D 6, .buf =3D b };
>> > > + int jx, jy, ax, ay, az;
>> > > + bool c, z;
>> > > +
>> > > + switch (wiichuck->state) {
>> > > + case 0:
>> > > + =A0 =A0 =A0 =A0 i2c_transfer(i2c->adapter, &cmd_msg, 1);
>> > > + =A0 =A0 =A0 =A0 wiichuck->state =3D 1;
>> >
>> > Do you really need to have a state machine here? Why not do both
>> > transfers in one poll invocation?
>>
>> Mostly because there needs to a gap between setting up the data
>> capture and reading the data back.
>
> How long is the gap? You should be able simply sleep in the poll().

50ms (from what information I've been able to gleen; it might be
faster).  Since I'm already polling the controller at 100ms, a 50ms
sleep in the poll routine would pretty much completely consume the
workqueue if 2 or more wii extension devices were attached to the
system.  Voluntarily giving it up is the right thing to do.

That said, the problem is moot since I've modified the read state to
setup the next transfer immediately after reading the data.  :-)

Revised patch posted shortly...

g.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
