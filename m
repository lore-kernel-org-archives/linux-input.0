From: Frank Praznik <frank.praznik@gmail.com>
Subject: Re: [PATCH 0/5] HID: sony: misc fixes and cleanups
Date: Tue, 17 Feb 2015 13:03:31 -0500
Message-ID: <54E38273.9040200@gmail.com>
References: <20150216150659.db522f3d.cand@gmx.com> <1424106744-12872-1-git-send-email-ao2@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:46025 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755887AbbBQSDh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Feb 2015 13:03:37 -0500
Received: by iecat20 with SMTP id at20so42758467iec.12
        for <linux-input@vger.kernel.org>; Tue, 17 Feb 2015 10:03:36 -0800 (PST)
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

The series looks good to me.  Thanks for tackling the last bit of magic 
constant cleanup.
For the entire series:

Acked-by: Frank Praznik <frank.praznik@oh.rr.com>
