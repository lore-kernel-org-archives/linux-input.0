From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH 0/2] Input: zforce - update GPIO handling
Date: Fri, 3 Jul 2015 11:07:47 +0200
Message-ID: <1435914469-8955-1-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from imta21.fe.bosch.de ([139.15.243.226]:17739 "EHLO
	imta21.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754079AbbGCJHz (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 Jul 2015 05:07:55 -0400
Received: from smtp6-v.fe.bosch.de (imta23.fe.bosch.de [139.15.243.227])
	by imta21.fe.bosch.de (Postfix) with ESMTP id 5C740C04ED
	for <linux-input@vger.kernel.org>; Fri,  3 Jul 2015 11:07:54 +0200 (CEST)
Received: from vsmta12.fe.internet.bosch.com (unknown [10.4.98.52])
	by imta23.fe.bosch.de (Postfix) with ESMTP id 9BD42158024A
	for <linux-input@vger.kernel.org>; Fri,  3 Jul 2015 11:07:52 +0200 (CEST)
Received: from SI-HUB1000.de.bosch.com (vsgw23.fe.internet.bosch.com [10.4.98.23])
	by vsmta12.fe.internet.bosch.com (Postfix) with ESMTP id 5ACCB1B804D0
	for <linux-input@vger.kernel.org>; Fri,  3 Jul 2015 11:07:52 +0200 (CEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Dirk Behme <dirk.behme@de.bosch.com>

This patch series updates the GPIO handling of the zforce driver.

The first patch is the same like the already sent one

http://www.spinics.net/lists/linux-input/msg39228.html

without any changes and therefore replaces that one.

The second one is new and implements the conversion to the gpiod framework
as reuested in the review comments of the first change.

Dirk
