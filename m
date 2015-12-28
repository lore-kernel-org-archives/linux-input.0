From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 1/5] HID: move to_hid_device() to hid.h
Date: Mon, 28 Dec 2015 13:44:40 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1512281344260.9922@cbobk.fhfr.pm>
References: <3490fef13d9af010ff2da07012eed189c46ee3fa.1451206516.git.geliangtang@163.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36045 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751934AbbL1Mom (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Dec 2015 07:44:42 -0500
In-Reply-To: <3490fef13d9af010ff2da07012eed189c46ee3fa.1451206516.git.geliangtang@163.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Geliang Tang <geliangtang@163.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, 27 Dec 2015, Geliang Tang wrote:

> to_hid_device() macro is defined in both hid-lg4ff.c and 
> hid-logitech-hidpp.c. So I move it to include/linux/hid.h.
> 
> Signed-off-by: Geliang Tang <geliangtang@163.com>

I've applied the whole series to hid.git#for-4.5/container-of-cleanups

-- 
Jiri Kosina
SUSE Labs

