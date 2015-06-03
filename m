From: Henrik Rydberg <rydberg@bitmath.org>
Subject: Re: [PATCH] Input: bcm5974 - report highest finger pressure to Synaptics
Date: Wed, 03 Jun 2015 14:52:59 +0200
Message-ID: <556EF8AB.6090704@bitmath.org>
References: <1433332165-25342-1-git-send-email-linux@mattwhitlock.name> <556EF1F2.50907@bitmath.org> <119471698.ELkjzU3HSk@crushinator>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailrelay1.public.one.com ([91.198.169.124]:36214 "EHLO
	mailrelay1.public.one.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756294AbbFCMxE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Jun 2015 08:53:04 -0400
In-Reply-To: <119471698.ELkjzU3HSk@crushinator>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matt Whitlock <linux@mattwhitlock.name>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On 06/03/2015 02:31 PM, Matt Whitlock wrote:
> On Wednesday, 3 June 2015, at 2:24 pm, Henrik Rydberg wrote:
>>> This patch changes the report_synaptics_data() function so that it reports
>>> the highest touch_major and highest tool_major of any touching finger as
>>> ABS_PRESSURE and ABS_TOOL_WIDTH, respectively.
>>
>> I appreciate the problem, but I would much rather have bcm5974 converted
>> to use input_mt_report_pointer_emulation() instead. The emulation code
>> has been left as is for a long while, but this seems to be a good time
>> to convert it.
> 
> report_tp_state() calls input_mt_sync_frame(), which in turn calls input_mt_report_pointer_emulation() already. So does this mean that report_synaptics_data() can be removed entirely?
> 

The bcm5974 driver does not advertise ABS_MT_PRESSURE, and therefore
ABS_PRESSURE is not reported via input_mt_sync_frame(). Furthermore,
ABS_TOOL_WIDTH is not handled at all in input_mt_report_pointer_emulation().

To handle pressure automatically, one would need to advertise (and use)
ABS_MT_PRESSURE. There is a misnomer in the driver, let say for historical
reasons, so that ABS_MT_TOUCH_MAJOR gets reported in the ABS_PRESSURE field.
This is a bit of a problem, but quite solvable.

For tool width, it is hard to imagine ever being able to remove that
functionality completely. However, it can be transferred to
input_mt_report_pointer_emulation() instead, provided every user of that
function is analyzed for consequences and usage of ABS_MT_WIDTH_MAJOR.

It would be great to simply remove report_synaptics_data(), if possible,
retaining the precise behavior. Barring the bug, of course.

Thanks,
Henrik

