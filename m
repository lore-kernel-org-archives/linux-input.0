From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/5 #2] HID: move pantherlord FF processing
Date: Thu, 18 Sep 2008 19:29:10 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0809181925050.4671@pegasus.suse.cz>
References: <1221733414-26924-1-git-send-email-jirislaby@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:34554 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754110AbYIRR2x (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Sep 2008 13:28:53 -0400
In-Reply-To: <1221733414-26924-1-git-send-email-jirislaby@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-input@vger.kernel.org, anssi.hannula@gmail.com, linux-kernel@vger.kernel.org

On Thu, 18 Sep 2008, Jiri Slaby wrote:

> +config HID_PANTHERLORD
> +	tristate "Pantherlord"
> +	default m
> +	depends on USB_HID
> +	---help---
> +	Support for PantherLord/GreenAsia based device support (including
> +	force feedback).

This comment is a little bit misleading -- it says that 
CONFIG_HID_PANTHERLORD includes force feedback support, but you have to 
turn that on explicitly by:

> +config PANTHERLORD_FF
> +	bool "Force feedback support"

Also, mentioning "Pantherlord" here might make things more clear, this way 
it looks like this enables generic force feedback.

I will fix that up in the patchset, if you don't mind, and apply.

-- 
Jiri Kosina
SUSE Labs
