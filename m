From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid: replace strict_strtoul() with kstrtoul()
Date: Tue, 23 Jul 2013 16:06:55 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1307231606410.14024@pobox.suse.cz>
References: <000601ce844c$a5059330$ef10b990$@samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:41974 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932442Ab3GWOG7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Jul 2013 10:06:59 -0400
In-Reply-To: <000601ce844c$a5059330$ef10b990$@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-input@vger.kernel.org

On Fri, 19 Jul 2013, Jingoo Han wrote:

> The usage of strict_strtoul() is not preferred, because
> strict_strtoul() is obsolete. Thus, kstrtoul() should be
> used.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
