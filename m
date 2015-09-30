From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: hiddev: fix returned errno code in
 hiddev_connect()
Date: Wed, 30 Sep 2015 21:40:29 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1509302138380.30132@pobox.suse.cz>
References: <1443606749-6028-1-git-send-email-luisbg@osg.samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56469 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751567AbbI3Tk3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Sep 2015 15:40:29 -0400
In-Reply-To: <1443606749-6028-1-git-send-email-luisbg@osg.samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Luis de Bethencourt <luisbg@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On Wed, 30 Sep 2015, Luis de Bethencourt wrote:

> The driver is using -1 instead of the -ENOMEM defined macro to specify
> that a buffer allocation failed. Since the error number is propagated,
> the caller will get a -EPERM which is the wrong error condition.

Generally I agree that the more specific errno, the better.

But I am not really sure where you are seeing the bug (mapping to -EPERM) 
in this case? I think the only caller of hiddev_connect() should be 
hid_connect(), and the only thing that guy cares about whether individual 
callbacks succeed or fail, so that it sets hdev->clamed flags accordingly.

Could you please be more specific about the -EPERM mapping you are talking 
about?

Thanks,

-- 
Jiri Kosina
SUSE Labs

