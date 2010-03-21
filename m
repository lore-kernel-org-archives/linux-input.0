From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Check whether getkeycode and setkeycode are still valide
Date: Sat, 20 Mar 2010 20:11:49 -0700
Message-ID: <20100321031149.GC29360@core.coreip.homeip.net>
References: <20100321025648.GA24497@ywang-moblin2.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:40940 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752998Ab0CUDLz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 20 Mar 2010 23:11:55 -0400
Received: by gwaa18 with SMTP id a18so431584gwa.19
        for <linux-input@vger.kernel.org>; Sat, 20 Mar 2010 20:11:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100321025648.GA24497@ywang-moblin2.bj.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yong Wang <yong.y.wang@linux.intel.com>
Cc: linux-input@vger.kernel.org

On Sun, Mar 21, 2010 at 10:56:48AM +0800, Yong Wang wrote:
> If sparse keymap is freed before unregistering the device, there is a
> window where userspace can issue EVIOCGKEYCODE or EVIOCSKEYCODE. When
> that happens, kernel will crash. Noticed by Dmitry Torokhov.
> 

I'd rather require that getkeycode and setkeycode be mandatory. I will
change sparse-kepmap module to stop setting these to NULL when freeing
keymap.

Thanks.

-- 
Dmitry
