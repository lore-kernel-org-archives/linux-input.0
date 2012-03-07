From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: altera_ps2: Store struct serio in struct ps2if
Date: Wed, 7 Mar 2012 13:22:40 -0800
Message-ID: <20120307212240.GA4215@core.coreip.homeip.net>
References: <1331127864-7667-1-git-send-email-tklauser@distanz.ch>
 <20120307172523.GA29568@core.coreip.homeip.net>
 <20120307200325.GE21503@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:53332 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755012Ab2CGVWr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Mar 2012 16:22:47 -0500
Received: by yhmm54 with SMTP id m54so3226981yhm.19
        for <linux-input@vger.kernel.org>; Wed, 07 Mar 2012 13:22:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120307200325.GE21503@distanz.ch>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
Cc: linux-input@vger.kernel.org

On Wed, Mar 07, 2012 at 09:03:25PM +0100, Tobias Klauser wrote:
> Hi Dmitry
> 
> On 2012-03-07 at 18:25:24 +0100, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > On Wed, Mar 07, 2012 at 02:44:24PM +0100, Tobias Klauser wrote:
> > > It doesn't make much sense to allocate struct ps2if and struct serio
> > > separately as they're allocated and used in conjunction.
> > > 
> > 
> > Actually, it does. Serio is a refcounted structure and has different
> > lifetime rules than struct ps2if. It may get deleted by
> > serio_unregister_port() or it may live on until after ps2if is freed and
> > altera_ps2 module is unloaded and it should stay allocated separately.
> 
> Oh, sorry. I didn't look careful enough then. Thanks a lot for clearing
> that up!
> 
> I was looking at xilinx_ps2 and figured they do it like this. Would that
> mean a "bug" there, or am I mislead again?

Yes, there is a bug, thanks for letting me know.

-- 
Dmitry
