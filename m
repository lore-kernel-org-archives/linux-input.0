From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: quirks: add MULTI_INPUT quirk for Dragonrise GameCube
 adapter
Date: Sun, 4 Oct 2015 23:06:40 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1510042306110.2758@pobox.suse.cz>
References: <4642064.DtyDCjyYx4@goron>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46680 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751801AbbJDVGk (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 4 Oct 2015 17:06:40 -0400
In-Reply-To: <4642064.DtyDCjyYx4@goron>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Rodland <andrew@cleverdomain.org>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Sat, 3 Oct 2015, Andrew Rodland wrote:

> This device (aka Mayflash GameCube Adapter) has 4 controller ports, and 
> without the quirk they all become one very large joystock device. With the 
> quirk they're recognized as 4 separate joysticks.
> 
> Signed-off-by: Andrew Rodland <andrew@cleverdomain.org>

Andrew,

your patch has been corrupted by your mailer (line wrapped). Could you 
please fix this up on your side and resend?

Thanks,

-- 
Jiri Kosina
SUSE Labs

