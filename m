From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] hid: Add mapping for special keys on compaq ku 0133 keyboard
Date: Tue, 21 Oct 2014 22:45:20 +0200
Message-ID: <5446C5E0.5080203@redhat.com>
References: <1407885290-3067-1-git-send-email-hdegoede@redhat.com> <20140812233530.GA9498@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:29056 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932842AbaJUUpZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Oct 2014 16:45:25 -0400
In-Reply-To: <20140812233530.GA9498@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi,

On 08/13/2014 01:35 AM, Dmitry Torokhov wrote:
> On Wed, Aug 13, 2014 at 01:14:50AM +0200, Hans de Goede wrote:
>> The compaq ku 0133 keyboard has 8 special keys at the top:
>> http://lackof.org/taggart/hacking/keyboard/cpqwireless.jpg
>>
>> 3 of these use standard HID usage codes from the consumer page, the 5
>> others use part of the reserved 0x07 - 0x1f range.
>>
>> This commit adds mapping for this keyboard for these reserved codes, making
>> the other 5 keys work.
>
> Can't we just load the proper keymap through udev without writing yet another
> kernel driver?

A valid question, and I agree that in this case where no special handling is
necessary, that would be better. So I've just tried this, but this does not
work, because hid-input.c chooses to ignore unknown usage codes in the
consumer page, rather then map them to KEY_UNKNOWN, making it impossible
to remap them through udev/hwdb later.

I've written a patch to fix this +  a hwdb patch, which seems like a better
way to deal with this then my original patch introducing a compaq usb hid kernel
driver esp. for this.

Regards,

Hans
