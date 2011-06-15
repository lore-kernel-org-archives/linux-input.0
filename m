From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [RFC 07/12] HID: wiimote: Add output queue for wiimote driver
Date: Wed, 15 Jun 2011 08:37:15 +0200
Message-ID: <201106150837.15327.oliver@neukum.org>
References: <1308095157-4699-1-git-send-email-dh.herrmann@googlemail.com> <1308095157-4699-8-git-send-email-dh.herrmann@googlemail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:60364 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752722Ab1FOGmT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Jun 2011 02:42:19 -0400
In-Reply-To: <1308095157-4699-8-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, padovan@profusion.mobi

Am Mittwoch, 15. Juni 2011, 01:45:52 schrieb David Herrmann:

> +struct wiimote_buf {
> +	__u8 data[HID_MAX_BUFFER_SIZE];
> +	size_t size;
> +};

As this probably goes out over USB -> BT
you are violating the DMA buffer constraints.
Every buffer must be separately allocated with kmalloc().

>  struct wiimote_data {
>  	atomic_t ready;
>  	struct hid_device *hdev;
>  	struct input_dev *input;
> +
> +	spinlock_t qlock;
> +	__u8 head;
> +	__u8 tail;
> +	struct wiimote_buf outq[WIIMOTE_BUFSIZE];
> +	struct work_struct worker;
>  };
>  
>  static ssize_t wiimote_hid_send(struct hid_device *hdev, __u8 *buffer,
> @@ -36,6 +49,78 @@ static ssize_t wiimote_hid_send(struct hid_device *hdev, __u8 *buffer,
>  							HID_OUTPUT_REPORT);
>  }
>  
> +static void wiimote_worker(struct work_struct *work)
> +{
> +	struct wiimote_data *wdata = container_of(work, struct wiimote_data,
> +									worker);
> +
> +	if (!atomic_read(&wdata->ready))
> +		return;
> +
> +	spin_lock(&wdata->qlock);

You want _irqsave

> +	if (wdata->head != wdata->tail) {
> +		spin_unlock(&wdata->qlock);
> +		wiimote_hid_send(wdata->hdev, wdata->outq[wdata->tail].data,
> +						wdata->outq[wdata->tail].size);
> +		spin_lock(&wdata->qlock);
> +
> +		wdata->tail = (wdata->tail + 1) % WIIMOTE_BUFSIZE;
> +
> +		/*
> +		 * We are using the shared workqueue so send at most one whole
> +		 * buffer and then reschedule ourself so we do not occupy the
> +		 * shared workqueue for too long.
> +		 */
> +		if (wdata->head != wdata->tail)
> +			schedule_work(&wdata->worker);
> +	}
> +
> +	spin_unlock(&wdata->qlock);
> +}

	Regards
		Oliver
