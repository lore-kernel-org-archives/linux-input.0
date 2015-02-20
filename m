From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Add a quirk for the Dell XPS 13 (2015) when in PS/2 mode.
Date: Fri, 20 Feb 2015 10:47:17 -0800
Message-ID: <20150220184717.GC20060@dtor-glaptop>
References: <1424310180-2512-1-git-send-email-mario_limonciello@dell.com>
 <20150219171639.GB11113@dtor-glaptop>
 <54E62893.1060806@dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:37782 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754214AbbBTSrV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Feb 2015 13:47:21 -0500
Content-Disposition: inline
In-Reply-To: <54E62893.1060806@dell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mario Limonciello <mario_limonciello@dell.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>

Hi Mario,

On Thu, Feb 19, 2015 at 12:16:51PM -0600, Mario Limonciello wrote:
> Hi Dmitry,
> 
> On 02/19/2015 11:16 AM, Dmitry Torokhov wrote:
> >
> >What kind of glitch is this? Is there a certain pattern to it? Even if we do
> >not reset the mouse the logs will be full of error messages.
> >
> >Thanks.
> >
> From waveform capture data leaving the touchpad is valid, but when it is
> resent through the EC it's getting corrupted.  This isn't exclusive to Linux
> setting it up wrong or anything, it also happens on Windows.  On Windows 7
> the touchpad driver does not issue a reset from the bad data however.
>
> The glitch is more prevalent as the machine is turned on but seems to go away
> after it's been running a while.  We currently don't believe it to be a
> problem with the EC firmware, but we are still exploring other firmware based
> solutions.

Can it be related to ther Dell models (Latitudes with ALPS touchpad) also
sending junk data under certain conditions (adding Pali to teh CC as he was
looking at this issue)?

> 
> Yes, the logs do fill up with error messages about the bad data within the
> first few minutes of usage.  In my opinion not freezing but getting errors in
> the log is better than freezing and getting errors in the log, so we're at
> least trying to provide a workaround for the problem.  If we come up with a
> firmware based solution I'd be happy to adjust or remove this later.

I am not saying we do not need the solution, I am wondering if we can suppress
errors altogether. I am also curious why reset does not work as it should
reinitialize the driver completely.

And even if you do fix the firmware majority of users will still need the
software solution as updating BIOS is not something that happens often.

Thanks.

-- 
Dmitry
