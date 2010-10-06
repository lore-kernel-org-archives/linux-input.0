From: Sundar R IYER <sundar.iyer@stericsson.com>
Subject: RE: [RFC] input: syfs switches for SKE keypad
Date: Wed, 6 Oct 2010 13:58:28 +0200
Message-ID: <33A307AF30D7BF4F811B1568FE7A9B1804610631B3@EXDCVYMBSTM006.EQ1STM.local>
References: <33A307AF30D7BF4F811B1568FE7A9B180460D32FE2@EXDCVYMBSTM006.EQ1STM.local>
	 <20101005174106.GA21399@core.coreip.homeip.net>
	 <4CAC340B.90207@codeaurora.org>
	 <33A307AF30D7BF4F811B1568FE7A9B180461062FE6@EXDCVYMBSTM006.EQ1STM.local>
 <1286358518.26914.23.camel@4fid08082> <4CAC6053.5020000@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog116.obsmtp.com ([207.126.144.141]:53031 "EHLO
	eu1sys200aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751656Ab0JFL7R convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 6 Oct 2010 07:59:17 -0400
In-Reply-To: <4CAC6053.5020000@codeaurora.org>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Trilok Soni <tsoni@codeaurora.org>, "samu.p.onkalo@nokia.com" <samu.p.onkalo@nokia.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, Linus WALLEIJ <linus.walleij@stericsson.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Jayeeta BANDYOPADHYAY <jayeeta.banerjee@stericsson.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-pm@lists.osdl.org" <linux-pm@lists.osdl.org>

Hi Trilok,

>-----Original Message-----
>From: Trilok Soni [mailto:tsoni@codeaurora.org]
>
>I think what you are referring is similar to Android specific early suspend/resume
>framework. For example, what is the use of TS (if not used as wakeup) resources
>when the screen goes blank, so better to early suspend it rather than waiting
>upto the platform suspend to happen.

I think no. IMO TS should be disabled only when the user decides to lock off
the phone or screen. This is independent of any suspend or early suspend operation.
As Samu said, lots of back ground operations might keep the CPU running.

>I think this can be solved with pm_runtime, isn't it? Though I am not expert
>at pm_runtime, but this framework can be explored to enable these features.
>

Hmm. Yes. Even I think so; but I am not really sure if these run time helpers for
suspend/resume can be invoked from the user space. If I understand correctly, 
a event like a lock-key, keypad slider open/close or MMC slot door close/open
should trigger an event to user space, which can then force devices to suspend/resume.
If this is possible via these runtime_* helpers, then as Dmitry says, it would be up to
the user space to suspend/resume the device; we end up using a single helper for either
run time suspend or platform suspend. Maybe Rafael can comment here.

Regards,
Sundar

