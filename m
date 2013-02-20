From: Daniel Hellstrom <daniel@gaisler.com>
Subject: Submitting patch shortly
Date: Wed, 20 Feb 2013 15:34:28 +0100
Message-ID: <5124DEF4.4050009@gaisler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from vsp-authed02.binero.net ([195.74.38.226]:14294 "HELO
	vsp-authed-02-02.binero.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S933182Ab3BTOfQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Feb 2013 09:35:16 -0500
Received: from smtp01.binero.se (unknown [195.74.38.28])
	by vsp-authed-02-02.binero.net (Halon Mail Gateway) with ESMTP
	for <linux-input@vger.kernel.org>; Wed, 20 Feb 2013 15:35:07 +0100 (CET)
Received: from [192.168.0.47] (static-92-33-28-242.sme.bredbandsbolaget.se [92.33.28.242])
	(Authenticated sender: daniel@gaisler.com)
	by smtp-01-01.atm.binero.net (Postfix) with ESMTPSA id B40AF3A1D3
	for <linux-input@vger.kernel.org>; Wed, 20 Feb 2013 15:35:07 +0100 (CET)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello,

I'm about to send a patch that adds support for the GRLIB APBPS2 device which is a input/serio PS/2 controller for keyboard and mouse. The APBPS2 PS/2 controller is found in the open source hardware 
architecture of SPARC/LEON.

I didn't find which repository/branch to base my work against, so I have used Linus current mainline. I hope it doesn't impose any problems.

Thanks,
Daniel Hellstrom
