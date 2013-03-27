From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2 0/7] HID: multitouch: support of hybrid finger/pen
 devices
Date: Wed, 27 Mar 2013 14:04:27 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1303271404070.23442@pobox.suse.cz>
References: <1363973914-5661-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47751 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750843Ab3C0NE3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Mar 2013 09:04:29 -0400
In-Reply-To: <1363973914-5661-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 22 Mar 2013, Benjamin Tissoires wrote:

> Hi Guys,
> 
> this is the second iteration of the support of dual sensors (pen + touch)
> devices.
> 
> There has not been a lot of changes since v1:
> - use " |= " instead of " = r || " in patch 1
> - introduce a factorization of input_configured() in patch 2 (which makes more sense
> IMO)
> - patch 4 is new, but the change is quite small (again, tested on my database)
> - patch 6 has been reworked, though it's not clear if it's better
> - patch 7 has been reworked, the set_bit occurs now in input_configured()

I have now applied the series for 3.10. Thanks.

-- 
Jiri Kosina
SUSE Labs
