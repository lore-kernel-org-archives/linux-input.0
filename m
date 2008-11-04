From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH] hid: Add support for the new unibody macbooks
Date: Tue, 04 Nov 2008 16:16:23 +0100
Message-ID: <49106747.8060709@gmail.com>
References: <49103CFA.1010707@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:37814 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752501AbYKDPQh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Nov 2008 10:16:37 -0500
In-Reply-To: <49103CFA.1010707@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Henrik Rydberg napsal(a):
> The unibody MacBook 5 and MacBook Pro 5 come with a new version of
> the bcm5974 trackpad. This patch adds the USB device ids and the
> appropriate quirks.

Hi, thanks for the patch, but you omitted hid_blacklist addition.

Jiri K. (HID maintainer) is out for a while, expect longer rtt ;).
