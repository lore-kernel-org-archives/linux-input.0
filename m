From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [RFC] Input: implement sysrq as an input handler
Date: Thu, 18 Mar 2010 21:00:43 -0300
Message-ID: <20100319000043.GC12017@khazad-dum.debian.net>
References: <20100317061952.GA19789@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:54976 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751704Ab0CSAAq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Mar 2010 20:00:46 -0400
Content-Disposition: inline
In-Reply-To: <20100317061952.GA19789@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jason Wessel <jason.wessel@windriver.com>

Any chance of the user being able to avoid the SysRQ events getting to the
handle, e.g. by opening the input device in exclusive mode or something like
that?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
