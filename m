From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Input: synaptics-rmi4 - make F03 a tristate symbol
Date: Sat, 14 Jan 2017 13:09:57 +0100
Message-ID: <CAK8P3a3cTu8CtxGoSBqEerjN-=5ohTH0KUmnrG5nLcJHYu0yiQ@mail.gmail.com>
References: <20170110121718.2992211-1-arnd@arndb.de> <20170113062203.GD22630@dtor-ws>
 <3051252.9A92ba0o10@wuerfel> <D8CE35BE-2576-4F01-955A-BA118114BF2F@gmail.com>
 <CAK8P3a0gaT+nVuL3OjB0vYkQWb_5LOQjaWZr4DGVGe-PoYFs7Q@mail.gmail.com> <20170113214240.GA4246@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33636 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751919AbdANMRL (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 14 Jan 2017 07:17:11 -0500
In-Reply-To: <20170113214240.GA4246@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Christopher Heiny <cheiny@synaptics.com>, Nick Dyer <nick@shmanahar.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Andrew Duggan <aduggan@synaptics.com>

On Jan 13, 2017 10:42 PM, "Dmitry Torokhov" <dmitry.torokhov@gmail.com> wrote:
> On Fri, Jan 13, 2017 at 10:34:32PM +0100, Arnd Bergmann wrote:
> > config RMI4_F03_SERIO
> >        tristate
> >        depends on RMI4_CORE
> >        depends on RMI4_F03
> >        default RMI4_CORE
> >        select SERIO
> >
> > As that avoids the 'depends on SERIO=y || RMI4_CORE=SERIO' statement that
> > is different from the other SERIO users, it keeps it all in one place,
> > and it doesn't
> > prevent you from seeing the RMI4_F03 symbol when SERIO=m.
> Hmm, if this works and resilient with user changing symbols after
> they've been auto-selected then I like it. How can we run it through
> multitude of randconfigs?

I've successfully run it over night on a few hundred randconfig builds without
problems now, so I'm pretty confident it works.

The hidden option will ensure the configuration is always valid even when
the user changes it, the only thing that can be unexpected is the same as
every 'select': when you enable this option, SERIO will get turned on, and
when you disable it again after leaving 'menuconfig', it stays on.

    Arnd
