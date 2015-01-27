From: Srihari Vijayaraghavan <linux.bug.reporting@gmail.com>
Subject: ETPS/2 Elantech Touchpad
Date: Tue, 27 Jan 2015 16:38:59 +1100
Message-ID: <CAEK4c-_dKwL+Xm-vnbXgG-ONAXq7yca27YR60OJ9QtkGnf5x8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:33313 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752072AbbA0Fi7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Jan 2015 00:38:59 -0500
Received: by mail-qc0-f175.google.com with SMTP id c9so10604198qcz.6
        for <linux-input@vger.kernel.org>; Mon, 26 Jan 2015 21:38:59 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Igor Serikov <iserikov@acm.org>
Cc: linux-input@vger.kernel.org

[Sorry am not subscribed to linux-input; so in email replies please cc me.]

Hello Igor,

Seeing your "ETPS/2 Elantech Touchpad" report on linux input archive
[1], I wondered whether the patch as per kernel bugzilla 81331 helps
you.

That patch [2] has been in upstream since 3.19-rc6 (similarly will be
in the upcoming stables in the next day or two).

On mainline or the upcoming stables, please try using i8042.kbdreset=1
and see if it helps. If it does would be interested in your: #
dmidecode | egrep 'Manufacturer|Product Name' | head -n2

[1] http://marc.info/?l=linux-input&m=142215686827422&w=2
[2] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=66893885bbf95b6c9030d97804cb678a70804edf
, specifically https://git.kernel.org/cgit/linux/kernel/git/dtor/input.git/commit/?h=for-linus&id=148e9a711e034e06310a8c36b64957934ebe30f2

Thanks

-- 
Srihari Vijayaraghavan
