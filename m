From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [PATCH 3/3] xpad.c: Added Xbox360 gamepad
	rumble support.
Date: Wed, 9 May 2007 00:29:35 -0400
Message-ID: <200705090029.35979.dtor@insightbb.com>
References: <Pine.LNX.4.64.0705021704180.13550@twin.jikos.cz>
	<alpine.LRH.0.98.0705031504280.22353@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
In-Reply-To: <alpine.LRH.0.98.0705031504280.22353@twin.jikos.cz>
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

On Thursday 03 May 2007 09:04, Jan Kratochvil wrote:
> Hi Dmitry,
>    thanks for feedback. Improved version of this patch follows:
> 
> It is enabled only if CONFIG_XPAD_FF is set to y.
> 
> Implementation is using force feedback support for memoryless devices.

Applied with couple cosmetic changes, thank you.

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
