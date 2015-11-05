From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] HID: wacom: Call 'wacom_query_tablet_data' only after
 'hid_hw_start'
Date: Thu, 5 Nov 2015 11:35:43 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1511051135240.22567@pobox.suse.cz>
References: <CAF8JNhLjUCmQ30+fQG7_a0xHr6kCG-Kq_-q8T_8T90gs2qLPMw@mail.gmail.com> <1446598678-1908-1-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44749 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031084AbbKEKfn (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 5 Nov 2015 05:35:43 -0500
In-Reply-To: <1446598678-1908-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jason Gerecke <jason.gerecke@wacom.com>

On Tue, 3 Nov 2015, Jason Gerecke wrote:

> When connecting the Cintiq Companion 2 as an external tablet (i.e., using
> it in "hybrid" mode) it has been seen to cause the kernel of the machine
> it is connected to to Oops. The cause has been traced to us attempting to
> switch the tablet's mode prior to actually starting HID device (resulting
> in the eventual dereference of the uninitialized control URB).
> 
> Commit 3b164a0 moved the mode switch from occuring post-start to occurring
> pre-start. The change was not seen to cause issues largely due to the fact
> that most devices mode switch with 'hid_hw_raw_request' (which is safe to
> call prior to start) rather than 'hid_hw_request'.
> 
> Moving the call back to its original location resolves the issue, but
> causes some touch-only Bamboo tablets (e.g. 056a:00d0) to stop working.
> The affected tablets require us to perform a mode switch on their
> vestigial pen interface prior ignoring with -ENODEV, meaning that the
> code which is responsible for doing the ignoring has to move as well.
> 
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
> ---
> Jiri,
> 
> Ping clued me in to the fact that 'wacom_query_tablet_data' hasn't always 
> been in this problematic location. The offending commit mentioned in the 
> revised commit summary is queued for 4.4, so this only needs to get into 
> the next RC rather than be targeted for stable.

Queued as super-late patch into for-4.4/wacom.

-- 
Jiri Kosina
SUSE Labs

