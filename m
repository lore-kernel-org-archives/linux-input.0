From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] hid: Add mapping for special keys on compaq ku 0133 keyboard
Date: Wed, 13 Aug 2014 10:38:49 +0200
Message-ID: <53EB2419.4000503@redhat.com>
References: <1407885290-3067-1-git-send-email-hdegoede@redhat.com> <20140812233530.GA9498@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57399 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750757AbaHMIix (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Aug 2014 04:38:53 -0400
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

Hmm, in this case I don't see any reason why not. ATM I don't have access
to the keyboard in question. I'll try writing a udev hwdb entry for it, assuming
that works I'll send that upstream to the u-boot guys. If it does not work for
some reason, then I'll send a v2 of this patch.

Regards,

Hans
