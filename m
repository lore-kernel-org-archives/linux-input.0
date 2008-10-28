From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: Re: [patch]aggessive autosuspend for HID devices (resent due to corruption)
Date: Tue, 28 Oct 2008 12:02:58 +0100
Message-ID: <200810281202.59969.oliver@neukum.org>
References: <200810271042.37365.oliver@neukum.org> <200810280947.16006.oliver@neukum.org> <1225217316.4017.7.camel@yangyi-dev>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1225217316.4017.7.camel@yangyi-dev>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: yi.y.yang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: Jiri Kosina <jikos-wDf7oJUeT2I@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Am Dienstag, 28. Oktober 2008 19:08:36 schrieb Yi Yang:
> On Tue, 2008-10-28 at 01:47 -0700, Oliver Neukum wrote:
> > Am Dienstag, 28. Oktober 2008 17:26:02 schrieb Yi Yang:
> > > > This uses the USB busy mechanism for aggessive autosuspend of USB
> > > > HID devices. It autosuspends all opened devices supporting remote wakeup
> > > > after a timeout unless
> > > > 
> > > > - output is being done to the device
> > > > - a key is being held down (remote wakeup isn't triggered upon key release)
> > > > - LED(s) are lit
> > > Why we shouldn't autosuspend it if it has LED lit?
> > 
> > If you suspend LEDs go dark. You'd hit e.g. caps lock, the LED would go
> > bright and two seconds later dark. That's no good.
> we can set longer intervel to aviod it to autosuspend in short interval.
> 
> I don't think lighting LED is one reason we can't autosuspend, display
> is a good example for this, the system will suspend to ram or hibernate
> if the user leaves very long although display is bright.

You can set a longer period and override the LED restriction by means
of a module parameter if you like. But the driver has to work with short
timeouts and by default it cannot reduce functionality.

It is possible that we would suspend the device after a secondary longer
timeout even if LEDs are lit. But I don't see why the driver should initiate
this. It should probably be left to user space.
I see this issue as orthogonal to "true" kernel space autosuspend.
I am not sure what interface would be best suited to that task.

	Regards
		Oliver

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
