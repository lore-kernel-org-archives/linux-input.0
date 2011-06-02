From: San Vu Ngoc <san.vu-ngoc@laposte.net>
Subject: Re: [PATCH] Wacom Intuos4 LED and OLED control
Date: Thu, 2 Jun 2011 09:51:03 +0000 (UTC)
Message-ID: <loom.20110602T114644-725@post.gmane.org>
References: <1302303254-3062-1-git-send-email-eduard@hasenleithner.at>  <20110506155204.GA4754@core.coreip.homeip.net>  <4DC421BF.9020204@hasenleithner.at>  <20110506164301.GA27419@core.coreip.homeip.net>  <4DC4309B.9080605@hasenleithner.at>   <BANLkTik2dYnc9tboMdb1KNC_o-YLmMV81w@mail.gmail.com> <1304704667.10308.2.camel@Nokia-N900-42-11>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:37861 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751376Ab1FBLFM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 2 Jun 2011 07:05:12 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glki-linux-input-2@m.gmane.org>)
	id 1QS5i5-0007Fr-9W
	for linux-input@vger.kernel.org; Thu, 02 Jun 2011 13:05:10 +0200
Received: from sud35-2-82-225-106-147.fbx.proxad.net ([82.225.106.147])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Thu, 02 Jun 2011 13:05:05 +0200
Received: from san.vu-ngoc by sud35-2-82-225-106-147.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Thu, 02 Jun 2011 13:05:05 +0200
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Eduard Hasenleithner <eduard <at> hasenleithner.at> writes:

>=20
>=20
> ----- Urspr=C3=BCngliche Mitteilung -----
> > On Fri, May 6, 2011 at 10:32 AM, Eduard Hasenleithner
> > <eduard <at> hasenleithner.at> wrote:
>=20
> > > With Intuos4 wacom also added a touch wheel to the tablet. In the
> > > windows-driver it is possible to control four different "axes" wi=
th the
> > > single touch wheel. In order to know which axis is controlled, th=
ey
> > > could have simply added another four LEDs, with one of them being
> > > "on", giving a total of five leds. But they saved one LED, and pu=
t the
> > > status information to the one LED which shows the current wheel
> > > function "selection".
> >=20
> > I see. Do all 4 leds share the settings for luminance?
>=20
> Yes, Exactly.
>=20
> Eduard.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20

I just wanted to say that I have tested the patch at

https://patchwork.kernel.org/patch/765792/

and (as a simple user) I find it great !
It works perfectly on my kubuntu 11.04
(after I chmod the files in /sys/class/input/input13/led to read-write)

A beginners' question: the device can be accessed by, for instance

/sys/class/input/input13

What is the best way to find out which number it is (here 13) ?

Thanks again for this great patch, for us, Intuos4 users.

San



--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
