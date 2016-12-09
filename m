From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 1/1 v2] input: usbhid: fix improper return value
Date: Fri, 9 Dec 2016 13:47:05 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1612091346530.16984@cbobk.fhfr.pm>
References: <1480937844-21513-1-git-send-email-bianpan2016@163.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47798 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752823AbcLIMrI (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 9 Dec 2016 07:47:08 -0500
In-Reply-To: <1480937844-21513-1-git-send-email-bianpan2016@163.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pan Bian <bianpan2016@163.com>
Cc: Oliver Neukum <oneukum@suse.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 5 Dec 2016, Pan Bian wrote:

> Function hid_post_reset() should return negative error codes on
> failures. However, in its implementation, it incorrectly returns 1.
> This patch fixes the bug, returning proper error codes on failures.

Applied to for-4.10/upstream. Thanks,

-- 
Jiri Kosina
SUSE Labs

