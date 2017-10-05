From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: hid-input: Add eraser usage to
 hidinput_configure_usage
Date: Thu, 5 Oct 2017 11:20:51 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1710051120400.14384@jbgna.fhfr.qr>
References: <20171003220541.3333-1-ping.cheng@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55210 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751278AbdJEJUx (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 5 Oct 2017 05:20:53 -0400
In-Reply-To: <20171003220541.3333-1-ping.cheng@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, toshiki.takeuchi@wacom.com, killertofu@gmail.com, Ping Cheng <ping.cheng@wacom.com>

On Tue, 3 Oct 2017, Ping Cheng wrote:

> Some tablets report eraser usage to indicate the eraser tool tip
> is touching the surface. But, hidinput_configure_usage didn't
> support the usage, which led it falls into default as ABS_MISC.

Applied to for-4.15/upstream. Thanks,

-- 
Jiri Kosina
SUSE Labs

