From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: lenovo: Remove sysfs group on failure path
Date: Fri, 29 May 2015 16:31:38 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1505291631180.26271@pobox.suse.cz>
References: <1432859971-28185-1-git-send-email-khoroshilov@ispras.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34500 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754988AbbE2Obk (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 29 May 2015 10:31:40 -0400
In-Reply-To: <1432859971-28185-1-git-send-email-khoroshilov@ispras.ru>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org

On Fri, 29 May 2015, Alexey Khoroshilov wrote:

> There is no sysfs_group_remove() on failure path in lenovo_probe_tpkbd().
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>

Applied to for-4.2/upstream. Thanks,

-- 
Jiri Kosina
SUSE Labs
