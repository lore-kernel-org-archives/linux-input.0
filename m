From: Derek Foreman <derek@collabora.co.uk>
Subject: Re: [PATCH 4/4] Input: Synaptics: Add INPUT_PROP_SYNAPTICS_T3R2 property
Date: Mon, 13 Jun 2011 10:36:54 -0400
Message-ID: <4DF62086.3040800@collabora.co.uk>
References: <1307735704-30673-1-git-send-email-derek.foreman@collabora.co.uk> <1307735704-30673-5-git-send-email-derek.foreman@collabora.co.uk> <20110610211353.GD5925@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.128.226]:57353 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125Ab1FMOhF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Jun 2011 10:37:05 -0400
In-Reply-To: <20110610211353.GD5925@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Derek Foreman <derek.foreman@collabora.co.uk>, linux-input@vger.kernel.org

On 06/10/11 17:13, Henrik Rydberg wrote:
> On Fri, Jun 10, 2011 at 03:55:04PM -0400, Derek Foreman wrote:
>> This new property indicates that the trackpad is able to track more than two contacts, but can only report the positions of two contacts due to bus bandwidth limitations.
>>
>> Signed-off-by: Derek Foreman<derek.foreman@collabora.co.uk>
>> ---
>>   drivers/input/mouse/synaptics.c |    3 +++
>>   include/linux/input.h           |    1 +
>>   2 files changed, 4 insertions(+), 0 deletions(-)
>
> This information is already contained in INPUT_PROP_SEMI_MT, together
> with the use of BTN_TRIPLETAP. Please check
> Documentation/input/event-codes.txt for further details.

I really sorry, but I don't understand how this provides the same 
information.

INPUT_PROP_SEMI_MT, at least according to input.h specifies that the 
device reports a rectangle only, and not accurate touch co-ordinates.

BTN_TOOL_TRIPLETAP indicates that there are 3 fingers on the pad.


My intent was to indicate to userspace that the device is reporting 
co-ordinates like certain synaptics devices do:

3 fingers are accurately tracked
2 fingers are accurately (not bounding box) reported

Further, all the idiosyncrasies of the synaptics method of reporting apply:
The device has 3 "slots" for tracking data, and once they are all 
filled, it reports slots 1 and 3.  If the slot 1 contact is lifted, 
slots 2 and 3 will report.  If a third finger is once again added to the 
pad, it will become the new slot 1.

INPUT_PROP_SEMI_MT is actually inaccurate for these devices, and in 
retrospect, the bounding box patch should have removed that bit from the 
properties of the devices it applies to.
