From: Eduard Hasenleithner <eduard@hasenleithner.at>
Subject: Re: [PATCH] Wacom Intuos4 LED and OLED control
Date: Fri, 06 May 2011 19:57:47 +0200
Message-ID: <1304704667.10308.2.camel@Nokia-N900-42-11>
References: <1302303254-3062-1-git-send-email-eduard@hasenleithner.at>
	 <20110506155204.GA4754@core.coreip.homeip.net>
	 <4DC421BF.9020204@hasenleithner.at>
	 <20110506164301.GA27419@core.coreip.homeip.net>
	 <4DC4309B.9080605@hasenleithner.at>
	  <BANLkTik2dYnc9tboMdb1KNC_o-YLmMV81w@mail.gmail.com>
Reply-To: Eduard Hasenleithner <eduard@hasenleithner.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from plasma.hasenleithner.at ([88.198.35.74]:54026 "EHLO
	plasma.hasenleithner.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753305Ab1EFRzp (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 May 2011 13:55:45 -0400
In-Reply-To: <BANLkTik2dYnc9tboMdb1KNC_o-YLmMV81w@mail.gmail.com>
Content-ID: <1304704666.10308.1.camel@Nokia-N900-42-11>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org


----- Urspr=C3=BCngliche Mitteilung -----
> On Fri, May 6, 2011 at 10:32 AM, Eduard Hasenleithner
> <eduard@hasenleithner.at> wrote:

> > With Intuos4 wacom also added a touch wheel to the tablet. In the
> > windows-driver it is possible to control four different "axes" with=
 the
> > single touch wheel. In order to know which axis is controlled, they
> > could have simply added another four LEDs, with one of them being
> > "on", giving a total of five leds. But they saved one LED, and put =
the
> > status information to the one LED which shows the current wheel
> > function "selection".
>=20
> I see. Do all 4 leds share the settings for luminance?

Yes, Exactly.

Eduard.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
