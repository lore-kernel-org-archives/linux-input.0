From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 1/2] elantech: Properly differentiate between clickpads
 and normal touchpads
Date: Tue, 10 Dec 2013 09:45:36 +0100
Message-ID: <52A6D4B0.20206@redhat.com>
References: <1386599551-2339-1-git-send-email-hdegoede@redhat.com> <CAN+gG=Eh72eBS67db_KNsUzXRNsOUXB8YkzuuHoJca22xRAkdQ@mail.gmail.com> <52A6169C.1020904@redhat.com> <CAN+gG=FgR9cBwJ_GFrU3RAmwma0XWzt8Wdi-HM2zEOOmdPNS+A@mail.gmail.com> <20131210061256.GA12524@core.coreip.homeip.net> <CF3F8F5F02EE401CBA8F5EFBCC62074D@elan.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:63687 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752058Ab3LJIpq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Dec 2013 03:45:46 -0500
In-Reply-To: <CF3F8F5F02EE401CBA8F5EFBCC62074D@elan.corp>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: duson <dusonlin@emc.com.tw>, 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, 'Benjamin Tissoires' <benjamin.tissoires@gmail.com>
Cc: 'linux-input' <linux-input@vger.kernel.org>, 'Peter Hutterer' <peter.hutterer@redhat.com>, =?Big5?B?J7bApUDEUCc=?= <phoenix@emc.com.tw>

Hi Duson,

On 12/10/2013 09:35 AM, duson wrote:

<snip>

>> We should not advertise events that device does not generate. This
>> should help userspace to decide if emulation is needed or not. Input
>> core will drop events that are not set up as valid for device, so if we
>> clear BTN_RIGHT there it should all work.
> 
> Actually, our touchpad for PS2 protocol implements the left and right click
> function, even thought, it is a click-pad. And the flag for left/right click
> information is recorded in the first byte of the packet (when doing sync
> method).
> 	Byte0 Bit 0 --> for left click flag
> 	Byte0 Bit1 --> for right click flag
> When user presses the left-bottom area of the click-pad, only the left click
> flag will be set to "1". On the other hand, pressing the right-bottom area
> of the click-pad, only the right click flag will be set to "1".
> So, I think this is the cause of the BTN_RIGHT need to be set.

Are you sure? All info we have so far indicates that the right button needs
to be emulated in software in the clickpad case, ie a while back this
commit was added:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/input/mouse/elantech.c?id=e3dde4fba94e0ba5e1fd79ea9e5389eea1f0cfec

To fix the right button not working, this also removes the checking
for bit 1 / reporting of BTN_RIGHT events, so if the right click area
would actually send right clicks I would expect the above commit to
have broken right clicking for tons of users, and we have no bug reports
about this (my patch fixes the right button being broken in the non
clickpad case).

Note that the Linux driver uses the touchpad in absolute mode, not in
relative / ps/2 mouse emulation mode. Could it be that the handling of the
right button emulation for clickpads is only done in the firmware in
relative mode ?

Or maybe it is done in firmware for hardware v3 clickpads, but not for
v4 clickpads ?

Thanks & Regards,

Hans
