From: Alessandro Rubini <rubini-list@gnudd.com>
Subject: Re: [PATCH] ads7846: allocate separate cache lines for tx and rx
	data
Date: Thu, 16 Jul 2009 10:15:27 +0200
Message-ID: <20090716081527.GA29374@mail.gnudd.com>
References: <200907160051.04506.david-b@pacbell.net>
	<200907151106.47917.david-b@pacbell.net>
	<20090715093313.GA2897@mail.gnudd.com>
	<20090715193326.GA13306@mail.gnudd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail2.gnudd.com ([213.203.150.91]:63037 "EHLO mail.gnudd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752916AbZGPIPv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Jul 2009 04:15:51 -0400
Content-Disposition: inline
In-Reply-To: <200907160051.04506.david-b@pacbell.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dbrownell@users.sourceforge.net
Cc: linux-input@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.arm.linux.org.uk

> If you're referring to the way the spi_message and spi_transfer
> structs sit in the same cache lines as the data buffers, that's
> something that should get fixed.

Yes, that's what my patch did. The "strange" part is using a single
malloc instead of three (re-reading your message, the full-duplex
isn't involved here, so I'm not sure tx and rx data can safely be
merged in a cache line).

> It seems that e8f462d202026d8e99f553ed5a09422321226ac9 wasn't a
> complete fix ... this explains why the touchscreen behaves but
> not the ADC inputs (as you noted).

Yes, basically I did the same split of data from control.

> Note that this issue is unrelated to full duplex DMA support.

Yes, that's right. But full duplex is not involved here, it's
just 2 or 3 rounds of "one byte tx then two bytes rx".

/alessandro
