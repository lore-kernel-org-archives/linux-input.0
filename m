From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH 2/2] Add a device driver for the Apple Magic Mouse.
Date: Wed, 10 Feb 2010 14:58:23 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1002101457560.30967@pobox.suse.cz>
References: <alpine.LNX.2.00.1001291515560.356@pobox.suse.cz> <dd18b0c31002082322m4238a4a6m73fc30752ba30447@mail.gmail.com> <1265710460.2383.5685.camel@localhost.localdomain> <201002090736.55576.edt@aei.ca> <alpine.LNX.2.00.1002091339190.30967@pobox.suse.cz>
 <87y6j2eeqv.fsf_-_@troilus.org> <87pr4eeemz.fsf_-_@troilus.org> <alpine.LNX.2.00.1002101404210.30967@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LNX.2.00.1002101404210.30967-ztGlSCb7Y1iN3ZZ/Hiejyg@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Poole <mdpoole-IZmAEv5cUt1AfugRpC6u6w@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, 10 Feb 2010, Jiri Kosina wrote:

> > +config HID_MAGICMOUSE
> > +	tristate "Apple" if EMBEDDED
> 
> Could you please make this something else than "Apple"? This string is 
> already used by HID_APPLE.

I have fixed this up on my side, no need for you to respin.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
