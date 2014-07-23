From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: [PATCH 4/5] hid: huion: Switch to generating report descriptor
Date: Wed, 23 Jul 2014 17:59:57 +0300
Message-ID: <53CFCDED.1030607@gmail.com>
References: <1406119378-24551-1-git-send-email-spbnick@gmail.com>	<1406119378-24551-5-git-send-email-spbnick@gmail.com> <CAN+gG=FapAjC3C5oMg2UvpAvXN6pzuG5ovjfXPygGorjPjTKcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:39029 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753996AbaGWPAB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Jul 2014 11:00:01 -0400
Received: by mail-we0-f175.google.com with SMTP id t60so1320791wes.6
        for <linux-input@vger.kernel.org>; Wed, 23 Jul 2014 08:00:00 -0700 (PDT)
In-Reply-To: <CAN+gG=FapAjC3C5oMg2UvpAvXN6pzuG5ovjfXPygGorjPjTKcw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>

On 07/23/2014 05:42 PM, Benjamin Tissoires wrote:
> On Wed, Jul 23, 2014 at 8:42 AM, Nikolai Kondrashov <spbnick@gmail.com> wrote:
>> Switch to generating tablet pen report descriptor from a template and
>> parameters retrieved from string descriptor 0x64.
>>
>> Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
>> ---
>
> This is a nice solution.

Thanks, Benjamin :)

>> -       rc = usb_string(hid_to_usb_dev(hdev), 0x64, buf, sizeof(buf));
>> -       if (rc < 0)
>> -               return rc;
>> +       /*
>> +        * Read string descriptor containing tablet parameters. The specific
>> +        * string descriptor and data were discovered by sniffing the Windows
>> +        * driver traffic.
>> +        * NOTE: This enables fully-functional tablet mode.
>> +        */
>> +       rc = usb_control_msg(usb_dev, usb_rcvctrlpipe(usb_dev, 0),
>> +                               USB_REQ_GET_DESCRIPTOR, USB_DIR_IN,
>> +                               (USB_DT_STRING << 8) + 0x64,
>> +                               0x0409, buf, sizeof(buf),
>> +                               USB_CTRL_GET_TIMEOUT);
>
> Just out of curiosity, you are replacing usb_string() by
> usb_control_msg(). They both seem to do the same, so why bother
> changing the call?

Well, actually they don't seem to do the same and the main difference is that
usb_string attempts to convert the data from UTF-16LE to UTF-8, which would be
undesirable for the binary contents we expect there.

>> +               resolution = le16_to_cpu(buf[5]);
>> +               if (resolution == 0) {
>> +                       params[HUION_PH_ID_X_PM] = 0;
>> +                       params[HUION_PH_ID_Y_PM] = 0;
>
> This is not good (not your code I mean). I know OEMs tend to not care
> about resolution, but Wayland will for the tablet protocol. The idea
> will be to report the coordinate in mm so that we can have a constant
> reporting across vendors/products.
>
> Did you ever fall in this case? and if so, isn't there any way of
> retrieving the actual resolution or an approximation?

Thankfully not. This is merely a protection against division-by-zero
exception in case they start doing that.

BTW, it's nice that Wayland tries to actually use the resolution.

> The rest looks fair enough, so even with my questions:
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Thanks for the review, Benjamin!

Will send a new version soon.

Sincerely,
Nick
