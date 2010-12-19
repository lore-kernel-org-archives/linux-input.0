From: Richard Nauber <richard.nauber@googlemail.com>
Subject: [Tool] mtdev2tuio - a Linux multitouch device to TUIO bridge
Date: Sun, 19 Dec 2010 10:45:42 +0100
Message-ID: <1292751943.12340.314.camel@itzy>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f45.google.com ([209.85.214.45]:45388 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751670Ab0LSJp6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 19 Dec 2010 04:45:58 -0500
Received: by bwz16 with SMTP id 16so2406754bwz.4
        for <linux-input@vger.kernel.org>; Sun, 19 Dec 2010 01:45:56 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>
Cc: Henrik Rydberg <rydberg@euromail.se>

Hi there,
I like to introduce a little tool that allows to use a
multitouch-capable device (when supported by the linux kernel) as TUIO
client. This enables you to show off with a bunch of existing software
(e.g. a compiz plugin, multitouch numptyphysics, and a lot more:
http://www.tuio.org/?showcase ). The prerequisites are liblo and
libmtdev, which should be pretty standard for modern distributions.

So have a look at
http://repo.or.cz/w/mtdev2tuio.git
and feel free to contribute!

Have fun,
Richard

