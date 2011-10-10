From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Problem statement: Opportunistic suspend and i8042 wakeups
Date: Mon, 10 Oct 2011 13:38:15 -0700
Message-ID: <20111010203815.GA25314@core.coreip.homeip.net>
References: <CAMLZHHQH=vWDnQH-Gnz01yDFv=wqG1de5nezb2B+H6VSJieg5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:47436 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155Ab1JJUiV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Oct 2011 16:38:21 -0400
Received: by pzk1 with SMTP id 1so17158606pzk.1
        for <linux-input@vger.kernel.org>; Mon, 10 Oct 2011 13:38:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMLZHHQH=vWDnQH-Gnz01yDFv=wqG1de5nezb2B+H6VSJieg5A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: rjw@sisk.pl, Paul Fox <pgf@laptop.org>, linux-input@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, linux-pm@lists.linux-foundation.org

Hi Daniel,

On Mon, Oct 10, 2011 at 08:24:08PM +0100, Daniel Drake wrote:
>  3. The issue of the input layer releasing all our keys is left
> unresolved with this approach.
> 

I think input layer releasing keys at resume time is actually in the
wrong here, as it meddles with device state after physical device
(i8042, atkbd, etc) are fully woken up.

IIRC I put releasing originally in resume because I was concerned
with events getting discarded after S2D because we thew away the state
that happens after taking snapshot and there weren't enough granularity
in PM callbacks to differentiate between S2D and S2R.

I believe if we move release of the keys into suspend handlers then
input core should not get into the middle of things for your case as you
said that the OLPC device will not suspend with a key still pressed and
upon release we would not be doing anything with key state (but
restore LED/SOUND only) which you do not care about.

Thanks.

-- 
Dmitry
