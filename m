From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: Re: full usbhid autosuspend
Date: Fri, 4 Apr 2008 17:08:47 +0200
Message-ID: <200804041708.48296.oliver@neukum.org>
References: <200804011603.05998.oliver@neukum.org> <200804041645.40301.oliver@neukum.org> <Pine.LNX.4.64.0804041708100.32130@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0804041708100.32130-YCXOAqNspd+N3ZZ/Hiejyg@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Am Freitag, 4. April 2008 17:11:24 schrieb Jiri Kosina:
> On Fri, 4 Apr 2008, Oliver Neukum wrote:
> 
> > > Yes. Just letting the USB keyboard go auto-suspend, then fiddling with 
> > > LEDs on PS2 keyboard and then hitting key on USB keyboard triggers it for 
> > > me quite reliably (not 100% though, so you may have to retry).
> > I mean did you hit e.g. CAPS LOCK or any key that should have switched an
> > LED or just any other key?
> 
> OK, so the quite reliable sequence seems to be
> 
> - let the USB keyboard go to sleep
> - press CAPS on PS2 keyboard
> - let the USB keyboard go to sleep again
> - press 'a' on USB keyboard
> - let the USB keyboard go to sleep again
> - press CAPS on PS2 keyboard
> - let the USB keyboard go to sleep again
> - press 'a' on the USB keyboard
> 
> => deadlock.

Good. I am recompiling with spinlock debug. This should be fixable.

	Regards
		Oliver

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
