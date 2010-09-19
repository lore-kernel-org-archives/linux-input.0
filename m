From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: uinput: Setup MT usage during device creation
Date: Sun, 19 Sep 2010 16:32:53 -0700
Message-ID: <20100919233252.GC6565@core.coreip.homeip.net>
References: <1284897253-1634-1-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:61028 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755274Ab0ISXc7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 19 Sep 2010 19:32:59 -0400
Content-Disposition: inline
In-Reply-To: <1284897253-1634-1-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Sep 19, 2010 at 01:54:13PM +0200, Henrik Rydberg wrote:
> The input devices created by uinput do not currently handle multitouch
> properly. All events will appear as if they came from slot zero, and
> the input event buffers are not adjusted. This patch creates the MT
> slots during setup, and sets the number of events per packet based
> on the MT usage.
> 
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>

Applied to 'for-linus', thank you Henrik.

-- 
Dmitry
