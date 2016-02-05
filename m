From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: Check whether if the hidraw is NULL pointer before
 release.
Date: Fri, 5 Feb 2016 14:33:22 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1602051431380.22727@cbobk.fhfr.pm>
References: <1454395789-13507-1-git-send-email-shenpengru@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454395789-13507-1-git-send-email-shenpengru@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: shenpengru@gmail.com
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, shenpengru <shenpengru@xiaomi.com>
List-Id: linux-input@vger.kernel.org

On Tue, 2 Feb 2016, shenpengru@gmail.com wrote:

> From: shenpengru <shenpengru@xiaomi.com>
> 
> The logic of service which operate hidraw device in user-space may
> not correct, sometimes it may release hidraw dev for more than once.
> In order to prevent this situation, we need to make the driver more
> robust.

Hmm .. how would you call close(fd) twice on the same descriptor and let 
it pass fput()?

I'd like to better understand how we ended up in this situation. Could you 
please provide more details?

Thanks a lot,

-- 
Jiri Kosina
SUSE Labs
