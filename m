From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [v3 1/3] 1/3 Touchscreen: Cypress TTSP G3 MTDEV Core Driver
Date: Mon, 3 Jan 2011 19:45:33 +0100
Message-ID: <20110103184533.GA7035@polaris.bitmath.org>
References: <kev@cypress.com>
 <1293650268-1561-1-git-send-email-kev@cypress.com>
 <20101231115323.GA9709@polaris.bitmath.org>
 <FB9C2CB29A07AB45B575A4E8D2AABC09013FFF98@labamba.mis.cypress.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <FB9C2CB29A07AB45B575A4E8D2AABC09013FFF98@labamba.mis.cypress.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin McNeely <Kevin.McNeely@cypress.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Brown <davidb@codeaurora.org>, Trilok Soni <tsoni@codeaurora.org>, Samuel Ortiz <sameo@linux.intel.com>, Eric Miao <eric.y.miao@gmail.com>, Mike Frysinger <vapier@gentoo.org>, Alan Cox <alan@linux.intel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

> > If the in-kernel tracking module was in place, would you consider
> > switching to the slots protocol?
> 
> Hi Henrik, can you please clarify?  Should I remove MTDEV from the patch
> title?

Let me start over - is there a way to reliably track contacts from the
device? If yes, the question is whether you would consider switching
to type B right away. If no, the question was whether you would
consider a switch to type B if there was a in-kernel tracking module
to use. I understand if there are other reasons to stay with type A, I
am mostly curious.

And perhaps MTDEV is a bit misplaced in the title, unless it has
something to do with the device.

Thanks,
Henrik
