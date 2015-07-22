From: Jiri Kosina <jkosina@suse.com>
Subject: Re: [PATCH v2 1/3] Input: export LEDs as class devices in sysfs
Date: Wed, 22 Jul 2015 23:50:35 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1507222348580.1141@pobox.suse.cz>
References: <1433799790-31873-1-git-send-email-dmitry.torokhov@gmail.com> <1433799790-31873-2-git-send-email-dmitry.torokhov@gmail.com> <20150609174211.GH6338@dtor-ws> <55AE299F.3010002@suse.cz> <20150721170133.GA39076@dtor-ws> <55AFAB9B.2090101@suse.cz>
 <alpine.LNX.2.00.1507222145030.1141@pobox.suse.cz> <20150722214739.GA15790@amd>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [89.191.203.168] ([89.191.203.168]:49009 "EHLO
	mail.emea.novell.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752890AbbGVVvB (ORCPT
	<rfc822;groupwise-linux-input@vger.kernel.org:0:0>);
	Wed, 22 Jul 2015 17:51:01 -0400
In-Reply-To: <20150722214739.GA15790@amd>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Vlastimil Babka <vbabka@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, =?ISO-8859-15?Q?Pali_Roh=E1r?= <pali.rohar@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rpurdie@rpsys.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Wed, 22 Jul 2015, Pavel Machek wrote:

> > I am however not sure whether input_leds_connect() is not too unkind to 
> > unnamed LEDs and shouldn't be more tolerant to those in the long term.
> 
> Maybe.
> 
> > From: Jiri Kosina <jkosina@suse.com>
> > Subject: [PATCH] Input: leds: don't attempt to deregister unnamed LEDs
> > 
> > input_leds_connect() is skipping registration of LEDs for which
> > there is no symbolic name in input_led_info[].
> 
> Yes, and rather than testing for "no name" special case at two places,
> what about simply giving up when we see such error?

Well, that's quite the oposite of the "be more tolerant" aproach proposed 
above :)

I don't see a reason why the sole fact that the device has at least one 
LED that kernel can't handle properly should mean that neither of the 
other LEDs will work.

-- 
Jiri Kosina
SUSE Labs
