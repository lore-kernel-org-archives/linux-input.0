From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 0/3] Balanced slots, attempt #2
Date: Tue, 31 Mar 2015 09:11:07 +0200
Message-ID: <551A488B.3060206@redhat.com>
References: <1427753368-2795-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49432 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752393AbbCaHLK (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 31 Mar 2015 03:11:10 -0400
In-Reply-To: <1427753368-2795-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Peter Hutterer <peter.hutterer@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On 31-03-15 00:09, Benjamin Tissoires wrote:
> Hi,
>
> So, it occurs that the balanced slots assignment introduced in v4.0 had some
> troubles and the Synaptics part was reverted.
> I tried to spend some time today to figure out a solution, and the only way
> I can get something from it is to add a band aid in input_mt_set_slots().
>
> It should not be very costly, but I think it is required: I can guarantee that
> the path is hit if the band aid is not here (pr_err was my friend).
>
> So the series is:
> - band aid
> - revert the revert
> - small fix in synaptics.c to keep the slots stable when landing a third finger.
>
> Cheers,
> Benjamin

The entire set looks good to me:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans
