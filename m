From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] CHROMIUM: Input: synaptics - filter out the events with
 low z values
Date: Fri, 24 Feb 2012 10:08:35 +0100
Message-ID: <20120224090835.GA2154@polaris.bitmath.org>
References: <1329896503-28394-1-git-send-email-cywang@chromium.org>
 <20120222083858.GA26570@polaris.bitmath.org>
 <CAGS+omCU9f=DyC442+4HOF=sGhZYXne+E2ephFiOmuj-XKciMA@mail.gmail.com>
 <20120222110459.GA28126@polaris.bitmath.org>
 <CAGS+omB0GCQHOjrb_T6h7DzHrH2sp4Xqb5av6JC-ttJ8HZ5BcQ@mail.gmail.com>
 <20120222152425.GA29436@polaris.bitmath.org>
 <20120224082706.GB18291@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b12.telenor.se ([62.127.194.21]:55647 "EHLO
	smtprelay-b12.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755548Ab2BXJIk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Feb 2012 04:08:40 -0500
Content-Disposition: inline
In-Reply-To: <20120224082706.GB18291@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Daniel Kurtz <djkurtz@chromium.org>, Chung-yih Wang <cywang@chromium.org>, Alessandro Rubini <rubini@ipvvis.unipv.it>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

> > The most striking effect is the ability to better retain a
> > drag. Although the statement was made in light of possible
> > (1-strong,1-weak) packets, it should help in the 2-weak case too.
> 
> The bigger question is why is this needed in kernel. The original
> hysteresis with BTN_TOUCH was done for sole benefit of mousedev so that
> we could allow somewhat better transition from standard PS/2 mode into
> native Synaptics mode with absolute coordinates at time when barely
> anyone had Synaptics X driver installed. This was, what, 10 years ago?

The semi-mt behavior is obviously a special case, where userspace
relies on the reported number of fingers to transition between one
touch and two touches. There is no pressure information sent to
userspace in this case, so the situation is in fact quite similar to
the ancient mousedev situation.

Henrik
