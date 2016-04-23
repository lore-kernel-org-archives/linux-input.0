From: =?UTF-8?Q?Cl=C3=A9ment_VUCHENER?= <clement.vuchener@gmail.com>
Subject: Re: What's the difference between hid_hw_output_report and hid_hw_raw_request?
Date: Sat, 23 Apr 2016 16:56:16 +0200
Message-ID: <CAM4jgCoZK=n4b06qjrf=YTuvkWrz1yfkvbwdZ=fm67xt9sgL2A@mail.gmail.com>
References: <a0f08d24-0d11-7816-603d-2a198ee60caa@m-reimer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:34905 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836AbcDWO4R (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 23 Apr 2016 10:56:17 -0400
Received: by mail-io0-f181.google.com with SMTP id d62so48598057iof.2
        for <linux-input@vger.kernel.org>; Sat, 23 Apr 2016 07:56:16 -0700 (PDT)
In-Reply-To: <a0f08d24-0d11-7816-603d-2a198ee60caa@m-reimer.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Manuel Reimer <mail+linux-input@m-reimer.de>
Cc: linux-input <linux-input@vger.kernel.org>

2016-04-23 16:05 GMT+02:00 Manuel Reimer <mail+linux-input@m-reimer.de>:
> Hello,
>
> I want to enable the rumble motors on a PS4 controller using libusb.
>
> The kernel code calls different functions depending on whether USB or
> Bluetooth is used:
> https://github.com/torvalds/linux/blob/master/drivers/hid/hid-sony.c#L1901
> This difference does not exist in the code for the PS3 controller.
>
> So why is this difference in the kernel driver? What do I have to do to
> emulate "hid_hw_output_report" using libusb?

If I understand the code from hid-core.c correctly,
usbhid_output_report sends the report using the interrupt out pipe
instead of a control transfer. Check if the USB descriptor for your
device declares an interrupt out endpoint and use it if it exists.

>
> Thanks in advance.
>
> Manuel
>
>
> My current code, which does *not* work, follows. I also tried to not send
> the report ID as first byte in the command sequence, but this doesn't work
> either. The data seems to get sent without any problems, but the controller
> doesn't react in any way.
>
>  uint8_t cmd[] = {
>     0x05,
>     0xFF, 0x00, 0x00, right, left,  // rumble values
>     0xFF, 0xFF, 0xFF, 0x00, 0x00,  // Red, Green, Blue, TimeBright, TimeDark
>     0x00, 0x00, 0x00, 0x00, 0x00,
>     0x00, 0x00, 0x00, 0x00, 0x00,
>     0x00, 0x00, 0x00, 0x00, 0x00,
>     0x00, 0x00, 0x00, 0x00, 0x00,
>     0x00
>   };
>
>   return libusb_control_transfer(usbdev,
>                         LIBUSB_ENDPOINT_OUT | LIBUSB_REQUEST_TYPE_CLASS |
> LIBUSB_RECIPIENT_INTERFACE,
>                         HID_REQ_SET_REPORT,
>                         (HID_OUTPUT_REPORT<<8)|0x05,
>                         0,
>                         cmd,
>                         sizeof(cmd),
>                         USB_CTRL_GET_TIMEOUT);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
