From: Alan Ott <alan@signal11.us>
Subject: Re: hidraw, sixaxis and output reports.
Date: Mon, 04 Oct 2010 09:58:33 -0400
Message-ID: <4CA9DD89.2010106@signal11.us>
References: <20101002175958.fbb1aca4.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from core.signal11.us ([64.251.29.136]:37792 "EHLO core.signal11.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755913Ab0JDN6g (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 4 Oct 2010 09:58:36 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by core.signal11.us (Postfix) with SMTP id 5244B1CCAA96
	for <linux-input@vger.kernel.org>; Mon,  4 Oct 2010 09:58:35 -0400 (EDT)
In-Reply-To: <20101002175958.fbb1aca4.ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-input@vger.kernel.org, Jiri Kosina <trivial@kernel.org>, Jim Paris <jim@jtan.com>, Ranulf Doswell <ralf@ranulf.net>, =?ISO-8859-1?Q?fMikko_Virkkil=E4?= <mvirkkil@cc.hut.fi>, alktx@gmail.com

On 10/02/2010 11:59 AM, Antonio Ospite wrote:
> Hi,
>
> I am trying to set leds on sixaxis now, and the code I have works OK
> with libusb, but the equivalent for hidraw does not.
>
> The procedure to set leds is to send an output report 0x01 with the
> correct data. After looking at drivers/usbhid/hid-core.c in
> usbhid_output_raw_report() I see that output reports are sent over the
> interrupt endpoint when hid->urbout is defined (that is when the device
> has an interrupt out ep, right?), but it looks like this particular
> device is accepting output reports only on the _control_ endpoint; this
> is exactly what the working libusb version does btw.
>
> Just for the record, this dumb hack makes setting leds work on sixaxis
> with hidraw:
>
> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> index df80532..731c08c 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -841,7 +841,7 @@ static int usbhid_output_raw_report(struct hid_device *hid, __u8 *buf, size_t co
>          struct usb_host_interface *interface = intf->cur_altsetting;
>          int ret;
>
> -       if (usbhid->urbout&&  report_type != HID_FEATURE_REPORT) {
> +       if (0&&  usbhid->urbout&&  report_type != HID_FEATURE_REPORT) {
>                  int actual_length;
>                  int skipped_report_id = 0;
>                  if (buf[0] == 0x0) {
>
> If you are interested in the userspace programs, just ping me.
>
> What can I do to handle this properly? Add another quirk? Something
> like HID_QUIRK_NO_INTERRUPT_OUT_EP or HID_QUIRK_FORCE_CONTROL_OUT_EP?
>    

Sounds right to me. If there's an OUT endpoint, the device SHOULD handle 
output reports on it. Anything else is non-compliant, and I think a 
quirk makes sense.

That SixAxis is quite a pain....

Alan.



