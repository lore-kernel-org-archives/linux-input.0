From: Jiri Kosina <jikos@jikos.cz>
Subject: Re: [PATCH] hiddev: compat_ptr() returns a void *
Date: Wed, 31 Oct 2007 12:27:24 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0710311217370.18815@twin.jikos.cz>
References: <20071031145153.30f9d3dd.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20071031145153.30f9d3dd.sfr@canb.auug.org.au>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-usb-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Wed, 31 Oct 2007, Stephen Rothwell wrote:

> so cast it to unsigned long before passing it to hiddev_ioctl.
> This gets rid of:
> drivers/hid/usbhid/hiddev.c: In function 'hiddev_compat_ioctl':
> drivers/hid/usbhid/hiddev.c:746: warning: passing argument 4 of 'hiddev_ioctl' makes integer from pointer without a cast
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Hi Stephen,

I already have this fixed in my tree, sorry.

Thanks a lot,

-- 
Jiri Kosina
