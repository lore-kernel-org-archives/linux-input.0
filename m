From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [PATCH 03/16] HID: wiimote: Add drm request
Date: Thu, 28 Jul 2011 20:41:18 +0200
Message-ID: <CANq1E4Qui-84C+rDOSnQKvC+BoKWTnZWXOSH=kYtdE0bPB1yCA@mail.gmail.com>
References: <1311869316-17128-1-git-send-email-dh.herrmann@googlemail.com>
	<1311869316-17128-4-git-send-email-dh.herrmann@googlemail.com>
	<201107282005.40226.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:59560 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752452Ab1G1SlU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jul 2011 14:41:20 -0400
Received: by vws1 with SMTP id 1so2406106vws.19
        for <linux-input@vger.kernel.org>; Thu, 28 Jul 2011 11:41:19 -0700 (PDT)
In-Reply-To: <201107282005.40226.oneukum@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, padovan@profusion.mobi

On Thu, Jul 28, 2011 at 8:05 PM, Oliver Neukum <oneukum@suse.de> wrote:
> Am Donnerstag, 28. Juli 2011, 18:08:23 schrieb David Herrmann:
>> +static void wiiproto_req_drm(struct wiimote_data *wdata, __u8 drm)
>> +{
>> + =A0 =A0 =A0 __u8 cmd[3];
>
> Are you sure these buffers nned not be safe for DMA?

wiimote_queue() allocates a buffer for every request. This should be
fine for DMA then. All wiimote_req_*() functions work the same way.

> =A0 =A0 =A0 =A0Regards
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Oliver

Regards
David
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
