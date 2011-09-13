From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: [PATCH 0/3] TSC-40 touch screen driver
Date: Tue, 13 Sep 2011 10:18:07 +0200
Message-ID: <CAH9NwWca_AvyG=BdN9HeUKST1hi-L+Dos2T10SpZaLZjfdzJ6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:40617 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753596Ab1IMIX4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Sep 2011 04:23:56 -0400
Received: by yxm8 with SMTP id 8so240243yxm.19
        for <linux-input@vger.kernel.org>; Tue, 13 Sep 2011 01:23:55 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: bigeasy@linutronix.de

This patch series adds the TSC-40 serial touchscreen driver, which
should be compatible
with TSC-10 and TSC-25. The driver was written by Linutronix on behalf
of Bachmann electronic GmbH.
During development of our Linux based system some changes were made.
I hope to get this driver into mainline and so every feedback is
welcome and will be incorporated.

This work is sponsored by Bachmann electronic GmbH.
--
Christian Gmeiner, MSc
