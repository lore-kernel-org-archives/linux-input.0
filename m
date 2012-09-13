From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: input_to_handler: unable to handle kernel NULL pointer
 dereference
Date: Thu, 13 Sep 2012 08:57:38 -0700
Message-ID: <20120913155738.GA3519@core.coreip.homeip.net>
References: <5051F648.8030003@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52185 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758220Ab2IMP5x (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Sep 2012 11:57:53 -0400
Content-Disposition: inline
In-Reply-To: <5051F648.8030003@suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: linux-input@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>, LKML <linux-kernel@vger.kernel.org>, Jiri Slaby <jirislaby@gmail.com>

On Thu, Sep 13, 2012 at 05:05:44PM +0200, Jiri Slaby wrote:
> Hi,
> 
> -next commit "Input: Send events one packet at a time" seems like broke
> the input layer:

Right, Henrik has a patch for this.

Thanks.

-- 
Dmitry
