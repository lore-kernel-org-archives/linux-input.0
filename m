From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] drivers/input/misc/pcap: a possible sleep-in-atomic bug in
 pcap_keys_handler
Date: Tue, 12 Dec 2017 16:32:01 +0800
Message-ID: <9af81fe8-e07c-9161-2d85-3eb23a198ec9@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:44740 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751281AbdLLIcP (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 12 Dec 2017 03:32:15 -0500
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, ilya.muromec@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

According to drivers/input/misc/pcap_keys.c, the kernel module may sleep 
in the interrupt handler.
The function call path is:
pcap_keys_handler (interrupt handler)
   ezx_pcap_read
     mutex_lock --> may sleep

I do not find a good way to fix it, so I only report.
This possible bug is found by my static analysis tool (DSAC) and checked 
by my code review.


Thanks,
Jia-Ju Bai
