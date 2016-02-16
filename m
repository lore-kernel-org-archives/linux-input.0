From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 0/6] HID: wacom: cleanup
Date: Tue, 16 Feb 2016 20:42:00 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1602162041450.22700@cbobk.fhfr.pm>
References: <1455294465-13694-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33781 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932479AbcBPTmD (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Feb 2016 14:42:03 -0500
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

Applied to for-4.6/wacom. Thanks,

-- 
Jiri Kosina
SUSE Labs

