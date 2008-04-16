From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [RFC 7/8] HID: move apple quirks
Date: Wed, 16 Apr 2008 16:42:10 +0200
Message-ID: <48061042.6030005@gmail.com>
References: <1207341357-17792-1-git-send-email-jirislaby@gmail.com> <1207341357-17792-8-git-send-email-jirislaby@gmail.com> <Pine.LNX.4.64.0804161544490.12972@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:28370 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757224AbYDPOmU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Apr 2008 10:42:20 -0400
Received: by fg-out-1718.google.com with SMTP id l27so2452637fgb.17
        for <linux-input@vger.kernel.org>; Wed, 16 Apr 2008 07:42:18 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0804161544490.12972@jikos.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, marcel@holtmann.org, dmitry.torokhov@gmail.com, Jiri Slaby <jslaby@suse.cz>

On 04/16/2008 03:45 PM, Jiri Kosina wrote:
> On Fri, 4 Apr 2008, Jiri Slaby wrote:
> 
>> Move them from core code to separate driver.
>> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
>> ---
>>  drivers/hid/Kconfig             |    7 +
>>  drivers/hid/Makefile            |    1 +
>>  drivers/hid/hid-apple.c         |  496 +++++++++++++++++++++++++++++++++++++++
>>  drivers/hid/hid-core.c          |   33 +++-
>>  drivers/hid/hid-input-quirks.c  |    8 -
>>  drivers/hid/hid-input.c         |  218 +-----------------
>>  drivers/hid/usbhid/hid-quirks.c |   43 ----
>>  include/linux/hid.h             |   11 -
>>  net/bluetooth/hidp/core.c       |   22 --
> 
> Hi Jiri,
> 
> how is the bluetooth quirk code removal related to the rest of the patch 
> (apple quirks movement) please?

Since the apple mightymouse is only quirked bluetooth device. Do you want me to 
split it to 2 patches -- an usb part and a BT part? (Or note this in changelog?)

Thanks.
