From: Bastien Nocera <hadess@hadess.net>
Subject: Re: Spurious touchpad events with closed LID
Date: Thu, 29 Jun 2017 00:44:27 +0200
Message-ID: <1498689867.6564.6.camel@hadess.net>
References: <201706261854.53970@pali> <20170626170312.GB4965@dtor-ws>
         <201706262109.42628@pali> <20170628201530.GB18101@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:56141 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751610AbdF1Woc (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 28 Jun 2017 18:44:32 -0400
In-Reply-To: <20170628201530.GB18101@amd>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Wed, 2017-06-28 at 22:15 +0200, Pavel Machek wrote:
> 
<snip>
> While policy normally belongs to userspace, I'd argue this is
> workaround for a hardware bug, and in-kernel solution would be
> acceptable.
> 
> Anyway, disable attribute would be nice first step.

It's already fixed for those of us on recent distributions. The
"ID_INPUT_TOUCHPAD_INTEGRATION=internal" touchpads will be disabled
when the lid is closed, when libinput is used to process the events.

Usually, non-crappy hardware will do that in firmware, but software is
easier to patch ;)
