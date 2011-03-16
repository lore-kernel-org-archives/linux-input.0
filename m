From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: wm831x-ts - Ensure the controller is in a
 known state on open
Date: Tue, 15 Mar 2011 23:31:34 -0700
Message-ID: <20110316063134.GF14604@core.coreip.homeip.net>
References: <1300142701-22260-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:33107 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222Ab1CPGbj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Mar 2011 02:31:39 -0400
Received: by yxs7 with SMTP id 7so536315yxs.19
        for <linux-input@vger.kernel.org>; Tue, 15 Mar 2011 23:31:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1300142701-22260-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com

On Mon, Mar 14, 2011 at 10:45:00PM +0000, Mark Brown wrote:
> Explicitly set all the enable bits when opening the device just in case
> something left the device in an unexpected state.
> 

Applied, thank you Mark.

-- 
Dmitry
