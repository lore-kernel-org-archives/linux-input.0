From: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: [PATCH] Make appletouch shut up when it has nothing to say
Date: Sun, 13 May 2007 11:46:26 -0700
Message-ID: <20070513114626.d943999a.zaitcev@redhat.com>
References: <1178995886.4168.10.camel@localhost>
	<20070513172052.GA26712@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070513172052.GA26712@srcf.ucam.org>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Soeren Sonnenburg <kernel@nn7.de>, linux-input@atrey.karlin.mff.cuni.cz, nicolas@boichat.ch, linux-usb-devel@lists.sourceforge.net, Linux Kernel <linux-kernel@vger.kernel.org>, zaitcev@redhat.com
List-Id: linux-input@vger.kernel.org

On Sun, 13 May 2007 18:20:53 +0100, Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> +static void atp_reinit(struct work_struct *work)
> +{
> +	char data[8];
> +	size = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
> +			       ATP_GEYSER3_MODE_READ_REQUEST_ID,
> +			       USB_DIR_IN | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
> +			       ATP_GEYSER3_MODE_REQUEST_VALUE,
> +			       ATP_GEYSER3_MODE_REQUEST_INDEX, &data, 8, 5000);

Generally speaking, DMA-ing from stack is not allowed. Maybe you want
to add a comment saying "buffer on stack because this is Mac-only driver".
I would not ask for kmalloc here which is entirely pointless.

> +
> +		/* Geyser 3 will continue to send packets continually after
> +		   the first touch unless reinitialised. Do so if it's been
> +		   idle for a while in order to avoid waking the kernel up
> +		   several hundred times a second */
> +		if (dev->idlecount >= 10)
> +			queue_work (appletouch_wq, &dev->work);

So, why don't you check for Geyser 3 or whatnot here instead of doing
it inside the work function? Why poking workqueue on other systems?

> +	appletouch_wq = create_singlethread_workqueue("kappletouch");
> +	if (!appletouch_wq) {
> +		printk(KERN_ERR "appletouch: failed to create workqueue\n");
> +		return -ENOMEM;
> +	}
>  	return usb_register(&atp_driver);

I'm wondering about the wisdom of this too. Why won't the stock
workqueue work? We have way too many daemons already. Plus, making
one more unconditionally regardless of hardware present seems like
stepping over the line to me.

Overall this seems like a good patch to me, only needs to be less
intrusive for owners of other hardware.

-- Pete
