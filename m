From: Fabio Estevam <festevam@gmail.com>
Subject: MX25 Touch on 4.7-rc
Date: Mon, 6 Jun 2016 13:52:40 -0300
Message-ID: <CAOMZO5BrXsBVr7ny7r7LtHOoyxYZALik1N7P+F93dnQEPxKDxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:36415 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105AbcFFQwl (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Jun 2016 12:52:41 -0400
Received: by mail-io0-f174.google.com with SMTP id n127so21981128iof.3
        for <linux-input@vger.kernel.org>; Mon, 06 Jun 2016 09:52:41 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: linux-input@vger.kernel.org

Hi Markus,

I am trying your mx25 touchscreen driver on 4.7-rc1, but it fails as:

mx25-tcq 50030000.tscadc:tcq@50030400: invalid resource
mx25-tcq: probe of 50030000.tscadc:tcq@50030400 failed with error -22

Do we have missing patches for this?

Thanks
