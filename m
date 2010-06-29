From: Alan Ott <alan-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org>
Subject: Re: Report ID problem with HID-RAW interface usage
Date: Tue, 29 Jun 2010 12:30:24 -0400
Message-ID: <4C2A1FA0.6020704@signal11.us>
References: <AANLkTinrmRsB39gj7Ie4xCr3fhP3jU1dfYuVrkiKv347@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTinrmRsB39gj7Ie4xCr3fhP3jU1dfYuVrkiKv347-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Amit Nagal <helloin.amit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 06/29/2010 07:10 AM, Amit Nagal wrote:
> i am trying to send a vendor specific HID report from a userspace host
> program to vendor usb hid device
> using HIDRAW interface .
>
>
> but when i send report in the format<  "Report ID "(0th byte )>
> <Report ID (1st byte )>  <  "data payload">
> i am getting perfect report response from usb device .
>   where we use usb_control_msg as  :
>
> ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
> 		HID_REQ_SET_REPORT,
> 		USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
> 		cpu_to_le16(((HID_OUTPUT_REPORT + 1)<<  8) | *buf),
> 		interface->desc.bInterfaceNumber, buf + 1, count - 1,
> 		USB_CTRL_SET_TIMEOUT);
>
>    

I thought I'd be able to just go check the HID specification and be able 
to say that the report number is not sent as part of the payload for 
Set_Report devices, since it would be redundant because the Report ID is 
sent over in the wValue field.

Unfortunately, I was not able to see that clearly laid out in the HID 
specification in the section on Set_Report. I did however find language 
saying "if a Report ID tag was used in the Report descriptor, all 
reports include a single byte ID prefix," in section 8.1, Report Types.

I did some tests with the Windows implementation, and indeed, when 
numbered reports are used in the HID descriptor, the Windows 
implementation will send the report ID as the first byte of the payload.

Based on the language in the HID spec, and the behavior of Windows, I 
believe the buf+1, count-1 to be a bug.

Jiri, what do you think? Can you confirm?

Alan.


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
