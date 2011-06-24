From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 01/12 v2] HID: wiimote: Add Nintendo Wii Remote driver
 stub
Date: Fri, 24 Jun 2011 14:14:51 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1106241414000.11049@pobox.suse.cz>
References: <1308322162-13953-1-git-send-email-dh.herrmann@googlemail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:59157 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753772Ab1FXMOx (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Jun 2011 08:14:53 -0400
In-Reply-To: <1308322162-13953-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org, padovan@profusion.mobi, oliver@neukum.org

On Fri, 17 Jun 2011, David Herrmann wrote:

> Add stub driver for the Nintendo Wii Remote. The wii remote uses
> the HID protocol to communicate with the host over bluetooth. Hence,
> add dependency for HIDP and place driver in hid subsystem.

Hi David,

thanks a lot for writing the driver.

I have gone through the driver, and I like it and am willing to merge it.

The only thing I'd like to ask you -- could you please put a comment into 
the code preceeding all the barrier operations, so that it's clear why 
they have to be there?

Thanks,

-- 
Jiri Kosina
SUSE Labs
