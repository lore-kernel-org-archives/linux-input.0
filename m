From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Retire gamecon?
Date: Tue, 12 Aug 2014 10:07:22 -0700
Message-ID: <20140812170722.GC5563@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:39441 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753117AbaHLRHZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Aug 2014 13:07:25 -0400
Received: by mail-pd0-f182.google.com with SMTP id fp1so12945731pdb.13
        for <linux-input@vger.kernel.org>; Tue, 12 Aug 2014 10:07:25 -0700 (PDT)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Vojtech Pavlik <vojtech@suse.cz>, Jiri Kosina <jkosina@suse.cz>

Hi,

I am wondering it it is time to retire gamecon support from the kernel. It
hasn't been working well ever since cpufreq became mainstream and it becomes
increasingly hard to find hardware and software that would run on such old
hardware.

Please scream if you believe it should stay in.

Thanks.

-- 
Dmitry
