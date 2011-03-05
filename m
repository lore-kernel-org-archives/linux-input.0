From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 0/4 v3] input - wacom : USB Tablet PC support
Date: Sat, 5 Mar 2011 09:57:11 +0100
Message-ID: <20110305085711.GA14886@polaris.bitmath.org>
References: <1299024961-8465-1-git-send-email-pinglinux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:58410 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750933Ab1CEIy4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 5 Mar 2011 03:54:56 -0500
Content-Disposition: inline
In-Reply-To: <1299024961-8465-1-git-send-email-pinglinux@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Ping,

On Tue, Mar 01, 2011 at 04:16:01PM -0800, Ping Cheng wrote:
> Mainly to change the 1FGT devices to the existing touchscreen format and
> the 2FGT devices to MT format.
> 
> Patches 3 and 4 are at v3. They are updated with Henrik's review comments.
> Patches 1 and 2 are the original ones. To make it easy to review the whole
> set, all four are resent together.
> 
> Ping Cheng (4):
>   input : wacom - Remove 2FGT Tablet PC events in TAP format
>   input - wacom : process pen data in its own routine
>   input - wacom : support one finger touch the touchscreen way
>   input - wacom: Support 2FGT in MT format
> 
>  drivers/input/tablet/wacom_sys.c |   12 +-
>  drivers/input/tablet/wacom_wac.c |  246 +++++++++++++++-----------------------
>  drivers/input/tablet/wacom_wac.h |    6 +-
>  3 files changed, 103 insertions(+), 161 deletions(-)

I believe we are almost there now, thanks for making the change.  With
the nitpicks of the third patch corrected,

Reviewed-by: Henrik Rydberg <rydberg@euromail.se>

Thank you.
Henrik
