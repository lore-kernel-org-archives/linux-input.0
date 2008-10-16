From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Input: Add Acer Aspire 5710 to nomux blacklist
Date: Thu, 16 Oct 2008 00:05:09 -0400
Message-ID: <20081016040509.GA16860@anvil.corenet.prv>
References: <alpine.LNX.1.10.0810141727020.26779@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.191]:45324 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773AbYJPEFP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Oct 2008 00:05:15 -0400
Received: by rn-out-0910.google.com with SMTP id k40so1395446rnd.17
        for <linux-input@vger.kernel.org>; Wed, 15 Oct 2008 21:05:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.10.0810141727020.26779@jikos.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Carlos Tonussi <tonussi@farmaco.ufsc.br>

On Tue, Oct 14, 2008 at 05:28:23PM +0200, Jiri Kosina wrote:
> From: Jiri Kosina <jkosina@suse.cz>
> 
> Acer Aspire needs to be added to nomux blacklist, otherwise the touchpad 
> misbehaves.
> 
> Reported-by: Carlos Tonussi <tonussi@farmaco.ufsc.br>
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>

Jiri,

I will hold off applying this patch pending testing EC patches.

-- 
Dmitry
