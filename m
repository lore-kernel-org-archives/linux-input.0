From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 01/12] HID: wiimote: Add Nintendo Wii Remote driver
 stub
Date: Mon, 11 Jul 2011 14:36:18 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1107111435320.11049@pobox.suse.cz>
References: <1309866319-12899-1-git-send-email-dh.herrmann@googlemail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34746 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1749667Ab1GKMgU (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Jul 2011 08:36:20 -0400
In-Reply-To: <1309866319-12899-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org, padovan@profusion.mobi

On Tue, 5 Jul 2011, David Herrmann wrote:

> Add stub driver for the Nintendo Wii Remote. The wii remote uses
> the HID protocol to communicate with the host over bluetooth. Hence,
> add dependency for HIDP and place driver in hid subsystem.

David,

I have now queued the driver in my 'wiimote' branch.

So please, in the future, send any additional fixes against this branch 
(or linux-next, which will get this from my tree automatically).

Thanks a lot for your work on this driver,

-- 
Jiri Kosina
SUSE Labs
