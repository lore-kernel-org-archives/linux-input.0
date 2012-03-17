From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: altera_ps2: Use of_match_ptr
Date: Fri, 16 Mar 2012 23:32:11 -0700
Message-ID: <20120317063211.GC20049@core.coreip.homeip.net>
References: <1331128087-7947-1-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:35270 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753128Ab2CQGcR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 17 Mar 2012 02:32:17 -0400
Received: by dajr28 with SMTP id r28so7179260daj.19
        for <linux-input@vger.kernel.org>; Fri, 16 Mar 2012 23:32:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1331128087-7947-1-git-send-email-tklauser@distanz.ch>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
Cc: linux-input@vger.kernel.org

On Wed, Mar 07, 2012 at 02:48:07PM +0100, Tobias Klauser wrote:
> Instead of having to define the match table to NULL if CONFIG_OF isn't
> set, use the of_match_ptr() macro which will do this for us.
> 

Applied, thank you.

-- 
Dmitry
