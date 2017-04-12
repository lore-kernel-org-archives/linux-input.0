From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] xen,input: add xen-kbdfront module parameter for
 setting resolution
Date: Wed, 12 Apr 2017 09:24:45 -0700
Message-ID: <20170412162445.GF6297@dtor-ws>
References: <20170411123037.31733-1-jgross@suse.com>
 <20170412151641.GA6297@dtor-ws>
 <fd644d8b-3cf2-239b-d9f7-c6745b3fc1b3@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33610 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754646AbdDLQZO (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 12 Apr 2017 12:25:14 -0400
Content-Disposition: inline
In-Reply-To: <fd644d8b-3cf2-239b-d9f7-c6745b3fc1b3@suse.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, linux-input@vger.kernel.org, boris.ostrovsky@oracle.com, andr2000@gmail.com, Thomas Hellstrom <thellstrom@vmware.com>

On Wed, Apr 12, 2017 at 06:04:30PM +0200, Juergen Gross wrote:
> On 12/04/17 17:16, Dmitry Torokhov wrote:
> > Hi Juergen,
> > 
> > On Tue, Apr 11, 2017 at 02:30:37PM +0200, Juergen Gross wrote:
> >> Add a parameter for setting the resolution of xen-kbdfront in order to
> >> be able to cope with a (virtual) frame buffer of arbitrary resolution.
> >>
> >> While at it remove the pointless second reading of parameters from
> >> Xenstore in the device connection phase: all parameters are available
> >> during device probing already and that is where they should be read.
> >>
> >> Signed-off-by: Juergen Gross <jgross@suse.com>
> >> ---
> >> V3: - merged the two patches
> >>     - read Xenstore parameters during probing of the device only
> > 
> > I guess 2 module parameters are not big deal, but could you tell me why
> > you can't always have them specified in Xenstore?
> 
> This will depend on Xen version then. I'd prefer to have a way to
> specify the resolution in case a new kernel is running as a guest
> of an old Xen version.

Who would be seeting up the kernel parameters in this case? User
manually in guest bootloader config?

> 
> > Also, I still think you are going in the wrong direction here. Can your
> > framebuffer size change after booting the guest? If it can, you have to
> > reconcile the new size and the coordinates reported by the pointing
> > device, and I think guest should be doing it. If you look, for example,
> > at vmmouse driver, they do not try to match coordinates it reports to
> > the screen.
> 
> I'm no expert in input driver interface. Can you tell me how the mouse
> pointer is positioned in case of the vmmouse driver? Are the real limits
> used just the minimum of pointing device and screen size limits? So
> specifying a size of 0xffff * 0xffff like the vmmouse driver does will
> work with any screen size being smaller than that?

I think 0xffff is just the limits for coordinates reported through this
interface; the expectation is that guest window size is not larger than
that. I do not recall if the backend reports real screen pointer
position, of offset from the (0,0) of guest's window, Thomas might tel
you. IIRC code in vmware tools package (that runs in guest) gets
notifications about screen changes and reacts accordingly.

Thanks.

-- 
Dmitry
