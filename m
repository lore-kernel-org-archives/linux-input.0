From: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH v4 7/9] ARM: sun7i/sun4i: dt: Add AXP209
 support to various boards
Date: Thu, 24 Apr 2014 17:58:47 +0100
Message-ID: <20140424165847.GC25663@opensource.wolfsonmicro.com>
References: <1397209093-10077-8-git-send-email-carlo@caione.org> <20140411122901.GE28800@sirena.org.uk> <CAOQ7t2Y2B7f+eZApDHKiKm9=bOXo6oUA2RLY7ENn7qPLQEboMA@mail.gmail.com> <20140411161813.GF28800@sirena.org.uk> <CAOQ7t2YO_MjUZkkoEe1Grft+fVttWoOro85Sru2P3LXbx8Kjbg@mail.gmail.com> <20140418151551.GZ12304@sirena.org.uk> <20140423202546.GA3890@nuc.fastwebnet.it> <20140424133036.GY12304@sirena.org.uk> <20140424163523.GB25663@opensource.wolfsonmicro.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBC5NTO4QW4NBBSMF4WNAKGQEMDZ2NDI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140424163523.GB25663-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Thu, Apr 24, 2014 at 05:35:23PM +0100, Charles Keepax wrote:
> On Thu, Apr 24, 2014 at 02:30:36PM +0100, Mark Brown wrote:
> > On Wed, Apr 23, 2014 at 10:25:46PM +0200, Carlo Caione wrote:
> > 
> > > I'm having a really hard time with this problem, so any hint is welcome
> > > :) The small modification I'm using on top of the patches in this series
> > > is here: http://bpaste.net/show/228330/
> > 
> > > Unfortunately as I said I got this when booting:
> > > http://bpaste.net/show/nUhUTzELT32v9HNPathL/
> > 
> > Huh, actually the arizona drivers do show this (it was being masked in
> > my logs by another unrelated bug).  I guess the Wolfson guys aren't
> > working with upstream much (though Charles did write the orignal code
> > here...).
> 
> I run upstream fairly regularly here (although mostly on Arndale
> rather than Speyside). On closer inspection of my kernel log
> don't seem to have anything related to it, which is odd.

Ah ok seems I am getting an error but for some reason for me it
shows up looking very unrelated to the supply mapping. In that it
shows up much later in the log and doesn't seem to mention the
MFD at all:

[    2.938985] ------------[ cut here ]------------
[    2.942216] WARNING: CPU: 0 PID: 1 at drivers/base/dd.c:272 driver_probe_device+0x127/0x184()
[    2.950680] Modules linked in:
[    2.953677] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.15.0-rc2+ #636
[    2.960246] [<80011ab9>] (unwind_backtrace) from [<8000f461>] (show_stack+0x11/0x14)
[    2.967972] [<8000f461>] (show_stack) from [<804c3bab>] (dump_stack+0x53/0x68)
[    2.975171] [<804c3bab>] (dump_stack) from [<8001bc55>] (warn_slowpath_common+0x51/0x70)
[    2.983239] [<8001bc55>] (warn_slowpath_common) from [<8001bc8b>] (warn_slowpath_null+0x17/0x1c)
[    2.992009] [<8001bc8b>] (warn_slowpath_null) from [<802c040f>] (driver_probe_device+0x127/0x184)
[    3.000864] [<802c040f>] (driver_probe_device) from [<802c04bd>] (__driver_attach+0x51/0x54)
[    3.009278] [<802c04bd>] (__driver_attach) from [<802bf2fd>] (bus_for_each_dev+0x2d/0x4c)
[    3.017437] [<802bf2fd>] (bus_for_each_dev) from [<802bfde7>] (bus_add_driver+0x8f/0x130)
[    3.025603] [<802bfde7>] (bus_add_driver) from [<802c08b7>] (driver_register+0x3b/0x88)
[    3.033540] [<802c08b7>] (driver_register) from [<800087df>] (do_one_initcall+0xa7/0xe8)
[    3.041618] [<800087df>] (do_one_initcall) from [<8097d9e7>] (kernel_init_freeable+0xb7/0x14c)
[    3.050219] [<8097d9e7>] (kernel_init_freeable) from [<804bec2b>] (kernel_init+0xf/0xa4)
[    3.058286] [<804bec2b>] (kernel_init) from [<8000cebd>] (ret_from_fork+0x11/0x20)
[    3.065835] ---[ end trace f838bbad8b4018a1 ]---

The fix looks pretty trivial though, hopefully get it out
tonight/tomorrow morning.

Thanks,
Charles
