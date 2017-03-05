From: Paul Donohue <linux-kernel@paulsd.com>
Subject: Re: [REGRESSION][v4.9.y][v4.10.y] Input: ALPS - set DualPoint flag
 for 74 03 28 devices
Date: Sun, 5 Mar 2017 12:56:19 -0500
Message-ID: <20170305175619.GJ4609@TopQuark.net>
References: <78be095c-a7ae-328d-dd0a-b8470dfc1318@canonical.com>
 <20170304161509.GI4609@TopQuark.net>
 <CAM67p+6UpxCNd23rkajZZL7Oyk1c658BEzLOXpABA0etE-A_tA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAM67p+6UpxCNd23rkajZZL7Oyk1c658BEzLOXpABA0etE-A_tA@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Nick Fletcher <nick.m.fletcher@gmail.com>, Masaki Ota <masaki.ota@jp.alps.com>
Cc: Joseph Salisbury <joseph.salisbury@canonical.com>, ben@smart-cactus.org, mhocko@suse.com, dmitry.torokhov@gmail.com, pali.rohar@gmail.com, rydberg@bitmath.org, linux@roeck-us.net, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Masaki: Do you have any information about this touchpad you can share?  Is the third byte in EC relevant to the protocol and something we should look for when identifying devices in the driver?

Nick:

Unfortunately, I didn't print quite enough information in the two-finger message, but yeah, this kinda looks like a different protocol.

I've attached two tarballs this time:
1) alps_2a.tar.gz prints some additional info in the two-finger message which may help figure out what protocol your device is speaking:
sudo -s
dkms remove alps_ss5/1.0 --all
cd /usr/src/
rm -rf alps_ss5-1.0
tar -xvzf alps_2a.tar.gz
dkms install alps_ss5/1.0
modprobe -r psmouse ; modprobe psmouse
# Try two-finger scrolling, then run:
dmesg | grep 'two-finger'

2) alps_2b.tar.gz disables the driver unless the third byte in EC is 0x13 (the value my device uses) ... This driver should make your mouse work properly:
sudo -s
dkms remove alps_ss5/1.0 --all
cd /usr/src/
rm -rf alps_ss5-1.0
tar -xvzf alps_2b.tar.gz
dkms install alps_ss5/1.0
modprobe -r psmouse ; modprobe psmouse

Try those out and let's see where that gets us.

When you are done testing, you can revert back to whatever driver came with your kernel by running:
sudo -s
dkms remove alps_ss5/1.0 --all
modprobe -r psmouse ; modprobe psmouse

-Paul

On Sun, Mar 05, 2017 at 09:09:01AM +0000, Nick Fletcher wrote:
> Hi All,
> 
> My touchpad has the physical buttons above the touchpad.
> 
> I have cut and pasted the the results of the two dmesg commands below.  The
> trackpad of course stopped working correctly again after installing
> alps_ss5-1.0.
> 
> I'm afraid any experimenting with the code myself may be beyond my ability.
> :-(
> 
> root@brassneck-test:/usr/src# modprobe -r psmouse ; modprobe psmouse
> root@brassneck-test:/usr/src# dmesg | grep 'ALPS ID'
> [  239.983818] psmouse serio1: alps: ALPS ID: E7=73 03 28, EC=73 01 14
> [  240.433532] psmouse serio1: alps: ALPS ID: E7=73 03 28, EC=73 01 14
> root@brassneck-test:/usr/src# dmesg | grep two-finger
> [  279.294490] psmouse serio1: alps: ALPS two-finger packet w/ button
> (buttonpad: 0): d9 73 24
> 
> 
> Thank you for your help in this and thank you to Joseph for building all
> the test kernels whilst attempting to find out which commit first caused my
> issue.
> 
> Cheers,
> Nick.
> 
> On 4 March 2017 at 16:15, Paul Donohue <linux-kernel@paulsd.com> wrote:
> 
> > I have a 74 03 28 device on a Dell Precision laptop that handles
> > two-finger scrolling fine.  Without this patch, my mouse functions only as
> > a dumb PS/2 mouse, which means I lose all multi-touch and scrolling
> > capabilities entirely.  So I would rather not see this reverted. :)
> >
> > I suspect one of two things:
> > 1) My device has physical buttons below the touchpad.  There are some
> > different code paths for devices without physical buttons below the
> > touchpad.  Perhaps there is a bug in those alternate code paths?  Does the
> > buggy device have physical buttons?
> > 2) Perhaps this is a new ALPS variant which speaks a new protocol that is
> > not currently handled by the driver but which isn't properly
> > identified/differentiated by the alps_identify() function?
> >
> > To get some additional data, grab the attached tarball, then:
> > sudo -s
> > cd /usr/src/
> > tar -xvzf alps_1.tar.gz
> > apt install dkms
> > dkms install alps_ss5/1.0
> > # Do not copy and paste the modprobe command!  Type it manually!
> > # Otherwise the mouse click used to paste the command at the same time as
> > # reloading the driver may crash the kernel.
> > modprobe -r psmouse ; modprobe psmouse
> > dmesg | grep 'ALPS ID'
> >
> > In the dmesg output, you should see something like:
> > psmouse serio1: alps: ALPS ID: E7=73 03 28, EC=73 01 13
> >
> > Are the E7 and EC numbers identical to the above?
> >
> > Then try two-finger scrolling, then run:
> > dmesg | grep 'two-finger'
> >
> > In the dmesg output, I expect you should see something like:
> > psmouse serio1: alps: ALPS two-finger packet (buttonpad: 0): 1c 51 46
> >
> > We can compare your output to mine to see what is different.
> >
> > If you're willing to experiment with the code yourself to try to figure
> > out more, the relevant code is in alps_decode_ss4_v2() in src/alps.c in
> > that tarball.  You should see the "ALPS two-finger packet" debug message I
> > added there ... you can add additional debugging messages to figure out
> > what exactly the decoder is doing.  The SS4_* macros for bit manipulation
> > and field extraction are defined near the top of src/alps.h.  To
> > recompile/reload the driver after making changes:
> > dkms remove alps_ss5/1.0 --all
> > dkms install alps_ss5/1.0
> > modprobe -r psmouse ; modprobe psmouse
> >
> > On Fri, Mar 03, 2017 at 02:58:34PM -0500, Joseph Salisbury wrote:
> > > Hi Ben,
> > >
> > > A kernel bug report was opened against Ubuntu [0].  After a kernel
> > > bisect, it was found that reverting the following commit resolved this
> > bug:
> > >
> > > commit aeaa881f9b17823028b464893b89c42db797b717
> > > Author: Ben Gamari <ben@smart-cactus.org>
> > > Date:   Tue Oct 4 11:43:30 2016 -0700
> > >
> > >     Input: ALPS - set DualPoint flag for 74 03 28 devices
> > >
> > > The regression was introduced as of v4.9-rc1.
> > >
> > > I was hoping to get your feedback, since you are the patch author.  Do
> > > you think gathering any additional data will help diagnose this issue,
> > > or would it be best to submit a revert request?
> > >
> > >
> > > Thanks,
> > >
> > > Joe
> > >
> > > [0] http://pad.lv/1662589
> > >
> >
