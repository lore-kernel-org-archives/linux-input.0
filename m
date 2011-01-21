From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: replace request_irq by request_any_context_irq in
 keyboard GPIO driver
Date: Thu, 20 Jan 2011 23:10:27 -0800
Message-ID: <20110121071027.GB21842@core.coreip.homeip.net>
References: <1294825292-24134-1-git-send-email-philippe.langlais@stericsson.com>
 <1294825292-24134-2-git-send-email-philippe.langlais@stericsson.com>
 <20110120075348.GE30522@core.coreip.homeip.net>
 <20110120092330.GA1316@bnru05.bnr.st.com>
 <20110120100419.GA3515@core.coreip.homeip.net>
 <4D38273A.4020602@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:33056 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752966Ab1AUHKf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Jan 2011 02:10:35 -0500
Received: by pva4 with SMTP id 4so241003pva.19
        for <linux-input@vger.kernel.org>; Thu, 20 Jan 2011 23:10:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D38273A.4020602@stericsson.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Philippe Langlais <philippe.langlais@stericsson.com>
Cc: Rabin VINCENT <rabin.vincent@stericsson.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, Trilok Soni <tsoni@codeaurora.org>, "lee.jones@linaro.org" <lee.jones@linaro.org>

On Thu, Jan 20, 2011 at 01:14:50PM +0100, Philippe Langlais wrote:
> Dmitry,
> 
> Sorry, I arrive after the war, thanks Rabin for your answer.
> When can I hope this patch merged in kernel?

Applied and will be included in the next pull request.

Thanks!

-- 
Dmitry
