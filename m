From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: synaptics-rmi4 - make F03 a tristate symbol
Date: Sun, 15 Jan 2017 15:39:30 -0800
Message-ID: <20170115233930.GG23285@dtor-ws>
References: <20170110121718.2992211-1-arnd@arndb.de>
 <20170113062203.GD22630@dtor-ws>
 <3051252.9A92ba0o10@wuerfel>
 <D8CE35BE-2576-4F01-955A-BA118114BF2F@gmail.com>
 <CAK8P3a0gaT+nVuL3OjB0vYkQWb_5LOQjaWZr4DGVGe-PoYFs7Q@mail.gmail.com>
 <20170113214240.GA4246@dtor-ws>
 <CAK8P3a3cTu8CtxGoSBqEerjN-=5ohTH0KUmnrG5nLcJHYu0yiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35361 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751087AbdAOXje (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 15 Jan 2017 18:39:34 -0500
Content-Disposition: inline
In-Reply-To: <CAK8P3a3cTu8CtxGoSBqEerjN-=5ohTH0KUmnrG5nLcJHYu0yiQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christopher Heiny <cheiny@synaptics.com>, Nick Dyer <nick@shmanahar.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Andrew Duggan <aduggan@synaptics.com>

On Sat, Jan 14, 2017 at 01:09:57PM +0100, Arnd Bergmann wrote:
> On Jan 13, 2017 10:42 PM, "Dmitry Torokhov" <dmitry.torokhov@gmail.com> wrote:
> > On Fri, Jan 13, 2017 at 10:34:32PM +0100, Arnd Bergmann wrote:
> > > config RMI4_F03_SERIO
> > >        tristate
> > >        depends on RMI4_CORE
> > >        depends on RMI4_F03
> > >        default RMI4_CORE
> > >        select SERIO
> > >
> > > As that avoids the 'depends on SERIO=y || RMI4_CORE=SERIO' statement that
> > > is different from the other SERIO users, it keeps it all in one place,
> > > and it doesn't
> > > prevent you from seeing the RMI4_F03 symbol when SERIO=m.
> > Hmm, if this works and resilient with user changing symbols after
> > they've been auto-selected then I like it. How can we run it through
> > multitude of randconfigs?
> 
> I've successfully run it over night on a few hundred randconfig builds without
> problems now, so I'm pretty confident it works.
> 
> The hidden option will ensure the configuration is always valid even when
> the user changes it, the only thing that can be unexpected is the same as
> every 'select': when you enable this option, SERIO will get turned on, and
> when you disable it again after leaving 'menuconfig', it stays on.

Great. Could you please send me real patch and I'll get it to Linus?

Thanks.

-- 
Dmitry
