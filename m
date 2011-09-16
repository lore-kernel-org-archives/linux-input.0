From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 0/3] Input: wacom bamboo improvements
Date: Fri, 16 Sep 2011 13:32:11 +0200
Message-ID: <20110916113211.GA4623@polaris.bitmath.org>
References: <1316050588-13473-1-git-send-email-chris@cnpbagwell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-h22.telenor.se ([195.54.99.197]:40382 "EHLO
	smtprelay-h22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073Ab1IPL21 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Sep 2011 07:28:27 -0400
Received: from ipb1.telenor.se (ipb1.telenor.se [195.54.127.164])
	by smtprelay-h22.telenor.se (Postfix) with ESMTP id C0C84C11F
	for <linux-input@vger.kernel.org>; Fri, 16 Sep 2011 13:28:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1316050588-13473-1-git-send-email-chris@cnpbagwell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: chris@cnpbagwell.com
Cc: linux-input@vger.kernel.org, pinglinux@gmail.com

Hi Chris,

On Wed, Sep 14, 2011 at 08:36:25PM -0500, chris@cnpbagwell.com wrote:
> From: Chris Bagwell <chris@cnpbagwell.com>
> 
> The need for patch 3 was recently discussed on linuxwacom
> mailing list. During that discussion, I looked closer at pen
> code and notice pressure cleanup needed (patch 1) and that
> ABS_DISTANCE was not completely implemented (patch 2).
> 
> Chris Bagwell (3):
>   Input: wacom - remove unneeded touch pressure init
>   Input: wacom - add ABS_DISTANCE to Bamboo Pen reports
>   Input: wacom - correct max Y value on medium bamboos
> 
>  drivers/input/tablet/wacom_wac.c |   47 +++++++++++++++++++++-----------------
>  1 files changed, 26 insertions(+), 21 deletions(-)
> 
> -- 
> 1.7.6

    Reviewed-by: Henrik Rydberg <rydberg@euromail.se>

on all three patches.

Thanks,
Henrik
