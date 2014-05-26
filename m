From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 16/18] HID: uhid: Use kmemdup instead of kmalloc +
 memcpy
Date: Tue, 27 May 2014 00:42:02 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1405270041480.28869@pobox.suse.cz>
References: <1401117687-28911-1-git-send-email-benoit.taine@lip6.fr> <1401117687-28911-17-git-send-email-benoit.taine@lip6.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:50538 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751406AbaEZWmI (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 26 May 2014 18:42:08 -0400
In-Reply-To: <1401117687-28911-17-git-send-email-benoit.taine@lip6.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benoit Taine <benoit.taine@lip6.fr>
Cc: David Herrmann <dh.herrmann@googlemail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On Mon, 26 May 2014, Benoit Taine wrote:

> This issue was reported by coccicheck using the semantic patch 
> at scripts/coccinelle/api/memdup.cocci
> 
> Signed-off-by: Benoit Taine <benoit.taine@lip6.fr>

Applied, thanks Benoit.

-- 
Jiri Kosina
SUSE Labs
