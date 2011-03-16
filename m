From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: The way for disabling input device?
Date: Wed, 16 Mar 2011 00:22:54 -0700
Message-ID: <20110316072250.GA25912@core.coreip.homeip.net>
References: <4D7F2C12.5020509@samsung.com>
 <20110316045551.GB2582@core.coreip.homeip.net>
 <4D8062E3.30305@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54508 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752097Ab1CPHW7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Mar 2011 03:22:59 -0400
Received: by iwn34 with SMTP id 34so1382611iwn.19
        for <linux-input@vger.kernel.org>; Wed, 16 Mar 2011 00:22:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4D8062E3.30305@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: linux-input@vger.kernel.org

On Wed, Mar 16, 2011 at 04:12:35PM +0900, Joonyoung Shim wrote:
> On 2011-03-16 =EC=98=A4=ED=9B=84 1:55, Dmitry Torokhov wrote:
> >On Tue, Mar 15, 2011 at 06:06:26PM +0900, Joonyoung Shim wrote:
> >>Hi, all.
> >>
> >>The many smartphones and embedded devices have LCD panel with
> >>touchscreen. The LCD panel is turned off for power saving and
> >>touchscreen also is disabled if there isn't user input for a while =
or if
> >>user presses power key briefly. This state is such idle, not suspen=
d.
> >>
> >>The framebuffer device driver of kernel supplies sysfs interface to
> >>control blanking level of framebuffer and  we can turn off LCD pane=
l
> >>using this sysfs at the above case.
> >>
> >>Currently i know there isn't the generic way for disabling input de=
vice
> >>via user interface, so i am looking for the way for disabling
> >>input device on kernel side for above case.
> >>
> >>The above case has a condition which the touchscreen is disabled if=
 LCD
> >>panel is turned off. The framebuffer framework of kernel has notifi=
er
> >>block to callback on events like hardware display blank change occu=
red,
> >>so the callback function disabling and enabling input device can be
> >>called using notifier block of framebuffer. The callback function i=
s
> >>implemented in each touchscreen driver or can be implemented though
> >>input core if this can be generic way for input device.
> >>
> >>Actually i wonder whether this approach makes sense. I know this is=
 a
> >>specific case but certainly necessary function in the smartphone an=
d
> >>embedded devices.
> >
> >I do not believe that we should tie the 2 together. I can come up wi=
th
> >scenarios where you woudl want to put the keeboard/touchcsreen to sl=
eep
> >before turning off the display and vice versa.
>=20
> Right, as you say, various scenarios can come up, so i think generic
> way for disabling input device needs more and more.

Not only input, other devices need this facility as well.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
