From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 08/10] HID: move apple quirks
Date: Wed, 4 Jun 2008 16:13:37 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0806041610240.10085@jikos.suse.cz>
References: <1210931362-18422-1-git-send-email-jirislaby@gmail.com>
 <1210931362-18422-2-git-send-email-jirislaby@gmail.com>
 <1210931362-18422-3-git-send-email-jirislaby@gmail.com>
 <1210931362-18422-4-git-send-email-jirislaby@gmail.com>
 <1210931362-18422-5-git-send-email-jirislaby@gmail.com>
 <1210931362-18422-6-git-send-email-jirislaby@gmail.com>
 <1210931362-18422-7-git-send-email-jirislaby@gmail.com>
 <1210931362-18422-8-git-send-email-jirislaby@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757654AbYFDONx@vger.kernel.org>
In-Reply-To: <1210931362-18422-8-git-send-email-jirislaby@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, marcel@holtmann.org, linux-kernel@vger.kernel.org, anssi.hannula@gmail.com, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-input@vger.kernel.org

On Fri, 16 May 2008, Jiri Slaby wrote:


> +static int apple_probe(struct hid_device *hdev,
> +		const struct hid_device_id *id)
> +{
> +	unsigned long quirks = id->driver_data;
> +	struct apple_sc *asc;
> +	int ret;
> +
> +	/* return something else or move to hid layer? device will reside
> +	   allocated */
> +	if (id->bus == BUS_USB && (id->driver_data & APPLE_IGNORE_MOUSE) &&
> +			to_usb_interface(hdev->dev.parent)->cur_altsetting->
> +			desc.bInterfaceProtocol == USB_INTERFACE_PROTOCOL_MOUSE)
> +		return -ENODEV;
> +
> +	asc = kzalloc(sizeof(*asc), GFP_KERNEL);
> +	if (asc == NULL) {
> +		dev_err(&hdev->dev, "can't alloc apple descriptor\n");
> +		return -ENOMEM;
> +	}
> +
> +	hid_set_drvdata(hdev, asc);
> +
> +	if (quirks & APPLE_HIDDEV)
> +		hdev->quirks |= HID_QUIRK_HIDDEV;
> +	if (quirks & APPLE_IGNORE_HIDINPUT)
> +		hdev->quirks |= HID_QUIRK_IGNORE_HIDINPUT;
> +
> +	ret = hid_parse(hdev);
> +	if (ret) {
> +		dev_err(&hdev->dev, "parse failed\n");
> +		goto err_free;
> +	}
> +
> +	ret = hid_hw_start(hdev);
> +	if (ret) {
> +		dev_err(&hdev->dev, "hw start failed\n");
> +		goto err_free;
> +	}
> +
> +	return 0;
> +err_free:
> +	kfree(asc);
> +	return ret;
> +}

Hi Jiri,

you don't seem to set asc->quirks anywhere, but the rest of the code is 
testing this flag. Is something like

	asc->quirks = id->driver_data;

missing in the _probe routine?

Or am I just horribly overlooking something?

Thanks,

-- 
Jiri Kosina
SUSE Labs
