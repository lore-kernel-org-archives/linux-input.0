From: Jan Kandziora <jjj@gmx.de>
Subject: Re: Posiflex 0d3a:a000 touchscreen press not recognized in kernel
 3.9.4
Date: Wed, 19 Jun 2013 18:42:51 +0200
Message-ID: <51C1DF8B.3010101@gmx.de>
References: <51C159C5.7070702@gmx.de> <CAN+gG=HCREVXCsQjGjyJApR=U=TO4Kvaa1s+X-UEVe6akyj-7Q@mail.gmail.com> <51C17882.4050206@gmx.de> <51C1D4C8.5040201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.20]:57992 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934925Ab3FSQmy (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Jun 2013 12:42:54 -0400
Received: from mailout-de.gmx.net ([10.1.76.31]) by mrigmx.server.lan
 (mrigmx002) with ESMTP (Nemesis) id 0McCSH-1UZ2s60IjP-00Jc56 for
 <linux-input@vger.kernel.org>; Wed, 19 Jun 2013 18:42:53 +0200
In-Reply-To: <51C1D4C8.5040201@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

Am 19.06.2013 17:56, schrieb Benjamin Tissoires:
> 
> Thanks for the logs. The problem comes from a commit introduced in 3.3 which discards the BTN_LEFT information.
> 
> If possible, can you apply and test the following patch?
> 
It works. Many thanks for making a patch that quick.

Kind regards

	Jan
