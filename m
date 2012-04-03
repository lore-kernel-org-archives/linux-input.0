From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [RFC v2 0/1] User-space HID I/O Driver
Date: Tue, 3 Apr 2012 15:14:26 -0700 (PDT)
Message-ID: <alpine.LNX.2.00.1204031513070.9041@pobox.suse.cz>
References: <1332793209-2950-1-git-send-email-dh.herrmann@googlemail.com> <CAAngNMa0npQwBv+y_giRTOeLUMYiEnwWw4-cA+xMiRRsK732Mw@mail.gmail.com> <CAAngNMaOHRRfTy5yT9ys0Cv5yB5t-zEVxwcZWuK64BEA4oRy2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAAngNMaOHRRfTy5yT9ys0Cv5yB5t-zEVxwcZWuK64BEA4oRy2g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joao Paulo Rechi Vita <jprvita-430g2QfJUUCGglJvpFV4uA@public.gmane.org>
Cc: David Herrmann <dh.herrmann-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, chen.ganir-l0cyMroinI0@public.gmane.org, claudio.takahasi-430g2QfJUUCGglJvpFV4uA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, anderson.lizardo-430g2QfJUUCGglJvpFV4uA@public.gmane.org, marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, 3 Apr 2012, Joao Paulo Rechi Vita wrote:

> >> This is the second revision of the UHID driver. It basically allows to register
> >> hid_ll_drivers in user-space. This is needed to implement Bluetooth HoG (HID
> >> over GATT) as discussed earlier.
> >>
> >
> > We have a first prototype implementation of the HoG plugin working
> > with the uhid driver \o/
> >
> 
> I'm having problems with modifiers keys (they don't work). The USB-HID
> spec says that for each modifier key pressed a bit have to be set on
> the modifiers byte (byte 2) of the report array. Dumping the data both
> on the HoG plugin on bluetoothd and through hidraw for the created HID
> device shows that these bits are being set correctly.
> 
> Any idea of what could be wrong or additional checks that can be performed?

So hidraw shows the respective bits set properly, but they are not coming 
out of /dev/input/eventX, right?

How about /syse/kernel/debug/hid/<device>/events, does it show the events?

-- 
Jiri Kosina
SUSE Labs
