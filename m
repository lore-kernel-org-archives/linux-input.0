From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 04/23 v6] Input: atmel_mxt_ts - warn if sysfs could not
 be created
Date: Thu, 5 Jul 2012 10:22:30 -0700
Message-ID: <20120705172230.GB31383@core.coreip.homeip.net>
References: <1340888904-15620-1-git-send-email-djkurtz@chromium.org>
 <1340888904-15620-5-git-send-email-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:36892 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752135Ab2GERWi (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 Jul 2012 13:22:38 -0400
Content-Disposition: inline
In-Reply-To: <1340888904-15620-5-git-send-email-djkurtz@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, Nick Dyer <nick.dyer@itdev.co.uk>, Yufeng Shen <miletus@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>, Benson Leung <bleung@chromium.org>

Hi Daniel, Henrik,

On Thu, Jun 28, 2012 at 09:08:05PM +0800, Daniel Kurtz wrote:
> If sysfs entry creation fails, the driver is still usable, so don't
> just abort probe.  Just warn and continue.
> 

I understand that I am a bit late to the party :) but I do not agree
with this change. Failure to create attributes is not sometihng that
user could cause (at least not easily) and thus would not be a setup
issue but something more severe. I believe we should fail loading the
driver so sysfs attribute breakage will be noticed as soon as possible,
instead of discovering it much much later in the process.

So I think we should revert this one.

Thanks.

-- 
Dmitry
