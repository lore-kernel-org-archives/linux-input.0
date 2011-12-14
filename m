From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 2/3] HID: usbhid: hid-core: submit queued urbs before suspend
Date: Wed, 14 Dec 2011 16:00:18 +0800
Message-ID: <CAGS+omDMipRTVOGV9fG0ciWpuwMRBL-eTY8uDwaiSOW==CkQ-w@mail.gmail.com>
References: <1321529030-7845-1-git-send-email-djkurtz@chromium.org>
 <1321529030-7845-3-git-send-email-djkurtz@chromium.org> <201112140855.40050.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57300 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754549Ab1LNIAk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Dec 2011 03:00:40 -0500
Received: by iaeh11 with SMTP id h11so865695iae.19
        for <linux-input@vger.kernel.org>; Wed, 14 Dec 2011 00:00:39 -0800 (PST)
In-Reply-To: <201112140855.40050.oneukum@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: jkosina@suse.cz, bleung@chromium.org, stern@rowland.harvard.edu, olofj@chromium.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org

On Wed, Dec 14, 2011 at 3:55 PM, Oliver Neukum <oneukum@suse.de> wrote:
> Am Donnerstag, 17. November 2011, 12:23:49 schrieb Daniel Kurtz:
>> Unfortunately, this usually happens while the first LED request is
>> actually still being processed. =A0Thus when the completion handler =
tries
>> to submit the second LED request it fails, since REPORTED_IDLE is
>> already set! =A0This REPORTED_IDLE check failure causes the completi=
on
>> handler to complete, however without clearing the CTRL_RUNNING flag.
>> This, in turn, means that the suspend() handler's wait_io() conditio=
n
>> is never satisfied, and instead it times out after 10 seconds, abort=
ing
>> the original system suspend.
>>
>> This patch changes the behavior to the following:
>> =A0 (1) allow completion handler to finish submitting all queued URB=
s, even if
>> =A0 =A0 =A0 REPORTED_IDLE is set. =A0This guarantees that all URBs q=
ueued before the
>> =A0 =A0 =A0 hid-core suspend() call will be submitted before the sys=
tem is
>> =A0 =A0 =A0 suspended.
>
> Hi,
>
> why is this desirable? You'd want to requests to be executed at resum=
ption.
> A system suspend will alter the LED state anyway.

This is how a system suspend 'alters' the LED state.  The input layer
sends those LED off commands down through HID as it is trying to
suspend.  We want to make sure the usbhid layer actually finishes
forwarding those requests on to the device before the system is
suspended.

Regards,
-Daniel

>
> =A0 =A0 =A0 =A0Regards
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Oliver
> --
> - - -
> SUSE LINUX Products GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imend=F6=
rffer, HRB 16746 (AG N=FCrnberg)
> Maxfeldstra=DFe 5
> 90409 N=FCrnberg
> Germany
> - - -
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
