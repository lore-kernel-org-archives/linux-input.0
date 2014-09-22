From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2] hid: sony: Set touchpad bits in the input_configured
 callback
Date: Mon, 22 Sep 2014 16:05:24 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1409221604270.5523@pobox.suse.cz>
References: <1411089301-1546-1-git-send-email-frank.praznik@oh.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37498 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753574AbaIVOF0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Sep 2014 10:05:26 -0400
In-Reply-To: <1411089301-1546-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>
Cc: linux-input@vger.kernel.org

On Thu, 18 Sep 2014, Frank Praznik wrote:

> Set the DualShock4 touchpad bits in the input_configured callback
> so that they are registered properly for any input devices created
> during hid_hw_start.
> 
> Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>

Applied, thanks Frank.

-- 
Jiri Kosina
SUSE Labs
