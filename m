From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 0/6] HID: wacom: cleanup
Date: Tue, 16 Feb 2016 18:14:20 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1602161813540.22700@cbobk.fhfr.pm>
References: <1455294465-13694-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54451 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933086AbcBPROW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Feb 2016 12:14:22 -0500
In-Reply-To: <1455294465-13694-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>, linux-kernel@vger.kernel.org

On Fri, 12 Feb 2016, Benjamin Tissoires wrote:

> While working on the wacom.ko driver, I ended up having those 6 patches that
> the current wacom.ko could benefit right now.
> 
> Besides cleaning, the only gain users will see is in patch 6 which allows to
> actually use the wireless receiver (for development) without having to
> unplug/replug it.

Looks good to me. Ping, Jason, can I please have your Ack on this?

Thanks,

-- 
Jiri Kosina
SUSE Labs

