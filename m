From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: synaptics-rmi4 - make F03 a tristate symbol
Date: Fri, 13 Jan 2017 13:42:40 -0800
Message-ID: <20170113214240.GA4246@dtor-ws>
References: <20170110121718.2992211-1-arnd@arndb.de>
 <20170113062203.GD22630@dtor-ws>
 <3051252.9A92ba0o10@wuerfel>
 <D8CE35BE-2576-4F01-955A-BA118114BF2F@gmail.com>
 <CAK8P3a0gaT+nVuL3OjB0vYkQWb_5LOQjaWZr4DGVGe-PoYFs7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33546 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751242AbdAMVnq (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 13 Jan 2017 16:43:46 -0500
Content-Disposition: inline
In-Reply-To: <CAK8P3a0gaT+nVuL3OjB0vYkQWb_5LOQjaWZr4DGVGe-PoYFs7Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, Nick Dyer <nick@shmanahar.org>, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, Jan 13, 2017 at 10:34:32PM +0100, Arnd Bergmann wrote:
> On Fri, Jan 13, 2017 at 10:15 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> >>This is my fixup, though I'm not too happy with that version.
> >>
> >>Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >>
> >>diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> >>index 1aeb80e52424..3927259a5d5d 100644
> >>--- a/drivers/hid/Kconfig
> >>+++ b/drivers/hid/Kconfig
> >>@@ -785,7 +785,8 @@ config HID_SUNPLUS
> >> config HID_RMI
> >>       tristate "Synaptics RMI4 device support"
> >>       depends on HID
> >>-      select RMI4_CORE
> >>+      depends on SERIO && RMI4_CORE
> >>+      depends on SERIO=y || RMI4_CORE=SERIO
> >
> > Shouldn't this be simply
> >
> > select SERIO # needed for F03
> 
> Ah, I guess this would work too. I didn't consider it because SERIO is
> a user-visible symbol and we generally try not to 'select' them but instead
> use 'depends on.
> 
> However, SERIO is already used with 'select' all over the place, so adding
> another select is actually safer than adding a dependency (which could
> cause dependency loops here).
> 
> Actually the best solution is probably to have 'select SERIO' in RMI4, like
> 
> config RMI4_F03_SERIO
>        tristate
>        depends on RMI4_CORE
>        depends on RMI4_F03
>        default RMI4_CORE
>        select SERIO
> 
> As that avoids the 'depends on SERIO=y || RMI4_CORE=SERIO' statement that
> is different from the other SERIO users, it keeps it all in one place,
> and it doesn't
> prevent you from seeing the RMI4_F03 symbol when SERIO=m.

Hmm, if this works and resilient with user changing symbols after
they've been auto-selected then I like it. How can we run it through
multitude of randconfigs?

Thanks.

-- 
Dmitry
