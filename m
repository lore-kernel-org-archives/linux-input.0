From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [PATCH 1/3] xpad.c: Added flags into
	xpad_device structure and removed dpad_mapping.
Date: Wed, 2 May 2007 22:38:35 -0400
Message-ID: <200705022238.36454.dtor@insightbb.com>
References: <Pine.LNX.4.64.0705021644580.13550@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.64.0705021644580.13550@twin.jikos.cz>
Content-Disposition: inline
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
Cc: linux-input@atrey.karlin.mff.cuni.cz, Jiri Kosina <jkosina@suse.cz>, Greg Kroah-Hartman <gregkh@suse.de>, linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Jan,

On Wednesday 02 May 2007 11:01, Jan Kratochvil wrote:
> This changes are expected to simplify further improves of this driver,
> We will need to add information if the driver is xbox360 device or not.
> 
> Second option was to simply add u8 is_360, but what if we'll need to know
> if device is a wheel? Or if the device can have keyboard (or headset) attached.
> 

...

> -#define MAP_DPAD_TO_BUTTONS    0
> -#define MAP_DPAD_TO_AXES       1
> -#define MAP_DPAD_UNKNOWN       -1
> +#define XPAD_FLAGS_DPAD_TO_BUTTONS    (1 << 0)
> +#define XPAD_FLAGS_DPAD_TO_AXES       (1 << 1)
> +#define XPAD_FLAGS_DPAD_UNKNOWN       (1 << 2)
> 

Turning this into bitmaps suggests that all of these could be set which is
not the case. Since there are 3 spare bytes in xpad_device structure to
use for additional flags/bitmaps I'd leave dpad_mapping alone.

-- 
Dmitry

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
