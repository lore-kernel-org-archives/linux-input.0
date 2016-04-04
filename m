From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH V2] HID: Asus X205TA keyboard driver
Date: Mon, 4 Apr 2016 10:03:01 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1604041002270.16158@cbobk.fhfr.pm>
References: <1459692916-3705-1-git-send-email-usk.fujimaki@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52261 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750737AbcDDIDD (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 4 Apr 2016 04:03:03 -0400
In-Reply-To: <1459692916-3705-1-git-send-email-usk.fujimaki@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yusuke Fujimaki <usk.fujimaki@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

On Sun, 3 Apr 2016, Yusuke Fujimaki wrote:

> Asus X205TA and E200HA built-in keyboard contain
> wrong logical maximum value in report descriptor.
> 
> This patch correct wrong logical maximum in report
> descriptor.

I've updated the subject line slightly to be more accurate and applied.

-- 
Jiri Kosina
SUSE Labs
