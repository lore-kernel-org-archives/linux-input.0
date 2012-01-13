From: simon.budig@kernelconcepts.de
Subject: [PATCH v3] Touchscreen driver for FT5x06 based EDT displays
Date: Fri, 13 Jan 2012 01:13:07 +0100
Message-ID: <1326413588-30517-1-git-send-email-simon.budig@kernelconcepts.de>
References: <1326413229-30282-1-git-send-email-simon.budig@kernelconcepts.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay05.ispgateway.de ([80.67.31.99]:58870 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755715Ab2AMASy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Jan 2012 19:18:54 -0500
In-Reply-To: <1326413229-30282-1-git-send-email-simon.budig@kernelconcepts.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, agust@denx.de, yanok@emcraft.com

This is a driver for the EDT ft5x06 based capacitive touchscreens.

The driver supports up to 5 touch points, the "gain", "threshold" and "offset"
parameters can be configured via some files in the sysfs.

It also is possible to acquire some raw data from the sensor by putting the
sensor in a factory mode ("mode" file in sysfs) and then reading the "raw" 
file, which contains the raw touch data. In factory mode the reporting of
regular events will stop.

This is the 3rd iteration of the patch, based on the head of Linus' kernel
tree.

Thanks,
        Simon Budig

