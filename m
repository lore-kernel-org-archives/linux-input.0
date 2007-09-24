From: Jiri Kosina <jikos@jikos.cz>
Subject: Re: detecting when keys are being pressed on a
 keyboard
Date: Mon, 24 Sep 2007 15:45:59 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0709241544540.22331@twin.jikos.cz>
References: <200709211033.09698.oliver@neukum.org>
	<Pine.LNX.4.64.0709211444560.22331@twin.jikos.cz>
	<200709241256.05300.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200709241256.05300.oliver@neukum.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-input@atrey.karlin.mff.cuni.cz, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-usb-devel@lists.sourceforge.net
List-Id: linux-input@vger.kernel.org

On Mon, 24 Sep 2007, Oliver Neukum wrote:

> > HID doesn't keep any permanent state by itself. If you want to know 
> > whether a given key is currently pressed or not, you'd have to inspect 
> > the bitfields inside input_dev*, I am afraid.
> I see no way to do this without a race condition. The field isn't locked
> as far as I can tell.

Hi Oliver,

Dmitry (CC added) has been doing a lot of rework of locking in input as 
far as I know. He would know this better.

> Secondly, what is to happen in case of a system wide suspend? Will
> the system wake up thinking that the key is still pressed?

If the release event didn't happen before the machine went to suspend, I'd 
say so.

-- 
Jiri Kosina

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
