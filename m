From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH resend] hid-magicmouse: Increase evdev buffer size
Date: Mon, 4 Apr 2011 14:43:20 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1104041441530.28516@pobox.suse.cz>
References: <1301691819-2090-1-git-send-email-chase.douglas@canonical.com> <AANLkTim-tN=siA8tJVCzNZHs+oM0hN-N8Ckc+9ynnNpb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:33691 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750932Ab1DDMnW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 4 Apr 2011 08:43:22 -0400
In-Reply-To: <AANLkTim-tN=siA8tJVCzNZHs+oM0hN-N8Ckc+9ynnNpb@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeffrey Brown <jeffbrown@android.com>
Cc: Chase Douglas <chase.douglas@canonical.com>, Henrik Rydberg <rydberg@euromail.se>, Simon Budig <simon@budig.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 1 Apr 2011, Jeffrey Brown wrote:

> I've got another change in the works that fixes this problem more
> systematically.

Could you just briefly describe what your solution is?

I'd happuly take Chase's patch, but want to make sure that we don't cause 
any changes that would make backwards compatilibity an issue later.

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
