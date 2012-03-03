From: Tai-hwa Liang <avatar@sentelic.com>
Subject: Re: [PATCH 0/5] Input: sentelic - multiple finger output support
Date: Sat, 3 Mar 2012 11:22:40 +0800 (CST)
Message-ID: <1203031120036.23561@cnaqrzbavhz.fragryvp.pbz>
References: <1329918757-16128-1-git-send-email-avatar@sentelic.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hermod.sentelic.com ([203.69.18.19]:15767 "EHLO
	hermod.sentelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259Ab2CCDWq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 2 Mar 2012 22:22:46 -0500
In-Reply-To: <1329918757-16128-1-git-send-email-avatar@sentelic.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Wed, 22 Feb 2012, Tai-hwa Liang wrote:
> Hi,
>
> This patch set (against for-linus) is intended to add support for newer
> Sentelic FSP(hardware revision Cx/Dx).  The relative coordinates output
> mode is retained for supporting older hardware(prior to Cx release).
>
> Tai-hwa Liang (5):
>  Input: sentelic - code refactorying for upcoming new hardware support
>  Input: sentelic - enabling absolute coordinates output for newer
>    hardware
>  Input: sentelic - enabling hardware supported gesture ID output
>  Input: sentelic - minor code cleaning up
>  Input: sentelic: improving packet debugging information
>
> drivers/input/mouse/sentelic.c |  291 ++++++++++++++++++++++++++++++++-------
> drivers/input/mouse/sentelic.h |  108 +++++++++++++++-
> 2 files changed, 344 insertions(+), 55 deletions(-)

Hi Dmitry,

   By any chance would you please take a look at this patch set?

Thanks,

Tai-hwa Liang
