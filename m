From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: multitouch: Support ALPS PTP stick with pid
 0x120A
Date: Wed, 6 Sep 2017 11:05:50 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1709061105380.4077@jbgna.fhfr.qr>
References: <20170810095401.16795-1-shrirang.bagul@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54312 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752331AbdIFJFw (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 6 Sep 2017 05:05:52 -0400
In-Reply-To: <20170810095401.16795-1-shrirang.bagul@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Shrirang Bagul <shrirang.bagul@canonical.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 10 Aug 2017, Shrirang Bagul wrote:

> This patch adds ALPS PTP sticks with pid/device id 0x120A to the list of
> devices supported by hid-multitouch.
> 
> Signed-off-by: Shrirang Bagul <shrirang.bagul@canonical.com>

Applied to for-4.14/upstream-fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs

