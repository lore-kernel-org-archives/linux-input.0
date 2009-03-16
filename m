From: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Subject: Re: RFC: Wacom Bluetooth HID driver, first pass
Date: Mon, 16 Mar 2009 14:29:59 +0000
Message-ID: <1237213799.32264.10090.camel@cookie.hadess.net>
References: <1236988799.32264.6310.camel@cookie.hadess.net>
	 <1237200912.32264.9867.camel@cookie.hadess.net>
	 <93531296-64B0-4D4B-A4A9-26F3D67DF579@holtmann.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <93531296-64B0-4D4B-A4A9-26F3D67DF579-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Cc: linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, BlueZ development <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, mjg <mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Peter Hutterer <peter.hutterer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, zap-ez6wqqBRKvoox3rIn2DAYQ@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, 2009-03-16 at 15:00 +0100, Marcel Holtmann wrote:
> Hi Bastien,
> 
> >> This is a first pass at a driver for the Wacom Graphire Bluetooth
> >> tablet, based on work by Andrew Zabolotny[1]. It's mildly tested  
> >> (eg. it
> >> works in my very few tests).
> >>
> >> I was looking for guidance for the code itself, possibly making it
> >> easier to merge in the input/tablet/wacom* drivers into it in the
> >> future, as well as some explanations as to how I'm supposed to reset
> >> tools, etc. so the user-space drivers (the X.org linuxwacom driver)
> >> doesn't need special-casing for the device.
> >>
> >> Note that it requires a user-space activation to switch to Mode 2,  
> >> using
> >> bluetoothd (as the Bluetooth HID doesn't support  
> >> hid_output_raw_event).
> >> Patch at:
> >> http://cvs.fedoraproject.org/viewvc/rpms/bluez/devel/bluez-activate-wacom-mode2.patch?view=markup
> >
> > A couple of notes:
> > - the wheel action is reversed, it's a simple fix, done locally
> > - hidp and the Bluetooth sub-system says it can't probe the device  
> > with
> > error "-14" when hid-wacom.ko isn't already loaded
> 
> what was the reason for not forcing HID to load the generic driver?

What generic driver? If you're talking about the default Wacom driver,
it isn't an HID driver, and requires a USB device.

>  I  
> lost track on how HID is suppose to handle these. You could also  
> introduce a phony export like we do with L2CAP to ensure it is loaded  
> even if userspace isn't ready to handle this dependency.

Well, the problem is that the driver _does_ load, but I'm not certain
about the sequence of events between the Bluetooth sub-system, the
user-space enabling (see the linked patch to bluetoothd), and the HID
sub-system.

> > - I'm getting oopses in hci_conn_del() when the device goes away  
> > (eg. I
> > turn it off).
> 
> Try to run a net-next-2.6 or bluetooth-next-2.6 kernel. Kyle should  
> have merged these patches into the latest rawhide kernel.

I was hoping this would be fixed in the latest linus-2.6 tree, guess
not.

> > I'd appreciate any help making this just a tad more stable.
> >
> > Any comments about the code itself?
> 
> The main parsing function looks highly complicated and could either  
> use more comments or break into two.

The parsing is adapted from the code Andrew wrote, so I don't have any
great insights into it. Right it's in "it works well enough to do
things" mode, clean-ups and bug fixes will probably follow when my
machine stops crashing when using that driver :)

> 	if ((wdata->tool = tool)) {
> 		input_report_key(input, tool, 1);
> 		need_sync = 1;
> 	}
> 
> Don't do the assignment in the if clause test.

As I mentioned, copy/paste code this is.

>  Did you run  
> checkpatch.pl on it?

Nope, I didn't, but will do.

Cheers
