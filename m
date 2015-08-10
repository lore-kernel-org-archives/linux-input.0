From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: wacom: Do not repeatedly attempt to set device mode
 on error
Date: Mon, 10 Aug 2015 14:31:58 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1508101431480.27871@pobox.suse.cz>
References: <1438814730-12108-1-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46806 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751112AbbHJMb6 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Aug 2015 08:31:58 -0400
In-Reply-To: <1438814730-12108-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

On Wed, 5 Aug 2015, Jason Gerecke wrote:

> As an extension of aef3156d7, there is no sense in repeatedly calling the
> 'wacom_set_report' and 'wacom_get_report' functions if they return an
> error. Getting an error from them implies that the device is out to lunch:
> either a hard error code was returned or repeated attempts at recovering
> from a "soft" error all failed. In either case, doing even more retries is
> not likely to resolve whatever is wrong.
> 
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>

Applied to for-4.3/upstream.

-- 
Jiri Kosina
SUSE Labs

