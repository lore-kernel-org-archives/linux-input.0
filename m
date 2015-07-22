From: Jiri Kosina <jkosina@suse.com>
Subject: Re: [PATCH v2 1/3] Input: export LEDs as class devices in sysfs
Date: Wed, 22 Jul 2015 20:55:54 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1507222054000.1141@pobox.suse.cz>
References: <1433799790-31873-1-git-send-email-dmitry.torokhov@gmail.com> <1433799790-31873-2-git-send-email-dmitry.torokhov@gmail.com> <20150609174211.GH6338@dtor-ws> <55AE299F.3010002@suse.cz> <20150721170133.GA39076@dtor-ws> <20150721210850.GA13242@amd>
 <55AF96B3.8070507@suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [89.191.203.168] ([89.191.203.168]:33557 "EHLO
	mail.emea.novell.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751433AbbGVSz7 (ORCPT
	<rfc822;groupwise-linux-input@vger.kernel.org:0:0>);
	Wed, 22 Jul 2015 14:55:59 -0400
In-Reply-To: <55AF96B3.8070507@suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Pavel Machek <pavel@ucw.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, =?ISO-8859-15?Q?Pali_Roh=E1r?= <pali.rohar@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rpurdie@rpsys.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Wed, 22 Jul 2015, Vlastimil Babka wrote:

[ ... snip ... ]
> The mouse has 3 green leds and one red to indicate battery status, but I think
> they operate autonomously.

It's possible that the mouse is presenting them in the report descriptor 
though (and maybe it's even possible to control them from the host).

Could you please provide contents of

	/sys/kernel/debug/hid/<device>/rdesc

-- 
Jiri Kosina
SUSE Labs
