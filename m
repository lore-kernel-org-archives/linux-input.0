From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: sony: Add force feedback support for Dualshock3
 USB
Date: Mon, 11 Nov 2013 11:26:58 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1311111126500.7751@pobox.suse.cz>
References: <1384021557-24106-1-git-send-email-sven@narfation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:53480 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752808Ab3KKK1C (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Nov 2013 05:27:02 -0500
In-Reply-To: <1384021557-24106-1-git-send-email-sven@narfation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sven Eckelmann <sven@narfation.org>
Cc: linux-input@vger.kernel.org, Colin Leitner <colin.leitner@gmail.com>

On Sat, 9 Nov 2013, Sven Eckelmann wrote:

> Sony Dualshock 3 controllers have two motors which can be used to provide
> simple force feedback rumble effects. The right motor is can be used to create
> a weak rumble effect but does not allow to set the force. The left motor is
> used to create a strong rumble effect with adjustable intensity.
> 
> The state of both motors can be changed using HID_OUTPUT_REPORT packets and
> have no timing information. FF memless is used to keep track of the timing and
> the sony driver just generates the necessary URBs.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
