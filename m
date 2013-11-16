From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH v3] add sur40 driver for Samsung SUR40 (aka MS Surface
 2.0/Pixelsense)
Date: Sat, 16 Nov 2013 19:08:38 +0100
Message-ID: <20131116180838.GA21591@polaris.bitmath.org>
References: <1383748012-28880-1-git-send-email-floe@butterbrot.org>
 <20131111073105.GA7645@core.coreip.homeip.net>
 <5280AC87.4020905@butterbrot.org>
 <5280B0FE.5080203@euromail.se>
 <52822E8B.6030906@butterbrot.org>
 <52875AEF.2010109@butterbrot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b31.telenor.se ([213.150.131.20]:32885 "EHLO
	smtprelay-b31.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303Ab3KPSF4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 16 Nov 2013 13:05:56 -0500
Received: from ipb5.telenor.se (ipb5.telenor.se [195.54.127.168])
	by smtprelay-b31.telenor.se (Postfix) with ESMTP id 6DE50E8BDA
	for <linux-input@vger.kernel.org>; Sat, 16 Nov 2013 19:05:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <52875AEF.2010109@butterbrot.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Florian Echtler <floe@butterbrot.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, benjamin.tissoires@gmail.com, dh.herrmann@gmail.com

Hi Florian,

> Looks like the sur40 driver didn't make it into the 3.13 pull request,
> anything still missing/broken? I was hoping this might still make it into
> Ubuntu 14.04...

Nothing is broken, don't worry. If you want to make sure to hit a
certain merge window, then everything should be set and applied
several weeks before that, to allow for automatic testing and
administration. It could be that Dmitry is stacking up for a second
pull request in a couple of weeks, but I would not count on it. If you
want Ubuntu to pick your patches up, you can always try to send them
to kernel-team@lists.ubuntu.com; they might be willing to carry your
patches to the next kernel release. It helps to refer to the
appropriate commits in linux-next.

Thanks,
Henrik
