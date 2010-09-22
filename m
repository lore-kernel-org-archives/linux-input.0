From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] USB: HID: Add support for Logitech Speed Force Wireless
 gaming wheel
Date: Wed, 22 Sep 2010 13:32:03 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1009221323270.26813@pobox.suse.cz>
References: <1285131753-28572-1-git-send-email-simon@mungewell.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:40426 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751284Ab0IVLcH (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Sep 2010 07:32:07 -0400
In-Reply-To: <1285131753-28572-1-git-send-email-simon@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon <simon@mungewell.org>
Cc: linux-input@vger.kernel.org, bonbons@linux-vserver.org, chatty@enac.fr, dhprince-devel@yahoo.co.uk, erazor_de@users.sourceforge.net, dtor@mail.ru, LordCnidarian@gmail.com, lcastelli@gmail.com, sam@ravnborg.org, mmarek@suse.cz

On Tue, 21 Sep 2010, simon@mungewell.org wrote:

> From: simon <simon@mungewell.org>
> 
> The following patch adds support for the Logitech Speed Force Wireless
> gaming wheel. Originally designed for the WII console but it has been
> reverse engineered, details:
> http://wiibrew.org/wiki/Logitech_USB_steering_wheel
> 
> This patch relies on previous patch:
> "Don't Send Feature Reports on Interrupt Endpoint"
> https://patchwork.kernel.org/patch/198112/
> 
> Logitech as produce a very similar wheel for the PS2/PS3, it is
> expected that this patch could also support the PS2/PS3 wheel if the
> USB ID's are added and (if required) the HID descriptor is modified.

I have reworded the Changelog a little bit, and applied. Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
