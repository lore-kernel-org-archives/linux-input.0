From: Oliver Neukum <oliver@neukum.org>
Subject: Re: Fwd:  autosuspend for appletouch driver
Date: Thu, 27 Sep 2007 20:05:54 +0200
Message-ID: <200709272005.55358.oliver@neukum.org>
References: <Pine.LNX.4.44L0.0709271158410.7735-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44L0.0709271158410.7735-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Soeren Sonnenburg <kernel@nn7.de>, Thomas Rohwer <tr@tng.de>, Richard Guenther <rguenther@suse.de>, linux-usb-devel@lists.sourceforge.net, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Am Donnerstag 27 September 2007 schrieb Alan Stern:
> On Thu, 27 Sep 2007, Oliver Neukum wrote:
> 
> > @@ -528,12 +537,20 @@ exit:
> >  static int atp_open(struct input_dev *input)
> >  {
> >  	struct atp *dev = input_get_drvdata(input);
> > +	int rv = 0;
> >  
> > -	if (usb_submit_urb(dev->urb, GFP_ATOMIC))
> > +	if (usb_autopm_get_interface(dev->intf) < 0)
> >  		return -EIO;
> > +	dev->intf->needs_remote_wakeup = 1;
> > +	if (usb_submit_urb(dev->urb, GFP_KERNEL)) {
> > +		rv = -EIO;
> > +		dev->intf->needs_remote_wakeup = 0;
> > +		goto err;
> >  
> >  	dev->open = 1;
> > -	return 0;
> > +err:
> > +	usb_autopm_put_interface(dev->intf);
> > +	return rv;
> >  }
> >  
> >  static void atp_close(struct input_dev *input)
> > @@ -543,6 +560,7 @@ static void atp_close(struct input_dev *
> >  	usb_kill_urb(dev->urb);
> >  	cancel_work_sync(&dev->work);
> >  	dev->open = 0;
> > +	dev->intf->needs_remote_wakeup = 0;
> >  }
> 
> Doesn't atp_close() need to call usb_autopm_put_interface(), to balance 
> the usb_autopm_get_interface() call in atp_open()?

No, the get is balanced in atp_open() itself. The patch uses the last_busy
mechanism the same way the version for generic hid does. In fact, it is
only necessary because there's no nice API call for setting
needs_remote_wakeup.

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
