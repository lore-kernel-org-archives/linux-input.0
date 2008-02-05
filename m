From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [PATCH] Driver for VoIP CM109 Chipset
Date: Tue, 5 Feb 2008 22:23:25 +0000
Message-ID: <200802052223.26399.carlos@strangeworlds.co.uk>
References: <47A8D792.80701@db.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host-240-152.cust.aaawireless.net ([216.23.240.152]:33583 "EHLO
	mail.slackadelic.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1760074AbYBEWae (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Feb 2008 17:30:34 -0500
In-Reply-To: <47A8D792.80701@db.org>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Alfred E. Heggestad" <aeh@db.org>
Cc: dtor@mail.ru, linux-input@vger.kernel.org

Two minor nitpicks.

On Tuesday 05 February 2008 21:39:30 Alfred E. Heggestad wrote:
> +/*
> + * drivers/input/misc/cm109.c

Don't put the filename in the source file - this is now generally frowned 
upon. Instead, replace that with a title/ short description for the driver.

e.g. Move this line up instead to the top, rather than burying it under the 
copyright notice:

Driver for the VoIP USB phones with CM109 chipsets.

> + * History:
> + *   20080205 alfredh	Upgrade to 2.6.24
> + *   20070829 alfredh	Added keymap for Genius G-talk (thanks Shaun)
> + *   20070826 alfredh	2.6.22.5, added to blacklist in hid-quirks.c
> + *   20070626 alfredh	2.6.22-rc6, linux-input peer review
> + *   20070616 alfredh	Adapt for kernel 2.6.22-rc4
> + *   20070615 alfredh	Change GFP_KERNEL -> GFP_ATOMIC
> + *   20070610 alfredh	Buzzer through input SND_TONE/SND_BELL
> + *   20070227 alfredh	Draft version with keyboard scan and buzzer

ChangeLog's/ history should go in the commit message, not the code. It's the 
job of the revision control system to maintain the history of the code, not 
the codes job.

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
