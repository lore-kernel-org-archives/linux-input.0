From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: Input: atmel_mxt_ts - status of the for-dtor branch and sscanf issue
Date: Mon, 19 Jan 2015 14:08:41 +0100
Message-ID: <54BD01D9.90608@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from imta21.fe.bosch.de ([139.15.243.226]:43836 "EHLO
	imta21.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461AbbASNIp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Jan 2015 08:08:45 -0500
Received: from smtp6-v.fe.bosch.de (imta23.fe.bosch.de [139.15.243.227])
	by imta21.fe.bosch.de (Postfix) with ESMTP id B31B7C0234
	for <linux-input@vger.kernel.org>; Mon, 19 Jan 2015 14:08:43 +0100 (CET)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick.dyer@itdev.co.uk>
Cc: linux-input@vger.kernel.org

Hi Nick,

we have two questions regarding the atmel_mxt_ts driver:

First, what's the status of your github 'for-dtor' branch [1]? Is this 
subject to change? Or how stable is it? Will it go into mainline, soon?

We've tested the patches in that branch on top of the mainline ~v3.18 
atmel_mxt_ts patches and they improve the driver a lot. So we'd like to 
pick that patches into our internal development tree.


Second, with that branch, doing a config file download, we sometimes 
randomly get

atmel_mxt_ts 2-004a: Bad format: failed to parse object
atmel_mxt_ts 2-004a: Error -22 updating config

at the end of the parsing, depending on the byte following the 
firmware/config file in memory. Our config file does have CR/LF endings. 
The sscanf() returns "1" in that case.

A quick hack solution to that is skipping the last two bytes [2]. What 
do you think?

Best regards

Dirk

[1] https://github.com/ndyer/linux/commits/for-dtor

[2]

@@ -1586,7 +1586,7 @@ static int mxt_prepare_cfg_mem(struct mxt_data *data,
         u16 reg;
         u8 val;

-       while (data_pos < cfg->size) {
+       while ((data_pos + 2) < cfg->size) {
                 /* Read type, instance, length */
                 ret = sscanf(cfg->data + data_pos, "%x %x %x%n",
                              &type, &instance, &size, &offset);
