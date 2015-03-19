From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: HID: wacom: check for wacom->shared before following the pointer
Date: Thu, 19 Mar 2015 19:50:04 +0300
Message-ID: <20150319165004.GV16501@mwanda>
References: <20150319155425.GA727@mwanda>
 <20150319160601.GC18134@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:29867 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371AbbCSQuH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Mar 2015 12:50:07 -0400
Content-Disposition: inline
In-Reply-To: <20150319160601.GC18134@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <Ping.Cheng@wacom.com>, Jason Gerecke <Jason.Gerecke@wacom.com>

On Thu, Mar 19, 2015 at 12:06:02PM -0400, Benjamin Tissoires wrote:
> >   1101  
> >   1102          for (i = 0; i < contacts_to_send; i++) {
> >   1103                  int offset = (byte_per_packet * i) + 1;
> >   1104                  bool touch = (data[offset] & 0x1) && !wacom->shared->stylus_in_proximity;
> >                                                               ^^^^^^^^^^^^^
> > I assume this hardware is always quirky so this won't cause a NULL
> > deref?
> 
> Yes. 24hdt has the quirk WACOM_QUIRK_MULTI_INPUT, so wacom->shared can
> not be null. I wonder what we could put in the code to make static
> checkers happy...

The static checker doesn't complain about this, I was just wondering.

regards,
dan carpenter

