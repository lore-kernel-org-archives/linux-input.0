From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Add i8042.nopnp for Intel D845PESV
Date: Tue, 27 May 2008 11:22:30 -0400
Message-ID: <20080527112145.ZZRA012@mailhub.coreip.homeip.net>
References: <Pine.LNX.4.64.0805271710240.6718@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.242]:17398 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752629AbYE0PWd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 May 2008 11:22:33 -0400
Received: by an-out-0708.google.com with SMTP id d40so532411and.103
        for <linux-input@vger.kernel.org>; Tue, 27 May 2008 08:22:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0805271710240.6718@jikos.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

On Tue, May 27, 2008 at 05:15:56PM +0200, Jiri Kosina wrote:
> From: Jiri Kosina <jkosina@suse.cz>
> 
> Input: Add i8042.nopnp for Intel D845PESV
> 
> This patch introduces i8042_dmi_nopnp_table to make it possible to perform 
> DMI matches for systems that need 'i8042.nopnp' to work correctly, and 
> introduces such an entry for Intel D845PESV -- this system doesn't 
> detect PS2 mouse reliably without this option, as reported by Robert 
> Lewis.
> 

Hmm, could I see a dmesg for it by any chance?

-- 
Dmitry
