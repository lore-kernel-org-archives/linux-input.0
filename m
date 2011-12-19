From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH v2] Input: bcm5974 - Fix USB autosuspend
Date: Mon, 19 Dec 2011 18:42:08 +0100
Message-ID: <201112191842.08635.oliver@neukum.org>
References: <1324314123-2200-1-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1324314123-2200-1-git-send-email-rydberg@euromail.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Matthew Garrett <mjg@redhat.com>
List-Id: linux-input@vger.kernel.org

Am Montag, 19. Dezember 2011, 18:02:03 schrieb Henrik Rydberg:
>  static int bcm5974_suspend(struct usb_interface *iface, pm_message_t message)
> @@ -870,6 +884,9 @@ static int bcm5974_probe(struct usb_interface *iface,
>                          dev->tp_data, dev->cfg.tp_datalen,
>                          bcm5974_irq_trackpad, dev, 1);
>  
> +       /* Required for autosuspend */
> +       iface->needs_remote_wakeup = 1;
> +
>         /* create bcm5974 device */
>         usb_make_path(udev, dev->phys, sizeof(dev->phys));
>         strlcat(dev->phys, "/input0", sizeof(dev->phys));

It is not nice to set needs_remote_wakeup on suspend() because
it influences the decision of usbcore to suspend at all, in particular
manually set quirks will not be fully honored if you do it this way.
In addition it will never be reset, even as the device is closed.

Please set it in open() and clear it in close()

	Regards
		Oliver
