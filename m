From: Michael Poole <mdpoole@troilus.org>
Subject: Re: [PATCH 3/3] HID: deletion of unused code in hid-magicmouse.
Date: Mon, 08 Mar 2010 15:27:43 -0500
Message-ID: <87sk8a36f4.fsf@troilus.org>
References: <1268065277-30129-1-git-send-email-tissoire@cena.fr>
	<1268065277-30129-2-git-send-email-tissoire@cena.fr>
	<1268065277-30129-3-git-send-email-tissoire@cena.fr>
	<1268065277-30129-4-git-send-email-tissoire@cena.fr>
	<1268065277-30129-5-git-send-email-tissoire@cena.fr>
	<4B95255B.5010900@cena.fr>
	<alpine.LNX.2.00.1003081730170.17799@pobox.suse.cz>
	<4B952C77.3080505@cena.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:33150 "HELO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753798Ab0CHU16 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 8 Mar 2010 15:27:58 -0500
Received: by mail-vw0-f46.google.com with SMTP id 9so3172825vws.33
        for <linux-input@vger.kernel.org>; Mon, 08 Mar 2010 12:27:46 -0800 (PST)
In-Reply-To: <4B952C77.3080505@cena.fr> (Benjamin Tissoires's message of "Mon,
	08 Mar 2010 17:57:27 +0100")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <tissoire@cena.fr>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Stephane Chatty <chatty@enac.fr>

Benjamin Tissoires writes:

>>
>> Well ... I don't see any patch titled "HID: deletion of unused code in
>> hid-magicmouse" neither in my inbox nor in my linux-input@ folder. Could
>> you perhaps please resend?
>>
>> Thanks,
>>
>
> Of course, I attached it. Do I need to send it in mbox format or is it ok ?
>
> Cheers,
> Benjamin

The recommended practice for sending patches is (from
Documentation/SubmittingPatches) "7) No MIME, no links, no compression,
no attachments.  Just plain text."

I'm a bit mystified, though -- if magicmouse_setup_input() is from "the
old implementation", where is the new implementation?  Jiri's
hid/for-next and hid/master trees definitely use the input device that
it sets up.  The "magicmouse_input_mapping" function that shows up at
the end of your patch doesn't exist in those trees.  The reason I didn't
use input_mapping() initially was because it only allows setting up one
input field, and the touch records generate multiple types of events.

Michael Poole
