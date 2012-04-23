From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/2] HID: hid-lg4ff: Add support for G27 LEDs
Date: Mon, 23 Apr 2012 20:55:25 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1204232055140.1856@pobox.suse.cz>
References: <alpine.LNX.2.00.1204201156300.29484@pobox.suse.cz> <1335012076-26430-1-git-send-email-simon@mungewell.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57865 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753792Ab2DWSz1 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Apr 2012 14:55:27 -0400
In-Reply-To: <1335012076-26430-1-git-send-email-simon@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Wood <simon@mungewell.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Bauer <michael@m-bauer.org>, Michal Maly <madcatxster@gmail.com>

On Sat, 21 Apr 2012, Simon Wood wrote:

> This patch adds supports for controlling the LED 'tachometer' on
> the G27 wheel, via the LED subsystem.
> 
> The 5 LEDs are arranged from right (1=grn, 2=grn, 3=yel, 4=yel, 5=red)
> and 'mirrored' to the left (10 LEDs in total).
> 
> Signed-off-by: Simon Wood <simon@mungewell.org>

Both patches applied, thanks.

-- 
Jiri Kosina
SUSE Labs
