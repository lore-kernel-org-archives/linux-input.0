From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/4] HID: debug: break out hid_dump_report() into
 hid-debug
Date: Thu, 18 Apr 2013 19:01:27 -0700 (PDT)
Message-ID: <alpine.LNX.2.00.1304181900510.31201@pobox.suse.cz>
References: <1366220296-14346-1-git-send-email-benjamin.tissoires@redhat.com> <1366220296-14346-2-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:46116 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967641Ab3DSCB2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Apr 2013 22:01:28 -0400
In-Reply-To: <1366220296-14346-2-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 17 Apr 2013, Benjamin Tissoires wrote:

> No semantic changes, but hid_dump_report should be in hid-debug.c, not
> in hid-core.c
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

I have applied this one independently on the rest.

-- 
Jiri Kosina
SUSE Labs
