From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] input: pxrc: new driver for PhoenixRC Flight
 Controller Adapter
Date: Fri, 19 Jan 2018 15:24:32 -0800
Message-ID: <20180119232432.xygulmwpkw3vogls@dtor-ws>
References: <20180113201532.26016-1-marcus.folkesson@gmail.com>
 <20180116231625.e3sgum667xfuumx4@dtor-ws>
 <20180117135840.GA10949@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180117135840.GA10949@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Tomohiro Yoshidomi <sylph23k@gmail.com>, David Herrmann <dh.herrmann@gmail.com>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Jan 17, 2018 at 02:58:40PM +0100, Marcus Folkesson wrote:
> Hello Dmitry,
> 
> On Tue, Jan 16, 2018 at 03:16:25PM -0800, Dmitry Torokhov wrote:
> > Hi Marcus,
> > 
> > On Sat, Jan 13, 2018 at 09:15:32PM +0100, Marcus Folkesson wrote:
> > > This driver let you plug in your RC controller to the adapter and
> > > use it as input device in various RC simulators.
> > > 
> > > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > > ---
> > > v3:
> > > 	- Use RUDDER and MISC instead of TILT_X and TILT_Y
> > > 	- Drop kref and anchor
> > > 	- Rework URB handling
> > > 	- Add PM support
> > 
> > How did you test the PM support? By default the autopm is disabled on
> > USB devices; you need to enable it by writing to sysfs (I believe you
> > need to 'echo "auto" > /sys/bus/usb/<device>/power/control) and see if
> > it gets autosuspended when not in use and resumed after you start
> > interacting with it.
> 
> The test I've done is simply reading from the input device and then call
> `pm-suspend`.
> It works, suspend is called and reset_resume() will submit the URB
> again. Without the PM code, the application did not read any events upon
> resume.

We are talking about different things. You are testing system suspend,
whereas I was talking about runtime suspend (that's what
usb_autopm_get_interface() and friends does). It is disabled by default
and you need to enable it by writing into sysfs as I mentioned above.
Then, after a few seconds of not touching the device you should see the
USB interface going into low power state and the device shoudl correctly
implement remote wakeup signal to wake up the host controller/port when
user touches it. If the device does not implement this correctly, then
after suspending it will "die".

> 
> However, I found another tricky part.
> If I enable autosuspend (as you suggest) it will suspend when noone is
> using the device. Good.
> 
> But when someone is opening the device, input_dev->users is counted up
> to 1 before resume() is called. 
> Is this intended?
> 
> This code (from resume()) will therefor allways submit the URB:
> 
> if (input_dev->users && usb_submit_urb(pxrc->urb, GFP_NOIO) < 0)
> 
> 
> Then open() is called and fails because the urb is allready submitted.
> 
> input_dev->users is only incremented in input.c:input_open_device() what
> I can tell?

It is intended, but I guess we should not be using input_dev->users in
resume(), but rather have a local flag in your driver structure trhat
you update at the right time (i.e. after you submit USB in pxrc_open()).

I suppose we need the same fix in synaptics_usb.c...

> 
> I will move the submitting code to reset_resume() instead.

You need both resume() and reset_resume(), they are called in different
cases and you need to restart IO in both cases.

Thanks.

-- 
Dmitry
