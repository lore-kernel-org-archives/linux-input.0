From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [RFC] surface-input
Date: Mon, 9 Sep 2013 11:35:43 +0200
Message-ID: <CANq1E4TKBBFwuRFGi-UwS0+nfzbLQON6WEt7Pa2y8rweRTdJNA@mail.gmail.com>
References: <52289209.2070707@butterbrot.org>
	<5229D7CF.4090401@gmail.com>
	<522D860E.4020909@butterbrot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:58735 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073Ab3IIJfo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Sep 2013 05:35:44 -0400
Received: by mail-ie0-f179.google.com with SMTP id m16so10242893ieq.10
        for <linux-input@vger.kernel.org>; Mon, 09 Sep 2013 02:35:43 -0700 (PDT)
In-Reply-To: <522D860E.4020909@butterbrot.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Florian Echtler <floe@butterbrot.org>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input <linux-input@vger.kernel.org>, Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi

On Mon, Sep 9, 2013 at 10:25 AM, Florian Echtler <floe@butterbrot.org> wrote:
> On 06.09.2013 15:25, Benjamin Tissoires wrote:
>> Some generic comments:
>> - please always inline the code in the message, it is *much* easier to review and comment it
>> - please directly use a patch format: if the code is good, Dmitry can take it directly through his tree
>> - add the following people for further submissions:
>>   * Henrik - multitouch maintainer in the kernel, and I'm sure he will be happy to see this stuff
>>   * Dmitry - input maintainer, the driver will go through his tree, so it's better to let him know as soon as possible of the different discussions.
>> - please stick to the kernel formatting guidelines (without orders: do not use C99-style ("// ..."), do not mix tabs and spaces, stick to 80 columns, etc..). The whole documentation is in Documentation/CodingStyle, and use the script scripts/checkpatch.pl to validate most of these.
>> - I don't think a separate ".h" will be accepted as the declarations will not be used outside of the driver. Just merge the header on top of you .c file.
>
> Benjamin and David, thanks for your feedback. I will integrate this and
> get back to you with a proper patch ASAP.
>
> I have one additional question which is more about "future-proofing"
> this driver. The SUR40 hardware does also provide a raw video image from
> the touch sensor over another USB _endpoint_. Since it's not a different
> _interface_, this can only be handled in the same driver as far as I can
> tell. At some point in the future, I would like to add a V4L2 interface
> to also support the video endpoint - are there any issues I should
> already try to watch out for in the input part?

Media drivers use input-devices to report input data. So no, there is
no reason to change your driver's design. Once you want
media-functionality, you simply add a v4l2 device during hid_probe()
and remove it in hid_remove(). User-space can see the relation between
both via sysfs.
It is never wrong to think about the API _now_. But as long as it's
only a single input-dev and one v4l2-dev, I'd recommend to put both
below your usb-device and you're fine.
Regarding internal driver-design, you should not bother now. Make it
work for input and make it work well.

Cheers
David
