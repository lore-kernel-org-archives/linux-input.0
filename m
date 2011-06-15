From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [RFC 05/12] HID: wiimote: Synchronize wiimote input and hid event handling
Date: Wed, 15 Jun 2011 08:34:16 +0200
Message-ID: <201106150834.16081.oliver@neukum.org>
References: <1308095157-4699-1-git-send-email-dh.herrmann@googlemail.com> <1308095157-4699-6-git-send-email-dh.herrmann@googlemail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:60342 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505Ab1FOGmS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Jun 2011 02:42:18 -0400
In-Reply-To: <1308095157-4699-6-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, padovan@profusion.mobi

Am Mittwoch, 15. Juni 2011, 01:45:50 schrieb David Herrmann:
> The wiimote first starts HID hardware and then registers the input
> device. We need to synchronize the startup so no event handler will
> start parsing events when the wiimote device is not ready, yet.

Hi,

here the fun begins. Using atomic ops is not for the faint of heart.
The problem is that atomic_t guarantees atomicity, not ordering.
Tasks on on other CPUs reading wdata->ready==1 does not mean
that they'll read anything else written before that as it was written
or the old value. You need smp barriers.

> 
> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> ---
>  drivers/hid/hid-wiimote.c |   13 +++++++++++++
>  1 files changed, 13 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
> index 9fa4fe1..4dbb2c1 100644
> --- a/drivers/hid/hid-wiimote.c
> +++ b/drivers/hid/hid-wiimote.c
> @@ -10,6 +10,7 @@
>   * any later version.
>   */
>  
> +#include <linux/atomic.h>
>  #include <linux/device.h>
>  #include <linux/hid.h>
>  #include <linux/input.h>
> @@ -20,6 +21,7 @@
>  #define WIIMOTE_NAME "Nintendo Wii Remote"
>  
>  struct wiimote_data {
> +	atomic_t ready;
>  	struct hid_device *hdev;
>  	struct input_dev *input;
>  };
> @@ -27,12 +29,22 @@ struct wiimote_data {
>  static int wiimote_input_event(struct input_dev *dev, unsigned int type,
>  						unsigned int code, int value)
>  {
> +	struct wiimote_data *wdata = input_get_drvdata(dev);
> +
> +	if (!atomic_read(&wdata->ready))
> +		return -EBUSY;
> +

Here an smp_rmb()

>  	return 0;
>  }
>  
>  static int wiimote_hid_event(struct hid_device *hdev, struct hid_report *report,
>  							u8 *raw_data, int size)
>  {
> +	struct wiimote_data *wdata = hid_get_drvdata(hdev);
> +
> +	if (!atomic_read(&wdata->ready))
> +		return -EBUSY;
> +
>  	if (size < 1)
>  		return -EINVAL;
>  
> @@ -98,6 +110,7 @@ static int wiimote_hid_probe(struct hid_device *hdev,
>  		goto err_stop;
>  	}
>

Here an smp_wmb()
It is redundant because input_register_device takes a spinlock which
implies a barrier, but you'll make the automated checking tools happier.  
> +	atomic_set(&wdata->ready, 1);
>  	hid_info(hdev, "New device registered\n");
>  	return 0;

	Regards
		Oliver
