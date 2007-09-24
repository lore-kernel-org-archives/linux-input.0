From: Oliver Neukum <oliver@neukum.org>
Subject: Re: detecting when keys are being pressed on a
	keyboard
Date: Mon, 24 Sep 2007 12:56:05 +0200
Message-ID: <200709241256.05300.oliver@neukum.org>
References: <200709211033.09698.oliver@neukum.org>
	<Pine.LNX.4.64.0709211444560.22331@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.64.0709211444560.22331@twin.jikos.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: linux-usb-devel@lists.sourceforge.net
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Am Freitag 21 September 2007 schrieb Jiri Kosina:
> On Fri, 21 Sep 2007, Oliver Neukum wrote:
> 
> > I got the strange case of a keyboard going into autosuspend while a key 
> > was being pressed. The key release never arrived and I had to unplug the 
> > keyboard to get the key unstuck. Is there a clean way to learn from 
> > hid-core.c if a keyboard has keys pressed?
> 
> Hi Oliver,
> 
> HID doesn't keep any permanent state by itself. If you want to know 
> whether a given key is currently pressed or not, you'd have to inspect the 
> bitfields inside input_dev*, I am afraid.

I see no way to do this without a race condition. The field isn't locked
as far as I can tell.
Secondly, what is to happen in case of a system wide suspend? Will
the system wake up thinking that the key is still pressed?

	Regards
		Oliver

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
