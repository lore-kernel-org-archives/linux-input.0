From: simon.budig@kernelconcepts.de
Subject: Touch screen driver for the EDT FT5x06 based "polytouch" touchscreens
Date: Mon, 26 Sep 2011 18:06:28 +0200
Message-ID: <1317053189-29831-1-git-send-email-simon.budig@kernelconcepts.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay03.ispgateway.de ([80.67.31.41]:40875 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481Ab1IZQNB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Sep 2011 12:13:01 -0400
Received: from [217.146.132.69] (helo=mezzanine)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <simon@budig.de>)
	id 1R8DhV-0007P7-2x
	for linux-input@vger.kernel.org; Mon, 26 Sep 2011 18:06:37 +0200
Received: from simon by mezzanine with local (Exim 4.74)
	(envelope-from <simon@budig.de>)
	id 1R8DhU-0007lq-OU
	for linux-input@vger.kernel.org; Mon, 26 Sep 2011 18:06:36 +0200
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi all.

This is a driver for the EDT ft5x06 based capacitive touchscreens.

The driver supports up to 5 touch points, the "gain", "threshold" and "offset"
parameters can be configured via some files in the sysfs.

It also is possible to acquire some raw data from the sensor by putting the
sensor in a factory mode ("mode" file in sysfs) and then reading the "raw" 
file, which contains the raw touch data. In factory mode the reporting of
regular events will stop.

I hope this can get integrated upstream, I appreciate any hints and 
suggestions regarding the code.

Thanks,
        Simon Budig

