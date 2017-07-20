From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH RESEND] HID: wacom: Remove comparison of u8 mode with
 zero and simplify.
Date: Thu, 20 Jul 2017 15:43:36 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1707201543240.4705@cbobk.fhfr.pm>
References: <1499541948-3392-1-git-send-email-chris.gekas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42313 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934130AbdGTNni (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 20 Jul 2017 09:43:38 -0400
In-Reply-To: <1499541948-3392-1-git-send-email-chris.gekas@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christos Gkekas <chris.gekas@gmail.com>
Cc: Joe Perches <joe@perches.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, 8 Jul 2017, Christos Gkekas wrote:

> Variable mode in method wacom_show_remote_mode() is defined as u8, thus
> statement (mode >= 0) is always true and should be removed, simplifying
> the logic.
> 
> Signed-off-by: Christos Gkekas <chris.gekas@gmail.com>

Applied to for-4.14/wacom, thanks.

-- 
Jiri Kosina
SUSE Labs

