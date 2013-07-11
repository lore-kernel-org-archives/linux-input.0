From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH 1/2] Bluetooth: hidp: implement hidinput_input_event
 callback
Date: Fri, 12 Jul 2013 00:50:42 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1307120050170.29788@pobox.suse.cz>
References: <1373550090-30379-1-git-send-email-benjamin.tissoires@redhat.com> <1373550090-30379-2-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1373550090-30379-2-git-send-email-benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Benjamin Tissoires <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Gustavo Padovan <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, David Herrmann <dh.herrmann-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Thu, 11 Jul 2013, Benjamin Tissoires wrote:

> We can re-enable hidinput_input_event to allow the leds of bluetooth
> keyboards to be set.
> Now the callbacks uses hid core to retrieve the right HID report to
> send, so this version is safer.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Acked-by: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>

> ---
>  net/bluetooth/hidp/core.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
> index f13a8da..9c8b50d 100644
> --- a/net/bluetooth/hidp/core.c
> +++ b/net/bluetooth/hidp/core.c
> @@ -238,6 +238,31 @@ static int hidp_send_report(struct hidp_session *session, struct hid_report *rep
>  	return hidp_send_intr_message(session, hdr, buf, rsize);
>  }
>  
> +static int hidp_hidinput_event(struct input_dev *dev, unsigned int type,
> +			       unsigned int code, int value)
> +{
> +	struct hid_device *hid = input_get_drvdata(dev);
> +	struct hidp_session *session = hid->driver_data;
> +	struct hid_field *field;
> +	int offset;
> +
> +	BT_DBG("session %p type %d code %d value %d",
> +	       session, type, code, value);
> +
> +	if (type != EV_LED)
> +		return -1;
> +
> +	offset = hidinput_find_field(hid, type, code, &field);
> +	if (offset == -1) {
> +		hid_warn(dev, "event field not found\n");
> +		return -1;
> +	}
> +
> +	hid_set_field(field, offset, value);
> +
> +	return hidp_send_report(session, field->report);
> +}
> +
>  static int hidp_get_raw_report(struct hid_device *hid,
>  		unsigned char report_number,
>  		unsigned char *data, size_t count,
> @@ -711,6 +736,7 @@ static struct hid_ll_driver hidp_hid_driver = {
>  	.stop = hidp_stop,
>  	.open  = hidp_open,
>  	.close = hidp_close,
> +	.hidinput_input_event = hidp_hidinput_event,
>  };
>  
>  /* This function sets up the hid device. It does not add it
> -- 
> 1.8.3.1
> 

-- 
Jiri Kosina
SUSE Labs
