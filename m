From: Ioan-Adrian Ratiu <adi@adirat.com>
Subject: Re: [PATCH] hid: usbhid: hid-core: fix recursive deadlock
Date: Wed, 18 Nov 2015 21:46:01 +0200
Message-ID: <20151118214601.6ecb6acf@adipc>
Reply-To: 1447874755-8673-1-git-send-email-adi@adirat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37644 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755237AbbKRTqH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Nov 2015 14:46:07 -0500
Received: by wmww144 with SMTP id w144so87282361wmw.0
        for <linux-input@vger.kernel.org>; Wed, 18 Nov 2015 11:46:06 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org
Cc: pinglinux@gmail.com, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Here are some images with more information on this deadlock, might be helpful.

First part of lockdep report:
http://imgur.com/clLsCWe

Second part:
http://imgur.com/Wa2PzRl

Here are some printk's of mine while reproducing + debugging the issue:
http://imgur.com/SETOHT7
