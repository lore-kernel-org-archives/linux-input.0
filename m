From: Jiri Kosina <jkosina@suse.com>
Subject: Re: [PATCH] HID: input: call input_sync() when automatically releasing
 a key
Date: Fri, 10 Jul 2015 11:35:58 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1507101135170.14897@pobox.suse.cz>
References: <20150709213321.GA9268@dtor-ws>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.emea.novell.com ([130.57.118.101]:37008 "EHLO
	mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753480AbbGJJgF (ORCPT
	<rfc822;groupwise-linux-input@vger.kernel.org:0:0>);
	Fri, 10 Jul 2015 05:36:05 -0400
In-Reply-To: <20150709213321.GA9268@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 9 Jul 2015, Dmitry Torokhov wrote:

> We need to emit EV_SYN/SYN_REPORT between key press and release, otherwise
> userspace is allowed to "swallow" the event.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

I've applied this to for-4.3/upstream.

Thanks,

-- 
Jiri Kosina
SUSE Labs
