From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 2/3] HID: usbhid: hid-core: submit queued urbs before suspend
Date: Wed, 14 Dec 2011 17:41:25 +0800
Message-ID: <CAGS+omBR6=SknipHES5Kb20V-8pN5knSx1=Q=z7xP6xc-GfWKQ@mail.gmail.com>
References: <1321529030-7845-1-git-send-email-djkurtz@chromium.org>
 <201112140855.40050.oneukum@suse.de> <CAGS+omDMipRTVOGV9fG0ciWpuwMRBL-eTY8uDwaiSOW==CkQ-w@mail.gmail.com>
 <201112141014.33696.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48158 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754975Ab1LNJlr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Dec 2011 04:41:47 -0500
Received: by iaeh11 with SMTP id h11so990660iae.19
        for <linux-input@vger.kernel.org>; Wed, 14 Dec 2011 01:41:46 -0800 (PST)
In-Reply-To: <201112141014.33696.oneukum@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: jkosina@suse.cz, bleung@chromium.org, stern@rowland.harvard.edu, olofj@chromium.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org

On Wed, Dec 14, 2011 at 5:14 PM, Oliver Neukum <oneukum@suse.de> wrote:
> Am Mittwoch, 14. Dezember 2011, 09:00:18 schrieb Daniel Kurtz:
>> On Wed, Dec 14, 2011 at 3:55 PM, Oliver Neukum <oneukum@suse.de> wro=
te:
>> > Am Donnerstag, 17. November 2011, 12:23:49 schrieb Daniel Kurtz:
>> >> Unfortunately, this usually happens while the first LED request i=
s
>> >> actually still being processed. =A0Thus when the completion handl=
er tries
>> >> to submit the second LED request it fails, since REPORTED_IDLE is
>> >> already set! =A0This REPORTED_IDLE check failure causes the compl=
etion
>> >> handler to complete, however without clearing the CTRL_RUNNING fl=
ag.
>> >> This, in turn, means that the suspend() handler's wait_io() condi=
tion
>> >> is never satisfied, and instead it times out after 10 seconds, ab=
orting
>> >> the original system suspend.
>> >>
>> >> This patch changes the behavior to the following:
>> >> =A0 (1) allow completion handler to finish submitting all queued =
URBs, even if
>> >> =A0 =A0 =A0 REPORTED_IDLE is set. =A0This guarantees that all URB=
s queued before the
>> >> =A0 =A0 =A0 hid-core suspend() call will be submitted before the =
system is
>> >> =A0 =A0 =A0 suspended.
>> >
>> > Hi,
>> >
>> > why is this desirable? You'd want to requests to be executed at re=
sumption.
>> > A system suspend will alter the LED state anyway.
>>
>> This is how a system suspend 'alters' the LED state. =A0The input la=
yer
>> sends those LED off commands down through HID as it is trying to
>> suspend. =A0We want to make sure the usbhid layer actually finishes
>> forwarding those requests on to the device before the system is
>> suspended.
>
> You know the HID layer will send those commands. You don't know which
> other commands may already be queued. So I don't know whether you rea=
lly want
> to execute them all while the system is asuspending.

I'm confused.  The HID layer is sending which commands?

AFAICT, suspend works like this:
    On system suspend, the input.c suspend() gets called, which saves
off current LED value, and sends LED off events to all keyboards.  If
more than one LED was on, there will be multiple LED off requests.
The HID core immediately submits the first of them (assuming it isn't
in the middle of sending another Control request URB), and queues URBs
for the rest of them, to be submitted by the completion handler.
    Meanwhile, the hid-core.c suspend() gets called soon after the
input suspend() finishes.  This can happen while usbhid driver is
still processing the first LED off request, and therefore there are
still other URBs queued up.  However, since suspend() sets
REPORTED_IDLE, the completion handler can't actually submit them.
Therefore, suspend() times out while waiting for i/o to complete, and
as a result aborts the system suspend.

This patch fixes this problem, and synchronizes queued URBs with
system suspend by sending all urbs that were queued before the usbhid
suspend() was called.

Please let me know if I'm missing something?

-Dan

>
> =A0 =A0 =A0 =A0Regards
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Oliver
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
