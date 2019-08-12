From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] HID: logitech-dj: add support of the G700(s) receiver
Date: Mon, 12 Aug 2019 18:26:36 +0200
Message-ID: <f97403fd-4bf0-f82b-06e7-8bf4dcb2b2aa@redhat.com>
References: <20190812160804.11803-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190812160804.11803-1-benjamin.tissoires@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

On 12-08-19 18:08, Benjamin Tissoires wrote:
> Both the G700 and the G700s are sharing the same receiver.
> Include support for this receiver in hid-logitech-dj so that userspace
> can differentiate both.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Nice, looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>   drivers/hid/hid-logitech-dj.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
> index c547cba05fbb..d6250b0cb9f8 100644
> --- a/drivers/hid/hid-logitech-dj.c
> +++ b/drivers/hid/hid-logitech-dj.c
> @@ -959,6 +959,7 @@ static void logi_hidpp_recv_queue_notif(struct hid_device *hdev,
>   		break;
>   	case 0x07:
>   		device_type = "eQUAD step 4 Gaming";
> +		logi_hidpp_dev_conn_notif_equad(hdev, hidpp_report, &workitem);
>   		break;
>   	case 0x08:
>   		device_type = "eQUAD step 4 for gamepads";
> @@ -1832,6 +1833,10 @@ static const struct hid_device_id logi_dj_receivers[] = {
>   	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
>   			 USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_2),
>   	 .driver_data = recvr_type_hidpp},
> +	{ /* Logitech G700(s) receiver (0xc531) */
> +	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
> +		0xc531),
> +	 .driver_data = recvr_type_gaming_hidpp},
>   	{ /* Logitech lightspeed receiver (0xc539) */
>   	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
>   		USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED),
> 
