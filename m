From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 001/002] linux-input:  bcm5974-0.31: fixed resource
	leak, removed work struct, device data struct introduced
Date: Thu, 03 Jul 2008 18:33:40 +0200
Message-ID: <1215102820.4138.17.camel@alnilam>
References: <1214653629.10495.11.camel@alnilam>
	 <20080701155925.a4c00a8e.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:43498 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751222AbYGCQea (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 3 Jul 2008 12:34:30 -0400
In-Reply-To: <20080701155925.a4c00a8e.akpm@linux-foundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, robfitz@273k.net, jikos@jikos.cz, vojtech@suse.cz, dmonakhov@openvz.org, linux-usb@vger.kernel.org

On Tue, 2008-07-01 at 15:59 -0700, Andrew Morton wrote:
> > +  }
> > +
> > +  button = data[1];
> > +
> > +  /* only report button state changes */
> > +  if (button != dev->bt_state) {
> > +    input_report_key(dev->input, BTN_LEFT, button);
> > +    input_sync(dev->input);
> > +  }
> > +
> > +  dev->bt_state = button;
> > +
> > + exit:
> > +  retval = usb_submit_urb(dev->bt_urb, GFP_ATOMIC);
> 
> GFP_ATOMIC is a red flag.  Is this quite unrelaible allocation mode
> really needed here?

Being new to kernel work, I rely a lot on how other drivers work.
However, doing some reading, these are my observations:

* The URB works in interrupt mode.

* The call to usb_submit_urb above is within a completion handler.

* From what I read on kerneltrap (2.6.22), such URBs should be
resubmitted using the ATOMIC method. Maybe this changed, I could not
tell.

* Personally, I am starting to worry about concurrency races, with the
two URBs writing to the same input device. I suppose it depends on
whether they are issued on the same interrupt or not? Spin locks?

Best regards,
Henrik Rydberg


