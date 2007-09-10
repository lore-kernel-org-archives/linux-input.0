From: Greg KH <gregkh@suse.de>
Subject: Re: sysfs change of input/event devices in 2.6.23rc breaks udev
Date: Sun, 9 Sep 2007 22:44:48 -0700
Message-ID: <20070910054448.GA3515@suse.de>
References: <46E2D712.1010402@gmail.com> <3ae72650709091603o57c976d1q8a1b5492ef041186@mail.gmail.com> <200709100128.48595.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756182AbXIJFl4@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200709100128.48595.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: Kay Sievers <kay.sievers@vrfy.org>, Anssi Hannula <anssi.hannula@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Sep 10, 2007 at 01:28:47AM -0400, Dmitry Torokhov wrote:
> On Sunday 09 September 2007 19:03, Kay Sievers wrote:
> > On 9/8/07, Anssi Hannula <anssi.hannula@gmail.com> wrote:
> > >
> > > However, the change that broke id_path of udev is that
> > > /sys/class/input/event5/device is now a symlink to the inputX directory
> > > instead of being the same as the device symlink in inputX directory,
> > > i.e. to ../../../devices/platform/pcspkr in this case.
> > >
> > > Udev id_path uses that directory to construct the ID_PATH variable.
> > > Should the sysfs structure be reverted or should udev be adapted to
> > > handle traversing /device symlink twice? I think the former, as there
> > > should be considerably more time to adapt udev for coming changes in sysfs.
> > 
> > Udev's path_id script is too dumb to follow the "device" link of
> > stacked class devices in the CONFIG_SYSFS_DEPRECATED=y layout. Does
> > this change fix it for you?
> >   http://git.kernel.org/?p=linux/hotplug/udev.git;a=commitdiff_plain;h=b1ac36ff5e3756cefc79967a26280056da31bf6f
> > 
> 
> Hmm, fixing udev is good but users will not get the change in time. I think we
> need to adjust SYSFS_DEPRECATED code to produce old results. Something like the
> patch below. I wonder what Greg would think...

Hm, I don't understand.  Didn't the original conversion of the input
layer by Kay not have this kind of problem?  What did your changes do
differently to cause this driver core change to be needed?

thanks,

greg k-h
