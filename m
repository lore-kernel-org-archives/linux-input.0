From: Markus Niebel <list-09_linux_input@tqsc.de>
Subject: Input: ads7846 - sampling logic issues with AD7873
Date: Tue, 29 May 2012 12:47:26 +0200
Message-ID: <4FC4A93E.9040305@tqsc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay01.ispgateway.de ([80.67.31.28]:49647 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271Ab2E2Kvb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 May 2012 06:51:31 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: michael.hennerich@analog.com, dmitry.torokhov@gmail.com

Hi,

we use the AD7873 controller with internal reference. The current implementation for AD7873 in the ads7846 driver forces the vref to switch off after every sample. So measurements especially in the edge of the screen become unreliable due to the settling time for the internal reference (I guess). Is there a special reason to override the "keep_vref_of" setting of the platform data for the AD7873 in ads7846_setup_spi_msg?

We did already some tests and found out, that leaving vref on makes out system usable with AD7873.

Markus

