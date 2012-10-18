From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v3 1/1] Input: serio - Add ARC PS/2 driver
Date: Thu, 18 Oct 2012 02:27:19 -0700
Message-ID: <1350552439.3072.65.camel@joe-AO722>
References: <1350549367-11098-1-git-send-email-mischa.jonker@synopsys.com>
	 <1350549367-11098-2-git-send-email-mischa.jonker@synopsys.com>
	 <1350550916.3072.61.camel@joe-AO722>
	 <E6BF041E97966E4DB955F0DF883AD2D6019A63@DE02WEMBX1.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from perches-mx.perches.com ([206.117.179.246]:39896 "EHLO
	labridge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755000Ab2JRJ1T (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Oct 2012 05:27:19 -0400
In-Reply-To: <E6BF041E97966E4DB955F0DF883AD2D6019A63@DE02WEMBX1.internal.synopsys.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mischa Jonker <Mischa.Jonker@synopsys.com>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "m.d.s.x.jonker@gmail.com" <m.d.s.x.jonker@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>

On Thu, 2012-10-18 at 09:05 +0000, Mischa Jonker wrote:
> Hi Joe,
> 
> >> +	while (1) {
> >infinite loop with bad hardware?
> >Perhaps a jiffies timeout?
> 
> What do you suggest? Add a counter and limit the maximum number of iterations to an arbitrary number (say 1000)?

Yes, something like that.
Or something like:

	unsigned long timeout = jiffies + somevalue;
	while (time_before(jiffies, timeout) {
		etc...
	}

cheers, Joe

