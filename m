From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2] HID: logitech-hidpp: prefix the name with Logitech
Date: Wed, 17 Dec 2014 10:38:10 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1412171037200.1680@pobox.suse.cz>
References: <1418337599-10239-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42216 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751456AbaLQJiM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Dec 2014 04:38:12 -0500
In-Reply-To: <1418337599-10239-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Peter Wu <peter@lekensteyn.nl>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 11 Dec 2014, Benjamin Tissoires wrote:

> Current names are reported as "K750", "M705", and it can be misleading
> for the users when they look at their input device list.
> 
> Prefixing the names with "Logitech " makes things better.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
> 
> Changes in v2:
> - renamed PREFIX_SIZE into PREFIX_LENGTH
> - changed "name_length + PREFIX_LENGTH;" into "PREFIX_LENGTH + name_length;"
> - rebased on Peter's last patch series

Ok, looks reasonable. I was waiting whether someone from Logitech would 
comment on the prefix check that could be used other than "Logitech".

But we can add that later.

Applied to for-3.20/logitech, thanks.

-- 
Jiri Kosina
SUSE Labs
