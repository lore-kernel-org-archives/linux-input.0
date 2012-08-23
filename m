From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [RFC ebeam PATCH v4 2/2] input: misc: New USB eBeam input driver.
Date: Thu, 23 Aug 2012 08:54:55 +0200
Message-ID: <5832321.EK5PCgIIzt@linux-lqwf.site>
References: <1345673514-11575-1-git-send-email-yann.cantin@laposte.net> <1345673514-11575-3-git-send-email-yann.cantin@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1345673514-11575-3-git-send-email-yann.cantin@laposte.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Yann Cantin <yann.cantin@laposte.net>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, gregkh@linuxfoundation.org, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thursday 23 August 2012 00:11:54 Yann Cantin wrote:
> +       /* input final setup */
> +       err = input_register_device(ebeam->input);
> +       if (err) {
> +               dev_dbg(&intf->dev,
> +                       "%s - input_register_device failed, err: %d\n",
> +                       __func__, err);
> +               goto out_free_urb;
> +       }
> +
> +       ebeam_setup_input(ebeam, input_dev);
> +
> +       /* usb final setup */
> +       usb_set_intfdata(intf, ebeam);

Hi,

this looks like a classic race. You initialize the device after you
register it. However, it may be used at that time.

	Regards
		Oliver
