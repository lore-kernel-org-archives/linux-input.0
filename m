From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] doc: specify that ABS_MT_SLOT must have a minimum of 0
Date: Thu, 13 Jun 2013 21:30:50 +0200
Message-ID: <20130613193050.GA2844@polaris.bitmath.org>
References: <20130531062944.GA915@yabbi.redhat.com>
 <CAN+gG=FpioeuX_VJauhHAyB_rHdMbh_Zic7H-M8Pz-k6xV=O0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b21.telenor.se ([195.54.99.212]:46936 "EHLO
	smtprelay-b21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752081Ab3FMTsE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Jun 2013 15:48:04 -0400
Received: from ipb1.telenor.se (ipb1.telenor.se [195.54.127.164])
	by smtprelay-b21.telenor.se (Postfix) with ESMTP id 809AAC443
	for <linux-input@vger.kernel.org>; Thu, 13 Jun 2013 21:24:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAN+gG=FpioeuX_VJauhHAyB_rHdMbh_Zic7H-M8Pz-k6xV=O0w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Wed, Jun 12, 2013 at 10:51:56AM +0200, Benjamin Tissoires wrote:
> On Fri, May 31, 2013 at 8:29 AM, Peter Hutterer
> <peter.hutterer@who-t.net> wrote:
> > This is effectively already in force through input_mt_init_slots, and uinput
> > too ignores the actual minimum.
> >
> > Since slots are a kernel-genenerated axis only, non-zero minimums make
> > little sense and are likely to cause errors. Better to treat a non-zero
> > minimum as kernel bug if it ever happens.
> >
> > Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
> 
> Acked-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>

Applied, thanks Peter and Benjamin.

Henrik
