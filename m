From: =?iso-8859-1?Q?Br=FCns=2C_Stefan?= <Stefan.Bruens@rwth-aachen.de>
Subject: Re: [PATCH v2 3/5] Input: add KEY_ROTATE_LOCK_TOGGLE
Date: Thu, 30 Nov 2017 17:51:37 +0000
Message-ID: <2845999.tyV6EiPLrg@sbruens-linux>
References: <20171109224436.16472-1-stefan.bruens@rwth-aachen.de>
 <8ebdb255-b0b5-4de2-a680-e7f6713256d0@rwthex-w2-a.rwth-ad.de>
 <1510270493.2624.49.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out-2.itc.rwth-aachen.de ([134.130.5.47]:31883 "EHLO
        mail-out-2.itc.rwth-aachen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753360AbdK3Rvl (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 30 Nov 2017 12:51:41 -0500
In-Reply-To: <1510270493.2624.49.camel@hadess.net>
Content-Language: en-US
Content-ID: <D052AFA297317F4E88E9A5837555E68F@rwth-ad.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Freitag, 10. November 2017 00:34:53 CET Bastien Nocera wrote:
> On Thu, 2017-11-09 at 23:44 +0100, Stefan Brüns wrote:
> > The key has the same use as the SW_ROTATE_LOCK, but is used on
> > devices
> > where the state is not tracked by the hardware but has to be handled
> > in software.
> 
> I'll let the input and hid subsystem maintainers have the final say
> here, though I think that sending out Win+O would be easier, as this is
> already something that desktops need to support for those devices that
> send the actual Win+O key combination when those buttons are pressed
> there.
> 
> If we're going with the separate keycode, could you also file bugs
> against xkbd-common and xkeyboard-config to get the key added to the
> list of XF86 keysyms and to the default evdev keymap? Otherwise Wayland
> and X11 based desktops won't be able to use it.

Filed for xkeyboard-config:
https://bugs.freedesktop.org/show_bug.cgi?id=103998

and xkb-common:
https://github.com/xkbcommon/libxkbcommon/issues/55

Regards,

Stefan
