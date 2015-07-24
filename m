From: Jiri Kosina <jkosina@suse.com>
Subject: Re: [PATCH v2] HID: microsoft: Add Surface 3 type cover
Date: Fri, 24 Jul 2015 14:54:18 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1507241454000.1141@pobox.suse.cz>
References: <1437334518-17991-1-git-send-email-stephenjust@gmail.com> <1437621100-9620-1-git-send-email-stephenjust@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [89.191.203.168] ([89.191.203.168]:49167 "EHLO
	mail.emea.novell.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752127AbbGXMyU (ORCPT
	<rfc822;groupwise-linux-input@vger.kernel.org:0:0>);
	Fri, 24 Jul 2015 08:54:20 -0400
In-Reply-To: <1437621100-9620-1-git-send-email-stephenjust@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephen Just <stephenjust@gmail.com>
Cc: linux-input@vger.kernel.org

On Wed, 22 Jul 2015, Stephen Just wrote:

> Adding support for the Microsoft Surface 3 (non-pro) Type Cover.
> 
> The existing definitions and quirks are actually for the Surface
> Pro 3 type covers. I've renamed the old constants to reflect that
> they belong to the Surface Pro 3, and added a new constant and
> matching code for the Surface 3.
> 
> Signed-off-by: Stephen Just <stephenjust@gmail.com>

Applied to for-4.3/microsoft branch. Thanks,

-- 
Jiri Kosina
SUSE Labs
