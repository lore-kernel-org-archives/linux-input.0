From: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Subject: Re: [RFC 0/1] User-space I/O driver for HID subsystem (Bluetooth-LE
 HIDP)
Date: Fri, 16 Mar 2012 09:03:29 -0700
Message-ID: <1331913809.14217.155.camel@aeonflux>
References: <1331909617-22106-1-git-send-email-dh.herrmann@googlemail.com>
	 <alpine.LNX.2.00.1203161556540.18356@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LNX.2.00.1203161556540.18356-ztGlSCb7Y1iN3ZZ/Hiejyg@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: David Herrmann <dh.herrmann-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, chen.ganir-l0cyMroinI0@public.gmane.org, claudio.takahasi-430g2QfJUUCGglJvpFV4uA@public.gmane.org, jprvita-430g2QfJUUCGglJvpFV4uA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vijaykumar.Dadmode-kQvG35nSl+M@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Jiri,

> > I have hacked together a small driver which allows user-space I/O drivers to
> > provide HID devices. This is needed for Bluetooth-Low-Energy HID devices as the
> > Bluetooth-LE protocol is parsed in user-space.
> 
> David,
> 
> thanks for your effort.
> 
> I haven't read the full discussion you have CCed me on yesterday, but I 
> have one substantial question to start with -- is there a simple 
> explanation in a few sentences why Bluetooth-LE can't be added as a 
> in-kernel transport layer?
> 
> Answering that is, I believe, something that should start the whole 
> discussion.

that has been discussed. My point is that the Bluetooth SIG made a
mistake with their specification here. And my original words were much
harsher ;)

Let me make an analogy. It is like HID over XML. You don't want that in
the kernel.

Regards

Marcel
