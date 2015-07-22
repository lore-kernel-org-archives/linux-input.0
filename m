From: Jiri Kosina <jkosina@suse.com>
Subject: Re: [PATCH v2 1/3] Input: export LEDs as class devices in sysfs
Date: Thu, 23 Jul 2015 00:01:27 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1507222351480.1141@pobox.suse.cz>
References: <1433799790-31873-1-git-send-email-dmitry.torokhov@gmail.com> <1433799790-31873-2-git-send-email-dmitry.torokhov@gmail.com> <20150609174211.GH6338@dtor-ws> <55AE299F.3010002@suse.cz> <20150721170133.GA39076@dtor-ws> <55AFAB9B.2090101@suse.cz>
 <alpine.LNX.2.00.1507222145030.1141@pobox.suse.cz> <20150722214948.GF14875@dtor-ws>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [89.191.203.168] ([89.191.203.168]:53201 "EHLO
	mail.emea.novell.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752797AbbGVWBb (ORCPT
	<rfc822;groupwise-linux-input@vger.kernel.org:0:0>);
	Wed, 22 Jul 2015 18:01:31 -0400
In-Reply-To: <20150722214948.GF14875@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Pavel Machek <pavel@ucw.cz>, =?ISO-8859-15?Q?Pali_Roh=E1r?= <pali.rohar@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rpurdie@rpsys.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Wed, 22 Jul 2015, Dmitry Torokhov wrote:

> Yes, I'll change how we count the leds to skip unnamed, then the patch
> below won't be needed.

Agreed.

> BTW, maybe we should be using hid_map_usage_clear() in map_led() as it 
> does not make much sense to convert CAPS LOCK into SCROLL LOCK in case 
> keyboard happens to have 2 usages for caps...

Indeed, makes sense generally for all LEDs I think.

-- 
Jiri Kosina
SUSE Labs
