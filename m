From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [PATCH 04/16] HID: wiimote: Add extension support stub
Date: Mon, 14 Nov 2011 12:26:28 +0100
Message-ID: <CANq1E4QbOHa=-Vqi5pmSDi5OHJhN6nXkxD1wcHUSi-2xnOagBw@mail.gmail.com>
References: <1321190839-3517-1-git-send-email-dh.herrmann@googlemail.com>
	<1321190839-3517-5-git-send-email-dh.herrmann@googlemail.com>
	<201111140854.37983.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:65057 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327Ab1KNL0a convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Nov 2011 06:26:30 -0500
Received: by wwe5 with SMTP id 5so4233288wwe.1
        for <linux-input@vger.kernel.org>; Mon, 14 Nov 2011 03:26:29 -0800 (PST)
In-Reply-To: <201111140854.37983.oneukum@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz

Hi Oliver

On Mon, Nov 14, 2011 at 8:54 AM, Oliver Neukum <oneukum@suse.de> wrote:
> Am Sonntag, 13. November 2011, 14:27:07 schrieb David Herrmann:
>> +/* Deinitializes the extension driver of a wiimote */
>> +void wiiext_deinit(struct wiimote_data *wdata)
>> +{
>> + =A0 =A0 =A0 struct wiimote_ext *ext =3D wdata->ext;
>> + =A0 =A0 =A0 unsigned long flags;
>> +
>> + =A0 =A0 =A0 if (!ext)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 =A0 spin_lock_irqsave(&wdata->state.lock, flags);
>> + =A0 =A0 =A0 wdata->ext =3D NULL;
>> + =A0 =A0 =A0 spin_unlock_irqrestore(&wdata->state.lock, flags);
>> +
>> + =A0 =A0 =A0 cancel_work_sync(&ext->worker);
>> + =A0 =A0 =A0 kfree(ext);
>> +}
>
>
> Are you sure you are doing this in the correct order?
> You are needlessly leaving a window where wdate->ext is NULL
> but the worker may run.

Thanks for reviewing.
I am only removing the wdata->ext relationship here. This is not used
by the worker at all. I never access wdata->ext in this module without
taking the spinlock and without checking it for NULL.
The worker gets "ext" directy and can still access ext->wdata even if
ext->wdata->ext is NULL. This simplifies the locking a lot.

I also know that wdata lives longer than wdata->ext so I cannot find
any race condition here. I have checked all four entry points of the
extension-module and they all seem fine here.

As long as wdata->ext is non-NULL, wiiext_schedule may be called. So I
first need to clear wdata->ext before I kill the worker. Otherwise the
worker may be respawned before I reset wdata->ext ;)

> =A0 =A0 =A0 =A0Regards
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Oliver

Thank you
David
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
