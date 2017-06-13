From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v1] HID: core: don't use negative operands when shift
Date: Tue, 13 Jun 2017 14:29:54 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1706131429480.30709@cbobk.fhfr.pm>
References: <20170613092222.4073-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45343 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752608AbdFMM36 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 13 Jun 2017 08:29:58 -0400
In-Reply-To: <20170613092222.4073-1-andriy.shevchenko@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>

On Tue, 13 Jun 2017, Andy Shevchenko wrote:

> From: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> The recent C standard in 6.5.7 paragraph 4 defines that operands for
> bitwise shift operators should be non-negative, otherwise it's an
> undefined behaviour.
> 
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

