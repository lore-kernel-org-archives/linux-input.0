From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: sysfs change of input/event devices in 2.6.23rc breaks udev
Date: Sat, 15 Sep 2007 10:18:15 -0400
Message-ID: <200709151018.16076.dtor@insightbb.com>
References: <46E2D712.1010402@gmail.com> <d120d5000709100624s4fd7e68djf8654a4d591cbb5d@mail.gmail.com> <20070915010519.34bcb9ae.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070915010519.34bcb9ae.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg KH <gregkh@suse.de>, Kay Sievers <kay.sievers@vrfy.org>, Anssi Hannula <anssi.hannula@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Saturday 15 September 2007 04:05, Andrew Morton wrote:
> On Mon, 10 Sep 2007 09:24:04 -0400 "Dmitry Torokhov" <dmitry.torokhov@gmail.com> wrote:
> 
> > On 9/10/07, Greg KH <gregkh@suse.de> wrote:
> > > On Mon, Sep 10, 2007 at 01:28:47AM -0400, Dmitry Torokhov wrote:
> > > > On Sunday 09 September 2007 19:03, Kay Sievers wrote:
> > > > > On 9/8/07, Anssi Hannula <anssi.hannula@gmail.com> wrote:
> > > > > >
> > > > > > However, the change that broke id_path of udev is that
> > > > > > /sys/class/input/event5/device is now a symlink to the inputX directory
> > > > > > instead of being the same as the device symlink in inputX directory,
> > > > > > i.e. to ../../../devices/platform/pcspkr in this case.
> > > > > >
> > > > > > Udev id_path uses that directory to construct the ID_PATH variable.
> > > > > > Should the sysfs structure be reverted or should udev be adapted to
> > > > > > handle traversing /device symlink twice? I think the former, as there
> > > > > > should be considerably more time to adapt udev for coming changes in sysfs.
> > > > >
> > > > > Udev's path_id script is too dumb to follow the "device" link of
> > > > > stacked class devices in the CONFIG_SYSFS_DEPRECATED=y layout. Does
> > > > > this change fix it for you?
> > > > >   http://git.kernel.org/?p=linux/hotplug/udev.git;a=commitdiff_plain;h=b1ac36ff5e3756cefc79967a26280056da31bf6f
> > > > >
> > > >
> > > > Hmm, fixing udev is good but users will not get the change in time. I think we
> > > > need to adjust SYSFS_DEPRECATED code to produce old results. Something like the
> > > > patch below. I wonder what Greg would think...
> > >
> > > Hm, I don't understand.  Didn't the original conversion of the input
> > > layer by Kay not have this kind of problem?  What did your changes do
> > > differently to cause this driver core change to be needed?
> > >
> > 
> > If I understand it correctly Kay's convesion had the same issue. With
> > class devices "device" link points to class_dev->device instead of
> > class_dev->parent. If you want to keep compatibility with old sysfs
> > layout when moving from class devices to regular devices then you need
> > to "skip" couple of parents till you get to "real" device. This only
> > matters for input because this was the only subsystem with class
> > devices stacked.
> > 
> 
> <wonders where the rest of this thread went to>

Limbo ;)

Anssi, could you please tell me if the patch fixes the issue on your box?

> 
> Did this userspace-visible post-2.6.22 regression get fixed?
> 

I'd like the patch to go through Greg if he is OK with it.

-- 
Dmitry
