From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid: gyration sleep button quirk
Date: Thu, 3 Jul 2008 18:17:58 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0807031816530.25376@jikos.suse.cz>
References: <1214929451-14515-1-git-send-email-dwalker@mvista.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:42425 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750985AbYGCQR7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 3 Jul 2008 12:17:59 -0400
In-Reply-To: <1214929451-14515-1-git-send-email-dwalker@mvista.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>
Cc: Philippe Troin <phil@fifi.org>, "Adolfo R. Brandes" <arbrandes@gmail.com>, linux-input@vger.kernel.org

On Tue, 1 Jul 2008, Daniel Walker wrote:

> This patch is based on one provided by Jiri Kosina to handle the sleep
> button. I just added some cleanup and integrated it into my series.
>
> Signed-off-by: Daniel Walker <dwalker@mvista.com>
> ---
> drivers/hid/hid-input-quirks.c |   12 ++++++++++++
> 1 files changed, 12 insertions(+), 0 deletions(-)
[ ... ]

On Tue, 1 Jul 2008, Daniel Walker wrote:

> This adds in a quirk for the additional un-mapped buttons on the
> gyration MCE remote.
>
> Defines are now alphabetical.
>
> Signed-off-by: Daniel Walker <dwalker@mvista.com>

Hi Daniel,

thanks a lot. Could you please fold these two patches into one, and send 
it to me? I will then merge it into my tree.
I don't think there is a reason to have this split into two separate 
patches.

Thanks,

-- 
Jiri Kosina
SUSE Labs
