From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: usbtouchscreen: Add support for Zytronic capacitive touchscreen
Date: Mon, 23 Nov 2009 09:21:53 -0800
Message-ID: <20091123172153.GC17813@core.coreip.homeip.net>
References: <20091123143952.590982333@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f204.google.com ([209.85.216.204]:34487 "EHLO
	mail-px0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752674AbZKWRVx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Nov 2009 12:21:53 -0500
Received: by pxi42 with SMTP id 42so3442865pxi.5
        for <linux-input@vger.kernel.org>; Mon, 23 Nov 2009 09:21:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091123143952.590982333@fluff.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ben Dooks <ben@simtec.co.uk>
Cc: linux-input@vger.kernel.org, daniel.ritz@gmx.ch, ddstreet@ieee.org, floe@butterbrot.org, jim-linux@nurd.se, Daniel Silverstone <dsilvers@simtec.co.uk>, Vincent Sanders <vince@simtec.co.uk>, Simtec Linux Team <linux@simtec.co.uk>

On Mon, Nov 23, 2009 at 02:39:52PM +0000, Ben Dooks wrote:
> From: Daniel Silverstone <dsilvers@simtec.co.uk>
> 
> Zytronic USB-attached capacitive touchscreen support within
> the generic USB touchscreen driver.
> 

HHm, I already promised Daniel to merge this one... I wonder how I
managed to lose it. Anyways, changed 'irq_always' to be a bool and
it should be in 'next' branch now.

-- 
Dmitry
