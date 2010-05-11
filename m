From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] iforce: Fix Gullemot Jet Leader 3D entry
Date: Tue, 11 May 2010 09:54:21 -0700
Message-ID: <20100511165421.GD7396@core.coreip.homeip.net>
References: <1273181641-24546-1-git-send-email-marek.vasut@gmail.com>
 <1273181641-24546-2-git-send-email-marek.vasut@gmail.com>
 <20100511055319.GB5064@core.coreip.homeip.net>
 <1273571265.2308.1454.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f204.google.com ([209.85.222.204]:45300 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755700Ab0EKQye (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 May 2010 12:54:34 -0400
Received: by pzk42 with SMTP id 42so847536pzk.4
        for <linux-input@vger.kernel.org>; Tue, 11 May 2010 09:54:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1273571265.2308.1454.camel@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Marek Vasut <marek.vasut@gmail.com>, linux-input@vger.kernel.org

On Tue, May 11, 2010 at 10:47:45AM +0100, Bastien Nocera wrote:
> On Mon, 2010-05-10 at 22:53 -0700, Dmitry Torokhov wrote:
> > On Thu, May 06, 2010 at 11:34:01PM +0200, Marek Vasut wrote:
> > > USB ID entry for "Gullemot Jet Leader 3D" wasn't the same in ifor=
ce-main.c and
> > > iforce-usb.c . Fix this.
> > >=20
> > > Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> >=20
> > Applied both (changed Gullemont to Guillemont though). Thank you Ma=
rek.
>=20
> Huh, =E2=80=9CGuillemot=E2=80=9D:
> http://www.joy-stick.net/reviews/joysticks/jetlead.htm

Right, thankfully the patch is correct, just my e-mail was messed up:

        { 0x06f8, 0x0001, "Guillemot Race Leader Force Feedback",
btn_wheel, abs_wheel, ff_iforce, true }, //?
        { 0x06f8, 0x0001, "Guillemot Jet Leader Force Feedback",
btn_joystick, abs_joystick_rudder, ff_iforce, true },
        { 0x06f8, 0x0004, "Guillemot Force Feedback Racing Wheel",
btn_wheel, abs_wheel, ff_iforce, true }, //?
        { 0x06f8, 0xa302, "Guillemot Jet Leader 3D",
btn_joystick, abs_joystick, ff_iforce, true }, //?

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
