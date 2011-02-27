From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [v4 1/3] 1/3 Touchscreen: Cypress TTSP G3 Core Driver
Date: Sun, 27 Feb 2011 13:34:05 +0100
Message-ID: <20110227123405.GA4961@polaris.bitmath.org>
References: <kev@cypress.com>
 <1294188847-24728-1-git-send-email-kev@cypress.com>
 <20110105085942.GA23321@polaris.bitmath.org>
 <FB9C2CB29A07AB45B575A4E8D2AABC09014003B8@labamba.mis.cypress.com>
 <20110105173403.GA2146@polaris.bitmath.org>
 <FB9C2CB29A07AB45B575A4E8D2AABC0901629825@labamba.mis.cypress.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:42639 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751150Ab1B0Mdr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 27 Feb 2011 07:33:47 -0500
Content-Disposition: inline
In-Reply-To: <FB9C2CB29A07AB45B575A4E8D2AABC0901629825@labamba.mis.cypress.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kevin McNeely <Kevin.McNeely@cypress.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Brown <davidb@codeaurora.org>, Trilok Soni <tsoni@codeaurora.org>, Samuel Ortiz <sameo@linux.intel.com>, Eric Miao <eric.y.miao@gmail.com>, Mike Frysinger <vapier@gentoo.org>, Alan Cox <alan@linux.intel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Kevin,

> I have been testing with Android based systems.
> What system configurations are good for testing the slot handling in
> Protocol B?

The mtview project is a graphical way to test out hardware [1]. If no
graphics is wanted, there is utouch-frame. For low-level testing, the
mtdev project can be used, or even evtest.

Thanks,
Henrik

[1] https://launchpad.net/mtview/, or http://bitmath.org/code/mtview/
