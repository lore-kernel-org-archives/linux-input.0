From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: BUG: hid-multitouch causes 10 second delay and error
Date: Tue, 1 Nov 2011 16:33:48 +0100
Message-ID: <20111101153348.GB2191@polaris.bitmath.org>
References: <20111026213705.GA32664@pequod.mess.org>
 <CAN+gG=E0sUd3WOzAuT1LOTz_U9jLrGg2Bq_jRjha8Dcptk6Zcw@mail.gmail.com>
 <4EA9466F.4000508@gmail.com>
 <20111028111605.GA23693@polaris.bitmath.org>
 <CAN+gG=EiJJR464q_eoJuJYpWOPMsk61W6sAKD18SdT+2tQfmQA@mail.gmail.com>
 <20111028140033.GA2155@polaris.bitmath.org>
 <alpine.LNX.2.00.1110281913010.3541@pobox.suse.cz>
 <20111101141704.GA2135@polaris.bitmath.org>
 <alpine.LNX.2.00.1111011526350.348@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b11.telenor.se ([62.127.194.20]:44623 "EHLO
	smtprelay-b11.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209Ab1KAPYd (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Nov 2011 11:24:33 -0400
Received: from iph1.telenor.se (iph1.telenor.se [195.54.127.132])
	by smtprelay-b11.telenor.se (Postfix) with ESMTP id 92309D97F
	for <linux-input@vger.kernel.org>; Tue,  1 Nov 2011 16:24:32 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1111011526350.348@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Sean Young <sean@mess.org>, linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?iso-8859-1?Q?St=E9phane?= Chatty <chatty@enac.fr>

> > 1. It still does not resolve the
> > hid-multitouch-gets-loaded-for-every-hid-device problem, and
> 
> Hmm, I thought it should work. What is the catch?

Everyone with an umatched hid device, even completely unrelated to
touch, will be surprised to find the hid-multitouch module loaded.

Thanks,
Henrik
