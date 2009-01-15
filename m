From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Bugme-new] [Bug 12447] New: usbtouchscreen submits URB too quickly if built in to kernel
Date: Wed, 14 Jan 2009 21:11:13 -0800
Message-ID: <200901142111.14203.dmitry.torokhov@gmail.com>
References: <bug-12447-10286@http.bugzilla.kernel.org/> <20090114151336.3b97893a.akpm@linux-foundation.org> <20090115044338.GA6423@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090115044338.GA6423-wUGeVx6es1+Q2O5dskk9LyLysJ1jNyTM@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: David Hagood <david.hagood-15hjz6xD4c1Wk0Htik3J/w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bugme-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wednesday 14 January 2009 20:43:39 Dmitry Torokhov wrote:
> On Wed, Jan 14, 2009 at 03:13:36PM -0800, Andrew Morton wrote:
> > On Wed, 14 Jan 2009 17:08:28 -0600
> >
> > David Hagood <david.hagood-15hjz6xD4c1Wk0Htik3J/w@public.gmane.org> wrote:
> > > On Wed, 2009-01-14 at 10:28 -0800, Andrew Morton wrote:
> > > > (switched to email.  Please respond via emailed reply-to-all, not via
> > > > the bugzilla web interface).
> > >
> > > OK, you asked for it - no fair complaining about the email wart that I
> > > can do nothing about.
> >
> > It happens.
> >
> > > > On Wed, 14 Jan 2009 08:29:31 -0800 (PST)
> > > > bugme-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org wrote:
> > > >
> > > > Is this a USB thing, or an input thing?
> > >
> > > I'm not sure I understand the question. The problem is in the
> > > usbtouchscreen kernel module, which is an input module.
> > >
> > > The problem is NOT at the X layer (read: user space), but in the kernel
> > > driver.
> > >
> > > Did that answer the question?
> >
> > The question was asked of the USB and input developers ;) It's unclear
> > (to me) which subsystem would need fixing to make this work properly.
>
> I suppose this is device-specific and will have to be worked around in
> the driver buy resubmitting request a few times until it "sticks".

Hmm, I take it back... the message comes from the IRQ routine; that
means we were able to submit IRQ at least once. Plus we do send a
few control messages for mtouch. So I don't understand why it would
start returning -ENODEV out of sudden.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
