From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: wacom - PAD is independent with pen/touch
Date: Wed, 26 Nov 2014 10:44:15 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1411261044000.23174@pobox.suse.cz>
References: <1416529872-3128-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:35063 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751402AbaKZJoE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 26 Nov 2014 04:44:04 -0500
In-Reply-To: <1416529872-3128-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, benjamin.tissoires@gmail.com, Ping Cheng <pingc@wacom.com>

On Thu, 20 Nov 2014, Ping Cheng wrote:

> PAD can be on pen interface (Intuos Pro and Cintiq series) or touch
> interface (Bamboo PT and Intuos PT series) or its own interface
> (Bamboo pen-only and Intuos Pen M/S). We need to mark it independently.
> 
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> Reviewed-by:  Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied to for-3.19/wacom.

-- 
Jiri Kosina
SUSE Labs
