From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH v3] add sur40 driver for Samsung SUR40 (aka MS Surface
 2.0/Pixelsense)
Date: Fri, 8 Nov 2013 22:37:12 +0100
Message-ID: <20131108213712.GA10121@polaris.bitmath.org>
References: <1383748012-28880-1-git-send-email-floe@butterbrot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-h22.telenor.se ([195.54.99.197]:52068 "EHLO
	smtprelay-h22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757848Ab3KHVyv (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Nov 2013 16:54:51 -0500
Received: from ipb4.telenor.se (ipb4.telenor.se [195.54.127.167])
	by smtprelay-h22.telenor.se (Postfix) with ESMTP id 98B65EA484
	for <linux-input@vger.kernel.org>; Fri,  8 Nov 2013 22:35:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1383748012-28880-1-git-send-email-floe@butterbrot.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Florian Echtler <floe@butterbrot.org>
Cc: linux-input@vger.kernel.org, benjamin.tissoires@gmail.com, dmitry.torokhov@gmail.com, dh.herrmann@gmail.com

Hi Florian,

> This patch adds support for the built-in multitouch sensor in the Samsung
> SUR40 touchscreen device, also known as Microsoft Surface 2.0 or Microsoft
> Pixelsense. Support for raw video output from the sensor as well as the 
> accelerometer will be added in a later patch.
> 
> Signed-off-by: Florian Echtler <floe@butterbrot.org>
> ---
>  drivers/input/touchscreen/Kconfig  |   10 +
>  drivers/input/touchscreen/Makefile |    1 +
>  drivers/input/touchscreen/sur40.c  |  467 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 478 insertions(+)
>  create mode 100644 drivers/input/touchscreen/sur40.c

The driver looks pretty good now, thanks for making the changes. There
might be one or two white space problems, but those can be fixed while
applying. Dmitry, I guess you want to take this through your tree, so

Reviewed-by: Henrik Rydberg <rydberg@euromail.se>

Thanks,
Henrik
