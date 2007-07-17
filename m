From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] appletouch powersaving - please apply for 2.6.23-rc1
Date: Tue, 17 Jul 2007 11:01:48 -0400
Message-ID: <d120d5000707170801u27e11936h9546bd36da7a1162@mail.gmail.com>
References: <1184656218.14051.43.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933732AbXGQPCA@vger.kernel.org>
In-Reply-To: <1184656218.14051.43.camel@localhost>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-input@atrey.karlin.mff.cuni.cz, linux-usb-devel@lists.sourceforge.net, Matthew Garrett <mjg59@srcf.ucam.org>, Nicolas Boichat <nicolas@boichat.ch>, Michael Hanselmann <linux-kernel@hansmi.ch>, Peter Osterlund <petero2@telia.com>, Frank Arnold <frank@scirocco-5v-turbo.de>, Stelian Pop <stelian@popies.net>, Johannes Berg <johannes@sipsolutions.net>, Greg Kroah-Hartman <greg@kroah.com>
List-Id: linux-input@vger.kernel.org

Hi,

On 7/17/07, Soeren Sonnenburg <kernel@nn7.de> wrote:
>
>  err_free_buffer:
> @@ -656,6 +699,7 @@ static void atp_disconnect(struct usb_interface *iface)
>
>        usb_set_intfdata(iface, NULL);
>        if (dev) {
> +               cancel_work_sync(&dev->work);
>                usb_kill_urb(dev->urb);
>                input_unregister_device(dev->input);
>                usb_buffer_free(dev->udev, dev->datalen,
>

This should go into atp_close() and I think you need to do
cancel_work_sync after calling usb_kill_urb() otherwise you risk it
being submitted while you gettingto kill the urb.

How many boxes did you try this patch on?

-- 
Dmitry
