From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: logitech-dj: use inlined helpers
 hid_hw_open/close
Date: Fri, 12 Jul 2013 11:42:47 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1307121142370.29788@pobox.suse.cz>
References: <1373619662-15353-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:53084 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757350Ab3GLJmu (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Jul 2013 05:42:50 -0400
In-Reply-To: <1373619662-15353-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Nestor Lopez Casado <nlopezcasad@logitech.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 12 Jul 2013, Benjamin Tissoires wrote:

> Use the inlined helpers hid_hw_open/close instead of direct calls to
> ->ll_driver->open() and ->ll_driver->close().
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
