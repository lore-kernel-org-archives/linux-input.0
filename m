From: Frank Praznik <frank.praznik@gmail.com>
Subject: Re: [PATCH 0/5] HID: sony: misc fixes and cleanups
Date: Mon, 16 Feb 2015 16:48:53 -0500
Message-ID: <54E265C5.7050002@gmail.com>
References: <20150216150659.db522f3d.cand@gmx.com> <1424106744-12872-1-git-send-email-ao2@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:63045 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429AbbBPVs5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Feb 2015 16:48:57 -0500
Received: by mail-ig0-f178.google.com with SMTP id hl2so26179609igb.5
        for <linux-input@vger.kernel.org>; Mon, 16 Feb 2015 13:48:56 -0800 (PST)
In-Reply-To: <1424106744-12872-1-git-send-email-ao2@ao2.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ao2@ao2.it>, linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Lauri Kasanen <cand@gmx.com>, Frank Praznik <frank.praznik@oh.rr.com>

On 2/16/2015 12:12, Antonio Ospite wrote:
> Hi,
>
> here are a few cleanups for hid-sony.
>
> Changes are meant to follow the patch titled:
> [PATCHv4] HID: sony: Enable Gasia third-party PS3 controllers
>
> Frank, hi, I'd like to have your explicit ack at least for patch 1 and
> 2.
>
> Thanks,
>     Antonio
>
>
> Antonio Ospite (5):
>    HID: sony: Fix a WARNING shown when rmmod-ing the driver
>    HID: sony: Use the minimum accepted size for feature report 0xf2
>    HID: sony: Don't use magic numbers in sixaxis_set_operational_usb()
>    HID: sony: Use __u8 * for the buffer in sixaxis_set_operational_usb()
>    HID: sony: Coding style cleanups in sixaxis_set_operational_usb()
>
>   drivers/hid/hid-sony.c | 21 +++++++++++----------
>   1 file changed, 11 insertions(+), 10 deletions(-)
>
Hi Antonio, could you resend patch #1?  It didn't show up in my email 
and it's not on any of the web-based lists either.

Regards,
Frank
