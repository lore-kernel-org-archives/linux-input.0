From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH v3] HID: Add full support for Logitech Unifying receivers
Date: Fri, 9 Sep 2011 21:19:24 +0200
Message-ID: <CAN+gG=EVJimgA8jhgYnKufHzEk+RttE1gmgM6_abq2UDaqrf_A@mail.gmail.com>
References: <1314259880-7854-1-git-send-email-benjamin.tissoires@gmail.com>
	<CAN+gG=HZsREeuc0h53juGg3L6kseuEUeiBWe8ZCaNLaVpth1Qw@mail.gmail.com>
	<20110909182805.GH32383@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63531 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759739Ab1IITTZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Sep 2011 15:19:25 -0400
In-Reply-To: <20110909182805.GH32383@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, rtitmuss@logitech.com, ogay@logitech.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Nestor Lopez Casado <nlopezcasad@logitech.com>

Hi Dmitry,

On Fri, Sep 9, 2011 at 20:28, Dmitry Torokhov <dmitry.torokhov@gmail.co=
m> wrote:
> On Thu, Sep 01, 2011 at 02:43:32PM +0200, Benjamin Tissoires wrote:
>> > +
>> > + =A0 =A0 =A0 usbhid_submit_report(dj_rcv_hiddev, &report, USB_DIR=
_OUT);
>>
>> This is not working when the receiver is paired to a keyboard. When
>> the session launches, Gnome try to send leds commands to the keyboar=
d
>> and this results in an oops.
>>
>> Using a =A0pointer to the struct hid_report solves the crash.
>>
>> However, Dmitry, you told us about a DMA stack problem. Can you give
>> us a better way to handle that?
>>
>
> Actually it is OK, usbhid_submit_report internally allocates DMA_safe
> memory for raw report and copies the data for you.

Ok, thanks. I'll resubmit the patch ASAP.

Cheers,
Benjamin

>
> Thanks.
>
> --
> Dmitry
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
