From: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 4/5] HID: autoload hid-multitouch as needed
Date: Mon, 12 Mar 2012 10:42:31 -0700
Message-ID: <1331574151.14217.86.camel@aeonflux>
References: <1331053026-21272-1-git-send-email-benjamin.tissoires@gmail.com>
	 <1331053026-21272-5-git-send-email-benjamin.tissoires@gmail.com>
	  <alpine.LNX.2.00.1203072234550.29034@pobox.suse.cz>
	 <20120308105737.GA11201@polaris.bitmath.org>
	 <6E17845C-6F9F-4CB6-AA5D-DEEDCD2089E8@enac.fr>
	 <alpine.LNX.2.00.1203121650500.18356@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LNX.2.00.1203121650500.18356-ztGlSCb7Y1iN3ZZ/Hiejyg@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: =?ISO-8859-1?Q?St=E9phane?= Chatty <chatty-rXV5z7KbLFk@public.gmane.org>, Henrik Rydberg <rydberg-Hk7bIW8heu4wFerOooGFRg@public.gmane.org>, "benjamin.tissoires" <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Gustavo F. Padovan" <padovan-Y3ZbgMPKUGA34EUeqzHoZw@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Jiri,

> > > What if we were to change the definition of a HID device on the
> > > modalias level?
> > > 
> > > In practise, a HID device can be either an usb device, a hid device,
> > 
> > Just to be sure: do you mean "bluetooth device"? or is there such a 
> > thing as a hid device per se? I'm asking because I've always been 
> > surprised at seeing usbhid/ in hid/, which kind of breaks the potential 
> > symmetry between USB and Bluetooth wrt hid.
> 
> Please don't get confused by the directory layout ... this has mostly 
> non-technical reasons -- Marcel wanted to keep bluetooth/hidp under his 
> wings, and I didn't have reasons to object strongly.
> 
> I am adding Marcel and Gustavo to CC just in case they have changed their 
> mind, but it's definitely a side-topic in this discussion.

I have not changed my mind. HIDP is Bluetooth specific and should stay
there. Especially since we are currently discussing changes to make
things also work over Bluetooth Low Energy (LE), but that is a complete
different topic and it just started.

> Marcel, Gustavo -- if you are interested in the whole discussion regarding 
> potential extension of HID core infrastructure to better suit multitouch, 
> please see the whole thread at http://marc.info/?t=133105322800006&r=1&w=4

HIDP is just a transport driver in the end. And I heard that the Apple
Magic Trackpad actually does work nicely. Never tried it by myself.

Regards

Marcel
