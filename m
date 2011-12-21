From: john stultz <johnstul@us.ibm.com>
Subject: Re: [RFC][PATCH] Input: Use monotonic time for event time stamps.
Date: Tue, 20 Dec 2011 18:29:34 -0800
Message-ID: <1324434574.30527.102.camel@work-vm>
References: <1324429303.30527.92.camel@work-vm>
	 <4EF1395E.405@cn.fujitsu.com>
	 <CAGS+omABqM84X=uoY1bGnAD-9DSR6qjrod8Teksm3qeiG2YGew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from e39.co.us.ibm.com ([32.97.110.160]:49766 "EHLO
	e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097Ab1LUC3j (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Dec 2011 21:29:39 -0500
Received: from /spool/local
	by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-input@vger.kernel.org> from <johnstul@us.ibm.com>;
	Tue, 20 Dec 2011 19:29:38 -0700
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id pBL2TaiF129108
	for <linux-input@vger.kernel.org>; Tue, 20 Dec 2011 19:29:36 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id pBL2TZqZ012901
	for <linux-input@vger.kernel.org>; Tue, 20 Dec 2011 19:29:35 -0700
In-Reply-To: <CAGS+omABqM84X=uoY1bGnAD-9DSR6qjrod8Teksm3qeiG2YGew@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@google.com>
Cc: gaowanlong@cn.fujitsu.com, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>

On Wed, 2011-12-21 at 10:11 +0800, Daniel Kurtz wrote:
> Maybe you will have more luck this time.  You can read the previous
> thread on this exact topic, here:
> https://lkml.org/lkml/2011/10/3/37
> 
> The previous attempt got bogged down when people wanted more data on
> use cases and how this patch would promote world peace.  I strongly
> support the concept, but we found other ways to address our major
> concern at the time, so didn't invest more effort to get that patch
> accepted.

Also, are you able to discuss the alternative way you addressed the
issue?

thanks
-john

