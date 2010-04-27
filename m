From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 1/1] Bug in hidraw When a HID Device Contains Multiple
 Reports
Date: Tue, 27 Apr 2010 09:20:39 +0200
Message-ID: <4BD69047.3010703@gmail.com>
References: <4BD61506.1030301@signal11.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:52980 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073Ab0D0HUp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Apr 2010 03:20:45 -0400
In-Reply-To: <4BD61506.1030301@signal11.us>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Ott <alan@signal11.us>
Cc: Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, Marcel Holtmann <marcel@holtmann.org>, simon.windows@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 04/27/2010 12:34 AM, Alan Ott wrote:
> Make hidraw not stick an extra byte on the beginning of an IN transfer
> when a HID device contains multiple reports.
...
> I have attached a patch which seems to take care of this problem. Please
> let me know if I have completely misjudged the situation.

Nope, your analysis is correct. It was introduced by me in 85cdaf524. I
apparently forgot to change the hidraw case, so your fix is OK.

> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 2e2aa75..0e4a6fb 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1043,13 +1043,8 @@ void hid_report_raw_event(struct hid_device *hid, int type, u8 *data, int size,
>  
>  	if ((hid->claimed & HID_CLAIMED_HIDDEV) && hid->hiddev_report_event)
>  		hid->hiddev_report_event(hid, report);
> -	if (hid->claimed & HID_CLAIMED_HIDRAW) {
> -		/* numbered reports need to be passed with the report num */
> -		if (report_enum->numbered)
> -			hidraw_report_event(hid, data - 1, size + 1);
> -		else
> -			hidraw_report_event(hid, data, size);
> -	}
> +	if (hid->claimed & HID_CLAIMED_HIDRAW)
> +		hidraw_report_event(hid, data, size);
>  
>  	for (a = 0; a < report->maxfield; a++)
>  		hid_input_field(hid, report->field[a], cdata, interrupt);

-- 
js
