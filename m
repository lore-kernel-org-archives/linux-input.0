From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] USB HID Add support for F430 Force Feedback Wheel
Date: Mon, 29 Nov 2010 17:42:50 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1011291741510.981@pobox.suse.cz>
References: <1290577783-5756-1-git-send-email-simon@mungewell.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:54282 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752524Ab0K2Qmz (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Nov 2010 11:42:55 -0500
In-Reply-To: <1290577783-5756-1-git-send-email-simon@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Wood <simon@mungewell.org>
Cc: linux-input@vger.kernel.org, aorefice77@gmail.com, ospite@studenti.unina.it

On Tue, 23 Nov 2010, Simon Wood wrote:

> This patch adds USB IDs to enable force feedback on the Thrustmaster
> F430 wheel.
> 
> Antonio did the work, I just converted to git patch to include in Kernel.

Please always CC me on HID patches. Otherwise they might be processed very 
late, or lost completely. Thanks.

> Reported by: "Antonio Orefice" <aorefice77@gmail.com>

This should be Reported-by:

> Signed-off by: Simon Wood <simon@mungewell.org>

This should be Signed-off-by:

I have fixed those and applied the patch. Thanks.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
