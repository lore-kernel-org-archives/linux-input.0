From: Benjamin Tissoires <tissoire@tls.cena.fr>
Subject: Re: [PATCH 3/3] HID: deletion of unused code in hid-magicmouse.
Date: Mon, 08 Mar 2010 21:51:36 +0100
Message-ID: <4B956358.80608@tls.cena.fr>
References: <1268065277-30129-1-git-send-email-tissoire@cena.fr>	<1268065277-30129-2-git-send-email-tissoire@cena.fr>	<1268065277-30129-3-git-send-email-tissoire@cena.fr>	<1268065277-30129-4-git-send-email-tissoire@cena.fr>	<1268065277-30129-5-git-send-email-tissoire@cena.fr>	<4B95255B.5010900@cena.fr>	<alpine.LNX.2.00.1003081730170.17799@pobox.suse.cz>	<4B952C77.3080505@cena.fr> <87sk8a36f4.fsf@troilus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hilar.cena.fr ([195.83.98.1]:37756 "EHLO hilar.tls.cena.fr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755288Ab0CHUvk (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 8 Mar 2010 15:51:40 -0500
In-Reply-To: <87sk8a36f4.fsf@troilus.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Poole <mdpoole@troilus.org>
Cc: Benjamin Tissoires <tissoire@cena.fr>, Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Stephane Chatty <chatty@enac.fr>

Sorry about that, I'm beginning in sending patch for the kernel. I tried 
to use the git send-email command, but I saw after that the command just 
send email to the people I added, but not the mailing list. To be sure 
to (re)send the last patch, I attached it to be sure to send it 
"correctly", but not according to the recommended practice.

I will resend the whole patch list to the mailing list.

The patch you told was not intended to be self-consistant but a final 
cleanup after the two patches I tried to send before. I splitted them 
like that in order to keep them human readable as git tried to intrelace 
the additions and removals, even if they were not related together.

Sorry again

Benjamin

On 03/08/2010 09:27 PM, Michael Poole wrote:
> Benjamin Tissoires writes:
>
>>>
>>> Well ... I don't see any patch titled "HID: deletion of unused code in
>>> hid-magicmouse" neither in my inbox nor in my linux-input@ folder. Could
>>> you perhaps please resend?
>>>
>>> Thanks,
>>>
>>
>> Of course, I attached it. Do I need to send it in mbox format or is it ok ?
>>
>> Cheers,
>> Benjamin
>
> The recommended practice for sending patches is (from
> Documentation/SubmittingPatches) "7) No MIME, no links, no compression,
> no attachments.  Just plain text."
>
> I'm a bit mystified, though -- if magicmouse_setup_input() is from "the
> old implementation", where is the new implementation?  Jiri's
> hid/for-next and hid/master trees definitely use the input device that
> it sets up.  The "magicmouse_input_mapping" function that shows up at
> the end of your patch doesn't exist in those trees.  The reason I didn't
> use input_mapping() initially was because it only allows setting up one
> input field, and the touch records generate multiple types of events.
>
> Michael Poole
