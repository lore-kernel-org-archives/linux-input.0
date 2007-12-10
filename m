From: Taneli =?iso-8859-1?Q?V=E4h=E4kangas?=
	<taneli.vahakangas@welho.com>
Subject: Creative prodikeys
Date: Mon, 10 Dec 2007 06:55:08 +0200
Message-ID: <20071210045508.GB5470@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp4.pp.htv.fi ([213.243.153.38]:40343 "EHLO smtp4.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750941AbXLJFRU (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Dec 2007 00:17:20 -0500
Received: from newer.loc (cs181190089.pp.htv.fi [82.181.190.89])
	by smtp4.pp.htv.fi (Postfix) with ESMTP id B10D85BC028
	for <linux-input@vger.kernel.org>; Mon, 10 Dec 2007 06:55:08 +0200 (EET)
Received: from taneli by newer.loc with local (Exim 4.63)
	(envelope-from <taneli.vahakangas@welho.com>)
	id 1J1afc-0001RA-Lb
	for linux-input@vger.kernel.org; Mon, 10 Dec 2007 06:55:08 +0200
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello!

I'm trying to figure out how to use "Creative Prodikeys" combined PC and
musical keyboard in Linux. The PC keys work ok, in fact this message is
written on that keyboard. However, the input from the musical keys I can
not see anywhere. I tried reading /dev/input/event5 and event6, and also
/dev/usb/hiddev1, but only the PC keys give readings there. Any ideas
how to attack this problem? I'm running Linus' git kernel
2.6.24-rc4-g94545bad.

Cheers,

	Taneli

