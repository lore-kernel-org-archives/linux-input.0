From: Shaobo <shaobo@cs.utah.edu>
Subject: Help with confirming an error trace in
 drivers/input/touchscreen/ad7879-spi.c
Date: Thu, 16 Feb 2017 16:27:00 -0700
Message-ID: <7a8799eb4ddca5b4b52991158f8ddc87@cs.utah.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rio.cs.utah.edu ([155.98.64.241]:49704 "EHLO
        mail-svr1.cs.utah.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933590AbdBPX1B (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 16 Feb 2017 18:27:01 -0500
Received: from mail-svr1.cs.utah.edu (localhost [127.0.0.1])
        by mail-svr1.cs.utah.edu (Postfix) with ESMTP id 42C0B65009D
        for <linux-input@vger.kernel.org>; Thu, 16 Feb 2017 16:27:00 -0700 (MST)
Received: from webmail.cs.utah.edu (geneva.cs.utah.edu [155.98.65.60])
        by mail-svr1.cs.utah.edu (Postfix) with ESMTP
        for <linux-input@vger.kernel.org>; Thu, 16 Feb 2017 16:27:00 -0700 (MST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi there,

My name is Shaobo He and I am a graduate student at University of Utah. 
I am applying a static analysis tool to the Linux device drivers and got 
an error trace of null pointer dereference in 
drivers/input/touchscreen/ad7879-spi.c staring from 
`ad7879_spi_multi_read`: it calls `ad7879_spi_xfer` with the argument 
`tx_buf` being NULL, which gets dereferenced at line 52 given the 
argument `count` being 1. As you can see, the error trace is only 
plausible since it depends on certain conditions. To be more specific, 
is it possible for the count argument to be 1. Therefore, I was 
wondering if you could help me confirm it since you are one of the 
authors of this driver.

Thanks for your time. I am looking forward to your reply.

Best,
Shaobo
