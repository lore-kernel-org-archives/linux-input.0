From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid: Support 171 byte variant of Samsung USB IR receiver
 (0419:0001)
Date: Fri, 11 Dec 2009 11:01:11 +0100 (CET)
Message-ID: <alpine.LNX.2.00.0912111101000.3755@pobox.suse.cz>
References: <4B218627.7050006@yahoo.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:56042 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754086AbZLKKBG (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Dec 2009 05:01:06 -0500
In-Reply-To: <4B218627.7050006@yahoo.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Robert Schedel <r.schedel@yahoo.de>
Cc: linux-input@vger.kernel.org

On Fri, 11 Dec 2009, Robert Schedel wrote:

> Extends the existing Samsung USB IrDA (0419:0001) quirk with newly 
> reported 171 byte variant. Refactors duplicate trace call into local 
> helper function.

Applied, thanks Robert.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
