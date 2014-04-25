From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: atkbd - fix keyboard LG Electronics
Date: Thu, 24 Apr 2014 23:35:09 -0700
Message-ID: <20140425063509.GA10433@core.coreip.homeip.net>
References: <1398351432-5361-1-git-send-email-ssl@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:49661 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844AbaDYGfN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Apr 2014 02:35:13 -0400
Content-Disposition: inline
In-Reply-To: <1398351432-5361-1-git-send-email-ssl@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sheng-Liang Song <ssl@chromium.org>
Cc: linux-arm-kernel@lists.infradead.org, Shawn Nematbakhsh <shawnn@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Apr 24, 2014 at 07:57:12AM -0700, Sheng-Liang Song wrote:
> After issuing ATKBD_CMD_RESET_DIS, LG Keyboard stop working.  The
> workaround is to remove ATKBD_CMD_RESET_DIS for LG Keyboards.
> 
> In order to keep the minimum changes to the current atkbd driver, I add
> logic to apply the patch if and only if the device is LG LW25-B7HV or
> P1-J273B.
> 
> Signed-off-by: Sheng-Liang Song <ssl@chromium.org>

Applied, thank you.

-- 
Dmitry
