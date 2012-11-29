From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 01/11] HID: hid-input factorize hid_input allocation
Date: Thu, 29 Nov 2012 15:00:21 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1211291459490.25639@pobox.suse.cz>
References: <1353684694-5723-1-git-send-email-benjamin.tissoires@gmail.com> <1353684694-5723-2-git-send-email-benjamin.tissoires@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48633 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753852Ab2K2OA0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Nov 2012 09:00:26 -0500
In-Reply-To: <1353684694-5723-2-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 23 Nov 2012, Benjamin Tissoires wrote:

> This just refactors the allocation of hid_input.
> No semantic changes.

As this is a generic cleanup, I am taking this one through 
for-3.8/upstream branch.

Thanks,

-- 
Jiri Kosina
SUSE Labs
