From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] input-mt: Allow -1 for tracking id
Date: Fri, 15 Apr 2011 09:00:00 +0200
Message-ID: <20110415070000.GA7135@polaris.bitmath.org>
References: <BANLkTimcCh7MbmxtuzTCEFyT28FHZU+ijw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b11.telenor.se ([62.127.194.20]:57357 "EHLO
	smtprelay-b11.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753749Ab1DOG6o (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Apr 2011 02:58:44 -0400
Received: from ipb3.telenor.se (ipb3.telenor.se [195.54.127.166])
	by smtprelay-b11.telenor.se (Postfix) with ESMTP id C9E2514237
	for <linux-input@vger.kernel.org>; Fri, 15 Apr 2011 08:58:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <BANLkTimcCh7MbmxtuzTCEFyT28FHZU+ijw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sadrul Chowdhury <sadrul@chromium.org>
Cc: linux-input@vger.kernel.org

Hi Sadrul,

On Thu, Apr 14, 2011 at 06:13:17PM -0400, Sadrul Chowdhury wrote:
> In protocol B, the tracking ID can be set to -1. But since the min
> value is set to 0, the clients don't receive a -1 when a contact is
> lifted. The attached patch sets the min to -1 to fix this issue.

All ABS_MT_TRACKING_ID values outside the valid value range denote an
invalid touch. To simplify implementation in userland, where the valid
range may not always be known, the documentation was changed to say
"-1" instead. Apparently the original explanation was unintentionally
dropped with it.

Because the change goes against the semantics of the tracking id, this
patch constitues an interface breakage, with malfunctions in userspace
as a result. Therefore, this patch will not be applied.

Thanks,
Henrik
