From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: multitouch: Release all touch slots on reset_resume
Date: Mon, 14 Mar 2016 09:05:35 +0100
Message-ID: <20160314080535.GM22340@mail.corp.redhat.com>
References: <20160311221949.GA14029@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45181 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933728AbcCNIFk (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Mar 2016 04:05:40 -0400
Content-Disposition: inline
In-Reply-To: <20160311221949.GA14029@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benson Leung <bleung@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mar 11 2016 or thereabouts, Dmitry Torokhov wrote:
> From: Benson Leung <bleung@chromium.org>
> 
> When resetting a device (especially after power loss) it is unlikely
> that the firmware will keep the contact tracking data for the previous
> touches and will be able to reconcile it with the new contacts, so
> let's release all slots on reset resume as start anew.
> 
> Signed-off-by: Benson Leung <bleung@chromium.org>
> Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
> ---

Seems good to me:

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>  drivers/hid/hid-multitouch.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 6adb788..e24e33c 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -1148,8 +1148,30 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  }
>  
>  #ifdef CONFIG_PM
> +static void mt_release_contacts(struct hid_device *hid)
> +{
> +	struct hid_input *hidinput;
> +
> +	list_for_each_entry(hidinput, &hid->inputs, list) {
> +		struct input_dev *input_dev = hidinput->input;
> +		struct input_mt *mt = input_dev->mt;
> +		int i;
> +
> +		if (mt) {
> +			for (i = 0; i < mt->num_slots; i++) {
> +				input_mt_slot(input_dev, i);
> +				input_mt_report_slot_state(input_dev,
> +							   MT_TOOL_FINGER,
> +							   false);
> +			}
> +			input_sync(input_dev);
> +		}
> +	}
> +}
> +
>  static int mt_reset_resume(struct hid_device *hdev)
>  {
> +	mt_release_contacts(hdev);
>  	mt_set_maxcontacts(hdev);
>  	mt_set_input_mode(hdev);
>  	return 0;
> -- 
> 2.7.0.rc3.207.g0ac5344
> 
> 
> -- 
> Dmitry
