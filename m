From: Mario Limonciello <mario_limonciello@dell.com>
Subject: Re: [PATCH] Add a quirk for the Dell XPS 13 (2015) when in PS/2 mode.
Date: Thu, 19 Feb 2015 12:16:51 -0600
Message-ID: <54E62893.1060806@dell.com>
References: <1424310180-2512-1-git-send-email-mario_limonciello@dell.com> <20150219171639.GB11113@dtor-glaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from AUSXIPPC110.us.dell.com ([143.166.85.200]:44358 "EHLO
	ausxippc110.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595AbbBSShb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Feb 2015 13:37:31 -0500
In-Reply-To: <20150219171639.GB11113@dtor-glaptop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Dmitry,

On 02/19/2015 11:16 AM, Dmitry Torokhov wrote:
>
> What kind of glitch is this? Is there a certain pattern to it? Even if we do
> not reset the mouse the logs will be full of error messages.
>
> Thanks.
>
 From waveform capture data leaving the touchpad is valid, but when it is resent through the EC it's getting corrupted.  This isn't exclusive to Linux setting it up wrong or anything, it also happens on Windows.  On Windows 7 the touchpad driver does not issue a reset from the bad data however.

The glitch is more prevalent as the machine is turned on but seems to go away after it's been running a while.  We currently don't believe it to be a problem with the EC firmware, but we are still exploring other firmware based solutions.

Yes, the logs do fill up with error messages about the bad data within the first few minutes of usage.  In my opinion not freezing but getting errors in the log is better than freezing and getting errors in the log, so we're at least trying to provide a workaround for the problem.  If we come up with a firmware based solution I'd be happy to adjust or remove this later.

Thanks,
