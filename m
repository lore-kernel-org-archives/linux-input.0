From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] drivers:input:free the memory before set it to NULL
Date: Wed, 20 Jul 2011 16:54:54 +0100
Message-ID: <20110720165454.1e67a91f@lxorguk.ukuu.org.uk>
References: <1311176496-10026-1-git-send-email-wanlong.gao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:57268 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751970Ab1GTPwR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Jul 2011 11:52:17 -0400
In-Reply-To: <1311176496-10026-1-git-send-email-wanlong.gao@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wanlong Gao <wanlong.gao@gmail.com>
Cc: dmitry.torokhov@gmail.com, sameo@linux.intel.com, linux-input@vger.kernel.org, Wanlong Gao <gaowanlong@cn.fujitsu.com>

On Wed, 20 Jul 2011 23:41:36 +0800
Wanlong Gao <wanlong.gao@gmail.com> wrote:

> The memory of the platform driver data should be freed
> before it was set to NULL.

This seems backwards to me. Currently the reference is invalidated before
the object, which seems to make more sense.

As there is no locking here it really makes no difference anyway

> 
