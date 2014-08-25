From: vichy <vichy.kuo@gmail.com>
Subject: Re: [PATCH 1/1] HID: usbhid: add usb_clear_halt determination for
 next hid_start_in
Date: Mon, 25 Aug 2014 20:56:02 +0800
Message-ID: <CAOVJa8FT_KvjNS=EPuxNmetmyicDX0jnPOv3A5Hb9rCOiaN47A@mail.gmail.com>
References: <Pine.LNX.4.44L0.1408221358030.967-100000@iolanthe.rowland.org>
	<1408962087.10300.15.camel@linux-fkkt.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oa0-f51.google.com ([209.85.219.51]:57718 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753406AbaHYM4D (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Aug 2014 08:56:03 -0400
In-Reply-To: <1408962087.10300.15.camel@linux-fkkt.site>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: Alan Stern <stern@rowland.harvard.edu>, Jiri Kosina <jkosina@suse.cz>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, linux-input@vger.kernel.org

hi Oliver:

2014-08-25 18:21 GMT+08:00 Oliver Neukum <oneukum@suse.de>:
> On Fri, 2014-08-22 at 14:23 -0400, Alan Stern wrote:
>> On Sat, 23 Aug 2014, vichy wrote:
>>
>> > from your patch, I have some questions:
>> > a. in Alan's version, if both HID_CLEAR_HALT and HID_RESET_PENDING are
>> > set, hid_reset will both "clear ep halt" and "reset devcie".
>> > But in original one, even HID_CLEAR_HALT and HID_RESET_PENDING are
>> > both set, hid_reset only do one of them.
>>
>> Yes.  In my patch, the clear-halt handler will turn on the
>> HID_RESET_PENDING bit if something goes wrong.  In that case we want to
>> do both things.
>
> Why? If we reset, why bother clearing a halt? Especially as this
> may mean waiting the full 5 seconds for a timeout.
I think what Alan mean is IF CLEAR HALT fail, we reset the device.
That is what below "In that case" mean.
 "In that case we want to do both things."

BR,
