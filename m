From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/1] HID: hidraw: Add spinlock in struct hidraw to protect
 list
Date: Mon, 26 Aug 2013 14:03:18 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1308261359440.2077@pobox.suse.cz>
References: <CAMyfujdB0JrnNeHk3b=AqR+1nz_W=bzDJpk1=iYZBnytDk-ztw@mail.gmail.com> <20130815145658.GA5813@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:49265 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751484Ab3HZMDX (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Aug 2013 08:03:23 -0400
In-Reply-To: <20130815145658.GA5813@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yonghua Zheng <younghua.zheng@gmail.com>
Cc: linux-input@vger.kernel.org

On Thu, 15 Aug 2013, Yonghua Zheng wrote:

> As hidraw_report_event can be called from interrupt context, it is a mistake
> to use mutex_lock for protecting the list member in my previous patch, so
> update the patch which adds a spinlock in struct hidraw to protect the list
> member from concurrent access:

Hi,

thanks for the patch.

I already have

	commit 212a871a3934beccf43431608c27ed2e05a476ec
	Author: Manoj Chourasia <mchourasia@nvidia.com>
	Date:   Mon Jul 22 15:33:13 2013 +0530

	    HID: hidraw: correctly deallocate memory on device disconnect

in the tree, which collides with your patch. Could you please check what 
changes are needed on top of it so that it makes sense for my 'for-next' 
branch, rebase, and resend to me?

Thanks,

-- 
Jiri Kosina
SUSE Labs
