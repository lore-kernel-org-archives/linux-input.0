From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] input: wacom - use new input-mt routines
Date: Tue, 4 Dec 2012 11:16:22 -0800
Message-ID: <20121204191622.GE23964@core.coreip.homeip.net>
References: <1354570717-2274-1-git-send-email-pingc@wacom.com>
 <20121204161314.GA1432@polaris.bitmath.org>
 <CAF8JNhJ3wC9Oih_0Lx3-JyP_MJdd9TfBRsLnfLsfC+wbm9xCww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34175 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751607Ab2LDTQ2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Dec 2012 14:16:28 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so3052303pbc.19
        for <linux-input@vger.kernel.org>; Tue, 04 Dec 2012 11:16:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAF8JNhJ3wC9Oih_0Lx3-JyP_MJdd9TfBRsLnfLsfC+wbm9xCww@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input <linux-input@vger.kernel.org>

On Tue, Dec 04, 2012 at 10:22:24AM -0800, Ping Cheng wrote:
> 
> However, for this particular one (and maybe 2 below), we do need to
> remove it. 24hdt is a touchscren device, which should not emulate
> pointer events. I will make a separate patch for this change.

Why not? Legacy clients should be able to use touchscreens and I think
most (all?) of our MT touchscreen drivers report ST events.

Thanks.

-- 
Dmitry
