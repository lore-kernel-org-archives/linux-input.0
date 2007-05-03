From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [PATCH] [RFC] Added USB_DEVICE_INTERFACE_PROTOCOL
Date: Wed, 2 May 2007 22:56:53 -0400
Message-ID: <200705022256.54552.dtor@insightbb.com>
References: <Pine.LNX.4.64.0705021702040.13550@twin.jikos.cz> <20070502220433.GB21015@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1767341AbXECC4z@vger.kernel.org>
In-Reply-To: <20070502220433.GB21015@suse.de>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@atrey.karlin.mff.cuni.cz
Cc: Greg KH <gregkh@suse.de>, Jan Kratochvil <honza@jikos.cz>, linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
List-Id: linux-input@vger.kernel.org

On Wednesday 02 May 2007 18:04, Greg KH wrote:
> On Wed, May 02, 2007 at 05:03:05PM +0200, Jan Kratochvil wrote:
> > The USB_DEVICE_INTERFACE_PROTOCOL will allow to match one interface
> > protocol of vendor specific device.
> > This macro is used in patch adding support for xbox360 to xpad.c
> > 
> > Signed-off-by: Jan Kratochvil <honza@jikos.cz>
> 
> I have no objection to this, other than you need an additional newline
> after the #define :)
> 
> Dmitry, I can take this through my tree, or you can take it through
> yours, as I think the other patches in this series depend on this.
> 
> If you want to take it through yours, feel free to add:
> 	Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 

I will grab it once some issues with the patch set are resolved.

Thanks,

-- 
Dmitry
