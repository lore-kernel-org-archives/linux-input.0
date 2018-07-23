From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 05/11] touchscreen: elants: Use octal permissions
Date: Mon, 23 Jul 2018 11:24:12 -0700
Message-ID: <20180723182412.GA2964@roeck-us.net>
References: <20180723131954.30739-1-harshitjain6751@gmail.com>
 <20180723131954.30739-4-harshitjain6751@gmail.com>
 <20180723133200.GA1167@kroah.com>
 <20180723171831.GC100814@dtor-ws>
 <e257bc89eb082e9fdc342d6f794c15a2805c98a9.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e257bc89eb082e9fdc342d6f794c15a2805c98a9.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dev-harsh1998 <harshitjain6751@gmail.com>, trivial@kernel.org, Simon Budig <simon.budig@kernelconcepts.de>, Andi Shyti <andi@etezian.org>, Luca Ceresoli <luca@lucaceresoli.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Jul 23, 2018 at 10:25:10AM -0700, Joe Perches wrote:
> On Mon, 2018-07-23 at 10:18 -0700, Dmitry Torokhov wrote:
> > On Mon, Jul 23, 2018 at 03:32:00PM +0200, Greg Kroah-Hartman wrote:
> > > On Mon, Jul 23, 2018 at 06:49:20PM +0530, dev-harsh1998 wrote:
> > > > WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
> > > > +static DEVICE_ATTR(iap_mode, S_IRUGO, show_iap_mode, NULL);
> > > > 
> > > > WARNING: Symbolic permissions 'S_IWUSR' are not preferred. Consider using octal permissions '0200'.
> > > > +static DEVICE_ATTR(update_fw, S_IWUSR, NULL, write_update_fw)
> > > > 
> > > > WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
> > > > +		.dattr = __ATTR(_field, S_IRUGO,			\
> > > > 
> > > > Signed-off-by: Harshit Jain <harshitjain6751@gmail.com>
> > > 
> > > This name doesn't match up with the From: line above :(
> > > 
> > > Please fix up and try again.
> > 
> > dtor@dtor-ws:~/kernel/linux-next$ git grep S_IRU | wc -l
> > 7605
> > 
> > We either need to run a tree-wide script or leave this alone. FWIW I am
> > perfectly fine with either octals or symbolic names so I do not see
> > benefit of doing conversion for code that is not known to be broken.
> 
> About half of those are in one subsystem (drivers/hwmon)
> 
> $ git grep -w S_IRUGO | cut -f1,2 -d'/' | \
>   sort | uniq -c | sort -rn | head -10 | cat -n
>      1	   3846 drivers/hwmon
>      2	    748 drivers/scsi
>      3	    215 drivers/infiniband
>      4	    168 drivers/usb
>      5	    109 drivers/media
>      6	    106 drivers/input
>      7	    102 drivers/platform
>      8	    101 drivers/misc
>      9	    101 drivers/gpu
>     10	     91 drivers/edac
> 
> The generic reason is octal is readable and S_<FOO> is unintelligible.
> 
> https://lkml.org/lkml/2016/8/2/1945
> 

That is Linus' opinion, but not mine. Granted, my opinion doesn't count
much, but enough that I won't waste my time updating the hwmon subsystem
to match the new rules. Rules change all the time, and I am quite sure
checkpatch will find a lot of stuff to complain about (again) in the
hwmon subsystem, after my last spout of cleanup a couple of years ago.
There are much more urgent issues to fix there (such as, for example,
converting the "offending" drivers to the latest API, which would
magically cause most of the offenders to disappear).
No one but me cares about those, so bothering about the use of S_<FOO>
in hwmon seems to be quite pointless. Except, of course, it is quite
useful to have something to point to as bad citizen.

Guenter
