From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 0/4 v4] input - wacom : USB Tablet PC support
Date: Mon, 7 Mar 2011 22:26:35 +0100
Message-ID: <20110307212635.GA20309@polaris.bitmath.org>
References: <1299532403-2861-1-git-send-email-pinglinux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:34005 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752815Ab1CGVYa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 7 Mar 2011 16:24:30 -0500
Content-Disposition: inline
In-Reply-To: <1299532403-2861-1-git-send-email-pinglinux@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

On Mon, Mar 07, 2011 at 01:13:23PM -0800, Ping Cheng wrote:
> Mainly to change the 1FGT devices to the existing touchscreen format and
> the 2FGT devices to MT format.
> 
> This is the final version with Henrik's "Reviewed-by" added in the patches.
> 
> Ping Cheng (4):
>   input : wacom - Remove 2FGT Tablet PC events in TAP format
>   input - wacom : process pen data in its own routine
>   input - wacom : support one finger touch the touchscreen way
>   input - wacom: Support 2FGT in MT format
> 
>  drivers/input/tablet/wacom_sys.c |   12 +-
>  drivers/input/tablet/wacom_wac.c |  247 ++++++++++++++------------------------
>  drivers/input/tablet/wacom_wac.h |    6 +-
>  3 files changed, 99 insertions(+), 166 deletions(-)

Thanks!
Henrik
