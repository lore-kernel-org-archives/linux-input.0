From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/1] HID: hid-logitech-dj: Out of bound by one bug
Date: Tue, 20 Sep 2011 16:10:21 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1109201610110.13109@pobox.suse.cz>
References: <1316527143-15123-1-git-send-email-nlopezcasad@logitech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:51286 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750713Ab1ITOKW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Sep 2011 10:10:22 -0400
In-Reply-To: <1316527143-15123-1-git-send-email-nlopezcasad@logitech.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nestor Lopez Casado <nlopezcasad@logitech.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, ogay@logitech.com, jzanone@logitech.com, dan.carpenter@oracle.com

On Tue, 20 Sep 2011, Nestor Lopez Casado wrote:

> There is a bug where a device with index 6 would write out of bounds in
> the array of paired devices.
> This patch fixes that problem.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
