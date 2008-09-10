From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/3] OLPC: touchpad driver (take 2)
Date: Wed, 10 Sep 2008 09:00:36 -0400
Message-ID: <20080910130035.GB25221@anvil.corenet.prv>
References: <20080813152459.4d6bb0cb@ephemeral> <20080815031435.GD9438@anvil.corenet.prv> <20080829024959.68bcdc98@fred>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f16.google.com ([209.85.217.16]:44483 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096AbYIJNAk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Sep 2008 09:00:40 -0400
Received: by gxk9 with SMTP id 9so13478143gxk.13
        for <linux-input@vger.kernel.org>; Wed, 10 Sep 2008 06:00:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080829024959.68bcdc98@fred>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andres Salomon <dilinger@queued.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Aug 29, 2008 at 02:49:59AM -0400, Andres Salomon wrote:
> > > +static void hgpk_spewing_hack(struct psmouse *psmouse, int l, int
> > > r, int x,
> > > +		int y)
> > > +{
> > > +	struct hgpk_data *priv = psmouse->private;
> > > +	static int count;
> > > +	static int x_tally;
> > > +	static int y_tally;
> > 
> > Hmm, I guess we'll never see 2 such devices in one box, but still
> > moving it to psmouse->private woudl be a good practice.
> 
> 
> Can you please clarify this comment?
> 

If you ever have 2 such devices in the same box use of static variables
will cause the code to not work properly because they will be shared
between the devices. Proper way is to move them into per-device
structure.

-- 
Dmitry
