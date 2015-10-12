From: Sylvain Rochet <sylvain.rochet@finsecur.com>
Subject: Correct property to use for wake up support on rotary encoders
Date: Mon, 12 Oct 2015 18:09:43 +0200
Message-ID: <20151012160943.GA10239@gradator.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx-guillaumet.finsecur.com ([91.217.234.131]:46230 "EHLO
	guillaumet.finsecur.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751178AbbJLQiP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Oct 2015 12:38:15 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: devicetree@vger.kernel.org
Cc: linux-input@vger.kernel.org, Daniel Mack <daniel@caiaq.de>, Johan Hovold <jhovold@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi,

Several month ago I proposed a patch[1][2] to add wake up support to 
rotary encoders[3].

Among all the properties currently used in Linux kernels device trees, 
we have three recognisable patterns for wake up support:
 - driver-name,wakeup
 - linux,wakeup
 - wakeup-source

We don't know which one to use, could you tell which one we should use 
for GPIO rotary encoders ?

Thank you very much :-)

Cheers,
Sylvain

[1] http://comments.gmane.org/gmane.linux.kernel.input/41243
[2] https://patchwork.ozlabs.org/patch/439240/
[3] https://www.kernel.org/doc/Documentation/input/rotary-encoder.txt
