From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [RFC 03/12] HID: wiimote: Add wiimote device structure
Date: Wed, 15 Jun 2011 08:20:22 +0200
Message-ID: <201106150820.22358.oliver@neukum.org>
References: <1308095157-4699-1-git-send-email-dh.herrmann@googlemail.com> <1308095157-4699-4-git-send-email-dh.herrmann@googlemail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:60328 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505Ab1FOGmR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Jun 2011 02:42:17 -0400
In-Reply-To: <1308095157-4699-4-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, padovan@profusion.mobi

Am Mittwoch, 15. Juni 2011, 01:45:48 schrieb David Herrmann:
>  static int wiimote_hid_probe(struct hid_device *hdev,
>                                 const struct hid_device_id *id)
>  {
> +       struct wiimote_data *wdata;
>         int ret;
>  
> +       wdata = wiimote_create(hdev);
> +       if (!wdata) {
> +               hid_err(hdev, "Can't alloc device\n");
> +               return -ENOMEM;
> +       }
> +
>         ret = hid_parse(hdev);
>         if (ret) {
>                 hid_err(hdev, "HID parse failed\n");
> -               return ret;
> +               goto err;
>         }
>  
>         ret = hid_hw_start(hdev, HID_CONNECT_HIDRAW);
>         if (ret) {
>                 hid_err(hdev, "HW start failed\n");
> -               return ret;
> +               goto err;
>         }
>  
>         hid_info(hdev, "New device registered\n");
>         return 0;
> +
> +err:
> +       kfree(wdata);
> +       return ret;
>  }


If you create wiimote_create(), you should for symmetry's sake also
create wiimote_destroy() encapsulating the kfree.

	Regards
		Oliver
