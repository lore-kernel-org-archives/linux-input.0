From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH] HID: sony: Enable Gasia third-party PS3 controllers
Date: Thu, 19 Mar 2015 10:54:22 +0100
Message-ID: <1426758862.2814.4.camel@suse.de>
References: <20150207154859.89a7e4e3.cand@gmx.com>
	 <1423476481.10695.2.camel@linux-0dmf.site>
	 <20150209204414.a4d205be.cand@gmx.com>
	 <1423556076.19839.3.camel@linux-0dmf.site> <20150316211056.GB11441@amd>
	 <alpine.LNX.2.00.1503162236420.25438@pobox.suse.cz>
	 <1426756461.3815.3.camel@suse.de> <20150319093834.GB18997@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150319093834.GB18997@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Jiri Kosina <jkosina@suse.cz>, Lauri Kasanen <cand@gmx.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, ao2@ao2.it, AndrewD207@aol.com
List-Id: linux-input@vger.kernel.org

On Thu, 2015-03-19 at 10:38 +0100, Pavel Machek wrote:
> On Thu 2015-03-19 10:14:21, Oliver Neukum wrote:
> > On Mon, 2015-03-16 at 22:37 +0100, Jiri Kosina wrote:

> > > Are you sure CONFIG_DMA_API_DEBUG wouldn't warn here?
> > 
> > As far as I can tell, it will not warn. The problem is not in the
> > mapping itself. That is usually legitimate. The problem arises
> > because the buffer doesn't have a cacheline of its own. Thus the
> > memory corruption happens after the IO operation has started.
> 
> Nasty. Would WARN_ON(buffer & CACHELINE_SIZE-1) do at least part of

No. It is perfectly legitimate to put your buffer at an offset
or to combine buffers provided you don't use them at the same
time.

> the trick? Alternatively, could we call ksize() on the object, and
> fail if it is not big enough?

What object? We have a pointer to a memory location.

> Alternatively, we could create "allocate_for_usb" function, and only
> take pointers allocated by that function in usb functions. That would
> also teach people the problem exists...

No, this problem is not limited to USB.

	Regards
		Oliver
