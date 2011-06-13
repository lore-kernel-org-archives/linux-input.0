From: Derek Foreman <derek@collabora.co.uk>
Subject: Re: [PATCH 2/4] Input: Report defuzzed event once before filtering
 for devices with the INCONSISTENT_RATE property
Date: Mon, 13 Jun 2011 10:19:58 -0400
Message-ID: <4DF61C8E.3060708@collabora.co.uk>
References: <1307735704-30673-1-git-send-email-derek.foreman@collabora.co.uk> <1307735704-30673-3-git-send-email-derek.foreman@collabora.co.uk> <20110610205621.GB5925@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.128.226]:51502 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752719Ab1FMO1k (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Jun 2011 10:27:40 -0400
In-Reply-To: <20110610205621.GB5925@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Derek Foreman <derek.foreman@collabora.co.uk>, linux-input@vger.kernel.org

On 06/10/11 16:56, Henrik Rydberg wrote:
> On Fri, Jun 10, 2011 at 03:55:02PM -0400, Derek Foreman wrote:
>> Some input devices have a non-uniform report rate, which can make it difficult for a userspace driver to distinguish between a lack of motion or a lack of new input.
>>
>> With this patch, if multiple duplicate events (after defuzz) are received in a row, the first duplicate is posted to userspace.
>
> Every change is already propagated exactly once, which seems to amount
> to the same thing your patch is aiming at. The evdev event signifies
> the change itself (and when it occurs), so there is actually no
> difference between the lack of motion and the lack of input.

Hi Henrik,

Thank you for all your input.

The specific problem that this patch aims to solve is that a certain 
family of synaptics devices drops from 80Hz to 40Hz reporting when 2 or 
more fingers are on the pad.  As the screen refresh rate for a modern PC 
is generally 60Hz, input feels subjectively much less interactive.

It is possible - by maintaining a short history of past events and 
predicting where the cursor would be in the future - to do a reasonable 
job of creating 60Hz motion from this lower input rate.  This is where 
the difference between lack of motion and lack of input is key.

If I receive an event, then 1/80th of a second later I do NOT receive 
another one, I don't know whether the device has dropped to a lower 
reporting rate (lack of input), or whether the device reported the same 
event 2 times in a row, and the kernel "defuzz" code filtered it (lack 
of motion).

In the "lack of input" case, I want to fabricate a synthetic event to 
keep the pointer motion fluid.  In the "lack of motion" case, I want 
pointer motion to stop.

Currently, the kernel knows it has started to filter unchanging input, 
but userspace has no mechanism to detect that this filtering has begun. 
  As two identical events in a row is an impossibility in the face of 
the defuzz code, I had thought this would be a good way to expose this 
information without confusing any existing applications...

Thanks,
Derek
