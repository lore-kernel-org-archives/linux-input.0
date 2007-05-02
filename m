From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] [RFC] Added
	USB_DEVICE_INTERFACE_PROTOCOL
Date: Wed, 2 May 2007 15:04:33 -0700
Message-ID: <20070502220433.GB21015@suse.de>
References: <Pine.LNX.4.64.0705021702040.13550@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0705021702040.13550@twin.jikos.cz>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: Jan Kratochvil <honza@jikos.cz>
Cc: linux-input@atrey.karlin.mff.cuni.cz, Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, May 02, 2007 at 05:03:05PM +0200, Jan Kratochvil wrote:
> The USB_DEVICE_INTERFACE_PROTOCOL will allow to match one interface
> protocol of vendor specific device.
> This macro is used in patch adding support for xbox360 to xpad.c
> 
> Signed-off-by: Jan Kratochvil <honza@jikos.cz>

I have no objection to this, other than you need an additional newline
after the #define :)

Dmitry, I can take this through my tree, or you can take it through
yours, as I think the other patches in this series depend on this.

If you want to take it through yours, feel free to add:
	Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

to it.

thanks,

greg k-h

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
