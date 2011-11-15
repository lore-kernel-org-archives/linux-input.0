From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [PATCH 04/16] HID: wiimote: Add extension support stub
Date: Tue, 15 Nov 2011 20:24:53 +0100
Message-ID: <CANq1E4SixuZ=T27H3wGUe1TnYG-qXo2Yxs3RosdsNkMCrhrixA@mail.gmail.com>
References: <1321190839-3517-1-git-send-email-dh.herrmann@googlemail.com>
	<201111140854.37983.oneukum@suse.de>
	<CANq1E4QbOHa=-Vqi5pmSDi5OHJhN6nXkxD1wcHUSi-2xnOagBw@mail.gmail.com>
	<201111141235.17887.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33602 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757248Ab1KOTYy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Nov 2011 14:24:54 -0500
Received: by mail-ww0-f44.google.com with SMTP id 5so6641609wwe.1
        for <linux-input@vger.kernel.org>; Tue, 15 Nov 2011 11:24:53 -0800 (PST)
In-Reply-To: <201111141235.17887.oneukum@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz

On Mon, Nov 14, 2011 at 12:35 PM, Oliver Neukum <oneukum@suse.de> wrote=
:
> Am Montag, 14. November 2011, 12:26:28 schrieb David Herrmann:
>> I also know that wdata lives longer than wdata->ext so I cannot find
>> any race condition here. I have checked all four entry points of the
>> extension-module and they all seem fine here.
>>
>> As long as wdata->ext is non-NULL, wiiext_schedule may be called. So=
 I
>> first need to clear wdata->ext before I kill the worker. Otherwise t=
he
>> worker may be respawned before I reset wdata->ext ;)
>
> Hi,
>
> thank you for the detailed explanation. Could you include a comment
> to explain the unusual order things are done in this function?

Sure. I'll resend the patches in few days if nothing else comes up.

>
> =A0 =A0 =A0 =A0Regards
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Oliver

Regards
David
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
