From: "DISTEC Inan, Ahmet" <Inan@distec.de>
Subject: Re: [PATCH] Input: Add I2C attached EETI EXC3000 multi touch driver
Date: Fri, 22 Sep 2017 16:52:41 +0200
Message-ID: <20170922145241.f5xukjzpb4nwgtbf@dev-ai1.datadisplay.de>
References: <20170920135129.10283-1-inan@distec.de>
 <20170921211551.GB15858@dtor-ws>
 <20170922124852.2bsx45jeqye6qcss@dev-ai1.datadisplay.de>
 <20170922141827.l3hfspj7qtj57yvq@dev-ai1.datadisplay.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.datadisplay.de ([87.191.35.243]:19719 "EHLO
        mail.datadisplay.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751873AbdIVOwn (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 22 Sep 2017 10:52:43 -0400
Content-Disposition: inline
In-Reply-To: <20170922141827.l3hfspj7qtj57yvq@dev-ai1.datadisplay.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Ahmet Inan <xdsopl@gmail.com>

Dear Dmitry,

> please hold merging my EXC3000 patch - something just bit me hard and now I get
> unexplainable hangs since reboot.
Found out what the hang was: need to specify "active low level-sensitive" in the dt.
Fixed it also in the documentation.

I've send you another patch and sorry for the noise ..

Best Regards,

Ahmet

