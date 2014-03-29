From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [RFC PATCH] HID: Stop hiding options with !EXPERT
Date: Sat, 29 Mar 2014 15:06:44 +0100
Message-ID: <20140329150644.39f9d84c@endymion.delvare>
References: <20140321094636.66fc62f2@endymion.delvare>
	<alpine.LNX.2.00.1403281511120.16202@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:49286 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751646AbaC2OGr (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 29 Mar 2014 10:06:47 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 72DF9AC04
	for <linux-input@vger.kernel.org>; Sat, 29 Mar 2014 14:06:46 +0000 (UTC)
In-Reply-To: <alpine.LNX.2.00.1403281511120.16202@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

Hi Jiri,

On Fri, 28 Mar 2014 15:13:39 -0700 (PDT), Jiri Kosina wrote:
> On Fri, 21 Mar 2014, Jean Delvare wrote:
> 
> > Many HID driver options are hidden unless EXPERT is set. While I
> > understand the idea of simplifying the kernel configuration for most
> > users, in practice I believe it adds more confusion than it helps.
> 
> actually this question has been raised by several people in the past 
> already. Copy/pasting the latest reply I have sent on this topic
> 
> ===
> mostly this is because we don't want to bother users with asking for every
> single quirky device/vendor, as there are unfortunately a lot of them.
> Usually compiling everything in doesn't waste runtime footprint (the
> modules don't get loaded unless needed), and they don't cost too much disk
> space either.

The problem is that the hidden options may end up built-in, not
modular, in which case they are actually wasting runtime footprint, and
polluting /sys/bus/hid/drivers.

> And if you really want to disable them, CONFIG_EMBEDDED allows you to do
> that.

True, but CONFIG_EMBEDDED / CONFIG_EXPERT are tree-wide settings.
Enabling them un-hides a lot more options than just these HID drivers.
Not everyone wants that.

Other subsystems have solved the problem with specific options, which
give the user more flexibility over which areas he/she wants to
fine-tune. See for example CONFIG_I2C_HELPER_AUTO and
CONFIG_MEDIA_SUBDRV_AUTOSELECT. That might be an alternative if you
really think that these drivers entries should be hidden by default (I
don't.)

> Please see last paragraph on
> 
> 	https://lkml.org/lkml/2008/10/14/266
> 
> ===
> 
> i.e. it was explicitly requested by Linus.
> 
> That's the history.

Well, I see that Linus was mostly unhappy because the of the new
warnings introduced by the change. Plus...

> Now, admittedly, it was quite some time ago, and HID world has matured a 
> lot since then, so the 'quirks' turned out into proper drivers. So maybe 
> there indeed might be a good time to try it again.

... these were boolean quirks, and IIRC everything ended up being built
in the same module. So the discussion was relevant back then.

Now we have separate drivers, controlled by tristate options. This is a
completely different situation.

Also, many drivers were added since then. I doubt that hiding 11
drivers, while about 50 are always presented to the user, really helps
easing the configuration, if that was the actual goal.

In fact, looking at the git history, I can see that more drivers used
to depend on CONFIG_EMBEDDED / CONFIG_EXPERT, and these dependencies
were removed over time:

commit 4b186f72033611c2b526c7341534e71ee4afd222
Author: Jiri Kosina <jkosina@suse.cz>
Date:   Wed Dec 23 13:12:32 2009 +0100

    HID: make 3M PCT touchscreen driver standalone config option

commit 92688c0c3c1c9e2daf705d307e8fda1b5a180d26
Author: Jiri Kosina <jkosina@suse.cz>
Date:   Mon Jan 4 12:04:59 2010 +0100

    HID: make Stantum driver standalone config option

commit 2dbf209d7a7ab94266b936bd2da6a4026c279992
Author: Jiri Kosina <jkosina@suse.cz>
Date:   Wed Feb 3 16:11:12 2010 +0100

    HID: make full-fledged hid-bus drivers properly selectable

commit 23d386d85a9144612c4a13733aa1ca6e5a21f4a2
Author: Jiri Kosina <jkosina@suse.cz>
Date:   Mon Mar 22 16:33:15 2010 +0100

    HID: fixup Kconfig entry for Roccat Kone

commit 95736de984dec5b80ea9d6640d4d55ca8ff98db4
Author: Jiri Kosina <jkosina@suse.cz>
Date:   Wed May 12 15:27:00 2010 +0200

    HID: make Prodikeys driver standalone config option

commit 73d5e8f77e88a4d3a154dfdbb4ed2cf461b7bf21
Author: Jiri Kosina <jkosina@suse.cz>
Date:   Fri May 21 13:15:17 2010 +0200

    HID: fix up 'EMBEDDED' mess in Kconfig

commit f36ee074d5d563a832fbfc378207739db3a0a205
Author: Jiri Kosina <jkosina@suse.cz>
Date:   Mon Aug 9 19:56:01 2010 +0200

    HID: uclogic: fix up Kconfig entry

commit dfe9a31211c0a3a0252af6c87935d7ac718aadf9
Author: Jiri Kosina <jkosina@suse.cz>
Date:   Mon Oct 17 17:04:58 2011 +0200

    HID: primax: remove spurious dependency

commit 22ca20b250f5c9672a53b34f032f43dd2c4a4aaf
Author: Nikolai Kondrashov <spbnick@gmail.com>
Date:   Tue Feb 28 13:01:46 2012 +0200

    HID: kye: Add support for 3 tablets

And I may have missed some. So all I am really asking here, is that we
finish a cleanup that already started over 4 years ago.

If this is really only a question of which devices are more likely to
be used by a large number of users, then that's what defaults are for.

Thanks,
-- 
Jean Delvare
SUSE L3 Support
