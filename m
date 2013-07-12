From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID : core : fix hid delimiter local tag parsing.
Date: Fri, 12 Jul 2013 12:40:43 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1307121240040.29788@pobox.suse.cz>
References: <4754ed7e96bbb6e75d5b61d3997ce8e5@sybille.onecert.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:54968 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757710Ab3GLKkp (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Jul 2013 06:40:45 -0400
In-Reply-To: <4754ed7e96bbb6e75d5b61d3997ce8e5@sybille.onecert.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: pchavent <Paul.Chavent@onera.fr>
Cc: linux-input@vger.kernel.org, paul.chavent@fnac.net

On Sun, 7 Jul 2013, pchavent wrote:

> When i plug an USB HID device with the DELIMITER tag in its report 
> descriptor, the device doesn't load.
> 
> The problem comes from the "return 1" in the DELIMITER switch of the local
> tags parsing.
> 
> I join a trivial patch that return no error when encounter the DELIMITER tag.
> 
> Please review it.

Interesting; apparently this bug has been there for ages. Please send me 
your Signed-off-by: line as documented in Documentation/SubmittingPatches 
so that I can queue your patch.

Thanks,

-- 
Jiri Kosina
SUSE Labs
