From: Libo Chen <clbchenlibo.chen@huawei.com>
Subject: [PATCH 0/3] driver: input: fix missing of_node_put
Date: Sat, 31 Aug 2013 14:44:47 +0800
Message-ID: <522190DF.80506@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:34180 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756979Ab3HaGpl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 31 Aug 2013 02:45:41 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: peter.ujfalusi@ti.com, Bill Pemberton <wfp5p@virginia.edu>, broonie@opensource.wolfsonmicro.com, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Li Zefan <lizefan@huawei.com>, "zhangwei(Jovi)" <jovi.zhangwei@huawei.com>


decrease np device_node refcount after task completion

Libo Chen (3):
  driver: input: 88pm860x-ts: fix missing of_node_put
  driver: input: twl4030-vibra: fix missing of_node_put
  driver: input: twl6040-vibra: fix missing of_node_put

 drivers/input/misc/twl4030-vibra.c      |    4 +++-
 drivers/input/misc/twl6040-vibra.c      |    3 +++
 drivers/input/touchscreen/88pm860x-ts.c |   22 +++++++++++++++-------
 3 files changed, 21 insertions(+), 8 deletions(-)

