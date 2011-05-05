From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] ati_remote2: Return the error code from sysfs
 channel_mask store
Date: Wed, 4 May 2011 18:32:00 -0700
Message-ID: <20110505013159.GB28813@core.coreip.homeip.net>
References: <1304545588-22990-1-git-send-email-syrjala@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:41704 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746Ab1EEBcG (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 May 2011 21:32:06 -0400
Received: by pvg12 with SMTP id 12so751603pvg.19
        for <linux-input@vger.kernel.org>; Wed, 04 May 2011 18:32:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1304545588-22990-1-git-send-email-syrjala@sci.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ville Syrjala <syrjala@sci.fi>
Cc: linux-input@vger.kernel.org

On Thu, May 05, 2011 at 12:46:28AM +0300, Ville Syrjala wrote:
> If the channel_mask setup fails when configuring it through sysfs,
> return the error code to the caller instead of claiming success.
> 
> Signed-off-by: Ville Syrjala <syrjala@sci.fi>

Applied, thanks Ville.

-- 
Dmitry
