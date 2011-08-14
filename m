From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH 1/7] HID: wiimote: Simplify synchronization
Date: Sun, 14 Aug 2011 12:55:36 +0200
Message-ID: <201108141255.36385.oliver@neukum.org>
References: <1313242155-3620-1-git-send-email-dh.herrmann@googlemail.com> <1313242155-3620-2-git-send-email-dh.herrmann@googlemail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:36838 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753047Ab1HNKwc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 14 Aug 2011 06:52:32 -0400
In-Reply-To: <1313242155-3620-2-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org, padovan@profusion.mobi, jkosina@suse.cz

Am Samstag, 13. August 2011, 15:29:09 schrieb David Herrmann:
> @@ -362,6 +343,15 @@ static struct wiimote_data *wiimote_create(struct hid_device *hdev)
>  
>  static void wiimote_destroy(struct wiimote_data *wdata)
>  {
> +       device_remove_file(&wdata->hdev->dev, &dev_attr_led1);
> +       device_remove_file(&wdata->hdev->dev, &dev_attr_led2);
> +       device_remove_file(&wdata->hdev->dev, &dev_attr_led3);
> +       device_remove_file(&wdata->hdev->dev, &dev_attr_led4);
> +
> +       input_unregister_device(wdata->input);
> +       hid_hw_stop(wdata->hdev);
> +
> +       cancel_work_sync(&wdata->worker);
>         kfree(wdata);
>  }

This looks like the work can run on a device whose hardware has already been
stopped. Is this safe?

	Regards
		Oliver
