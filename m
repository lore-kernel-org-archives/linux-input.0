From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH RESEND] HID: uclogic: add support for Ugee Tablet EX07S
Date: Thu, 6 Apr 2017 20:34:41 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1704061450390.28004@cbobk.fhfr.pm>
References: <78f2649b-3df2-14eb-7df5-0bb33922d5ab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49216 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753323AbdDFSen (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 6 Apr 2017 14:34:43 -0400
In-Reply-To: <78f2649b-3df2-14eb-7df5-0bb33922d5ab@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Xiaolei Yu <dreifachstein@gmail.com>
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org

On Thu, 30 Mar 2017, Xiaolei Yu wrote:

> This device has a different vendor id but responds to
> initialization.
> 
> Signed-off-by: Xiaolei Yu <dreifachstein@gmail.com>

Applied to for-4.11/upstream-fixes (although this sole patch is unlikely 
to trigger 4.11 merge).

Thanks,

-- 
Jiri Kosina
SUSE Labs

