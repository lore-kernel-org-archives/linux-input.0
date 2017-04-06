From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: wacom: Move wacom_remote_irq and
 wacom_remote_status_irq
Date: Thu, 6 Apr 2017 20:34:32 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1704061456020.28004@cbobk.fhfr.pm>
References: <20170331170205.28302-1-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49196 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933152AbdDFSef (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 6 Apr 2017 14:34:35 -0400
In-Reply-To: <20170331170205.28302-1-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

On Fri, 31 Mar 2017, Jason Gerecke wrote:

> These two functions awkwardly break up the otherwise-contiguous chunk of
> related Intuos IRQ functions with a 500 line tangent about the operation
> of the EKR. Their presence makes it difficult to read/navigate through the
> the Intuos code. Since there is no dependency between these functions, it
> is possible to simply move them down somewhat. This commit moves them
> to be after the final Intuos IRQ function.
> 
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>

As you wish ... :) Applied to for-4.12/wacom.

-- 
Jiri Kosina
SUSE Labs

