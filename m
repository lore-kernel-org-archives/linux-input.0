From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/1] HID: hidraw: Add spinlock in struct hidraw to protect
 list
Date: Mon, 26 Aug 2013 21:44:06 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1308262143550.2077@pobox.suse.cz>
References: <CAMyfujdB0JrnNeHk3b=AqR+1nz_W=bzDJpk1=iYZBnytDk-ztw@mail.gmail.com> <20130815145658.GA5813@gmail.com> <alpine.LNX.2.00.1308261359440.2077@pobox.suse.cz> <20130826153833.GA2962@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37831 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751949Ab3HZToK (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Aug 2013 15:44:10 -0400
In-Reply-To: <20130826153833.GA2962@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yonghua Zheng <younghua.zheng@gmail.com>
Cc: linux-input@vger.kernel.org

On Mon, 26 Aug 2013, Yonghua Zheng wrote:

> Hi Jiri,
> 
> Fix the conflict and update the patch:
> 
> >From 7c06e1f3a5959e73a5b827bda67e7c1eaed7da67 Mon Sep 17 00:00:00 2001
> From: Yonghua Zheng <younghua.zheng@gmail.com>
> Date: Wed, 14 Aug 2013 17:43:36 +0800
> Subject: [PATCH 1/1] HID: hidraw: Add spinlock in struct hidraw to protect
>  member list
> 
> It is unsafe to call list_for_each_entry in hidraw_report_event to
> traverse each hidraw_list node without a lock protection, the list
> could be modified if someone calls hidraw_release and list_del to
> remove itself from the list, this can cause hidraw_report_event
> to touch a deleted list struct and panic.
> 
> To prevent this, introduce a spinlock in struct hidraw to protect
> list from concurrent access.
> 
> Signed-off-by: Yonghua Zheng <younghua.zheng@gmail.com>

Applied now, thanks.

-- 
Jiri Kosina
SUSE Labs
