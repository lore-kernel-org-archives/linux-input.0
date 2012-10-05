From: Daniel Drake <dsd@laptop.org>
Subject: Re: Communicating tablet mode status to userspace
Date: Fri, 5 Oct 2012 10:11:00 -0600
Message-ID: <CAMLZHHR8gk_D-zU2Wu819vQeJ4HV2n7RwoW-MUa1pDtkrH+Vdg@mail.gmail.com>
References: <CAMLZHHS80_zdmgVtJ87w+fuQGC05yj+EoJt3C_zBC7hkyhnaoQ@mail.gmail.com>
	<20121002233640.GB8542@core.coreip.homeip.net>
	<CAMLZHHQfGuiK6s_d8ya8FUNiDiGDpgh35VFbHcu-mgCH-=TXVw@mail.gmail.com>
	<20121003150542.GA8460@kroah.com>
	<CAPXgP10+ZzLC98VdaQz19413guR-sKLT47iFLbN-mF_isF0n9A@mail.gmail.com>
	<CAMLZHHTnhCjYA8x-=Q9+R3zbjV5ABnQ7D1hYX9qWfQ4Hck9f-Q@mail.gmail.com>
	<1349452248.11150.6.camel@novo.hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-hotplug-owner@vger.kernel.org>
In-Reply-To: <1349452248.11150.6.camel@novo.hadess.net>
Sender: linux-hotplug-owner@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Kay Sievers <kay@vrfy.org>, Greg KH <greg@kroah.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-hotplug@vger.kernel.org, Carlos Garnacho <carlosg@gnome.org>
List-Id: linux-input@vger.kernel.org

On Fri, Oct 5, 2012 at 9:50 AM, Bastien Nocera <hadess@hadess.net> wrote:
> I think that there's a more generic approach to this, which would also
> work with the tablet Thinkpads.
>
> I would export the current "tablet mode" status through sysfs (which is
> great if your driver keeps state), and send a uevent when the mode
> changes (in addition to sending out that input event).

When we tried to add such an attibute in the past, Dmitry rejected it:
http://article.gmane.org/gmane.linux.drivers.platform.x86.devel/1089

Apart from that, what your suggesting doesn't seem very different from
the earlier outcome here. We seem to have reached a generic solution,
where udev would identify input devices that have SW_TABLET_MODE and
make them accessible to the current seat. Then gnome-settings-daemon
can monitor them for evdev events (similar to the udev event
monitoring that would be necessary in your proposal).

Daniel
