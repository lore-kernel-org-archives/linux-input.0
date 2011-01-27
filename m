From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: 2.6.36/2.6.37: broken compatibility with userspace input-utils ?
Date: Thu, 27 Jan 2011 09:21:29 -0800
Message-ID: <20110127172128.GA19672@core.coreip.homeip.net>
References: <4D3F4D11.9040302@teksavvy.com>
 <20110125232914.GA20130@core.coreip.homeip.net>
 <20110126020003.GA23085@core.coreip.homeip.net>
 <4D403855.4050706@teksavvy.com>
 <4D40C3D7.90608@teksavvy.com>
 <4D40C551.4020907@teksavvy.com>
 <20110127021227.GA29709@core.coreip.homeip.net>
 <4D40E41D.2030003@teksavvy.com>
 <20110127063815.GA29924@core.coreip.homeip.net>
 <4D414928.80801@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4D414928.80801@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@redhat.com>
Cc: Mark Lord <kernel@teksavvy.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Jan 27, 2011 at 08:30:00AM -0200, Mauro Carvalho Chehab wrote:
> 
> On my tests here, this is working fine, with Fedora and RHEL 6, on my
> usual test devices, so I don't believe that the tool itself is broken, 
> nor I think that the issue is due to the fix patch.
> 
> I remember that when Kay added a persistence utility tool that opens a V4L
> device in order to read some capabilities, this caused a race condition
> into a number of drivers that use to register the video device too early.
> The result is that udev were opening the device before the end of the
> register process, causing OOPS and other problems.

Well, this is quite possible. The usev ruls in the v4l-utils reads:

ACTION=="add", SUBSYSTEM=="rc", RUN+="/usr/bin/ir-keytable -a /etc/rc_maps.cfg -s $name"

So we act when we add RC device to the system. The corresponding input
device has not been registered yet (and will not be for some time
because before creating input ddevice we invoke request_module() to load
initial rc map module) so the tool runs simultaneously with kernel
registering input device and it could very well be it can't find
something it really wants.

This would explain why Mark sees the segfault only when invoked via
udev but not when ran manually.

However I still do not understand why Mark does not see the same issue
without the patch. Like I said, maybe if Mark could recompile with
debug data and us a core we'd see what is going on.

BTW, that means that we need to redo udev rules. Maybe we should split
the utility into 2 parts - one dealing with rcX device and for keymap
setting reuse udev's existing utility that adjusts maps on ann input
devices, not for RCs only.

-- 
Dmitry
