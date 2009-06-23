From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid: Support new variants of Samsung USB IR receiver
 (0419:0001)
Date: Tue, 23 Jun 2009 11:30:39 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0906231127470.7457@wotan.suse.de>
References: <4A400C41.9080103@yahoo.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:36655 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751719AbZFWJag (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Jun 2009 05:30:36 -0400
In-Reply-To: <4A400C41.9080103@yahoo.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Robert Schedel <r.schedel@yahoo.de>
Cc: linux-input@vger.kernel.org

On Tue, 23 Jun 2009, Robert Schedel wrote:

> This patch extends the existing Samsung IrDA (0419:0001) quirk file with newly reported variants:

> * New device variants with 203 byte and 135 byte report descriptors were 
>   reported to be recognized incorrectly. This patch adds an 
>   autodetection for those two, using report descriptor size to enable 
>   new quirks.
[ ... ] 
> As you see, the patch differentiates the variants via descriptor size, 
> due to a lack of any other differing fields.

Oh my, what a mess.

Thanks for debugging this, I have applied your patch to my tree.

-- 
Jiri Kosina
SUSE Labs
