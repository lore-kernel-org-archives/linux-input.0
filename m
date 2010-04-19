From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] Fixed missing inits in hid-cando.c
Date: Mon, 19 Apr 2010 13:20:53 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1004191320210.7579@pobox.suse.cz>
References: <20100416202358.7839695164@smtp.lii-enac.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:45412 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753580Ab0DSLUz (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Apr 2010 07:20:55 -0400
In-Reply-To: <20100416202358.7839695164@smtp.lii-enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephane Chatty <chatty@lii-enac.fr>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, priya.vijayan@intel.com, floe@butterbrot.org

On Fri, 16 Apr 2010, Stephane Chatty wrote:

> With flags non initialized, the single touch emulation has an erratic
> behavior. Fixed this.
> 
> Signed-off-by: Stephane Chatty

I have made this to actually be

	Signed-off-by: Stephane Chatty <chatty@lii-enac.fr>

and applied. Please let me know if this is wrong.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
