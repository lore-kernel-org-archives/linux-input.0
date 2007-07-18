From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [PATCH] appletouch powersaving - please apply for =?utf-8?q?2=2E6=2E23-rc1=09take?= #3
Date: Tue, 17 Jul 2007 21:48:56 -0400
Message-ID: <200707172148.58367.dtor@insightbb.com>
References: <1184656218.14051.43.camel@localhost> <d120d5000707170801u27e11936h9546bd36da7a1162@mail.gmail.com> <1184696179.6161.18.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <1184696179.6161.18.camel@localhost>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-input@atrey.karlin.mff.cuni.cz, linux-usb-devel@lists.sourceforge.net, Matthew Garrett <mjg59@srcf.ucam.org>, Nicolas Boichat <nicolas@boichat.ch>, Michael Hanselmann <linux-kernel@hansmi.ch>, Peter Osterlund <petero2@telia.com>, Frank Arnold <frank@scirocco-5v-turbo.de>, Stelian Pop <stelian@popies.net>, Johannes Berg <johannes@sipsolutions.net>, Greg Kroah-Hartman <greg@kroah.com>
List-Id: linux-input@vger.kernel.org

On Tuesday 17 July 2007 14:16, Soeren Sonnenburg wrote:
> On Tue, 2007-07-17 at 11:01 -0400, Dmitry Torokhov wrote:
> > Hi,
> > 
> > On 7/17/07, Soeren Sonnenburg <kernel@nn7.de> wrote:
> > >
> > >  err_free_buffer:
> > > @@ -656,6 +699,7 @@ static void atp_disconnect(struct usb_interface *iface)
> > >
> > >        usb_set_intfdata(iface, NULL);
> > >        if (dev) {
> > > +               cancel_work_sync(&dev->work);
> > >                usb_kill_urb(dev->urb);
> > >                input_unregister_device(dev->input);
> > >                usb_buffer_free(dev->udev, dev->datalen,
> > >
> > 
> > This should go into atp_close() and I think you need to do
> > cancel_work_sync after calling usb_kill_urb() otherwise you risk it
> > being submitted while you gettingto kill the urb.
> 
> good catch. modified patch accordingly+attached.
> 
> > How many boxes did you try this patch on?
> 
> Mine plus 1 other. However please note that Matthews patch has been
> (which is what this patch is based on) is in the mactel-patches
> repository for quite some time now and that the not-yet-cleanup up
> variant of this patch was posted to mactel-devel...
> 
> So the modeswitch part should work...
> 

OK, can I please get signed-off-bys for the latest version so I can
apply it?

Thanks!

-- 
Dmitry
