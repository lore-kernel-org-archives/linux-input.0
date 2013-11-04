From: Marc <case@corpsmoderne.net>
Subject: Re: About the PS3 Sixaxis linux driver
Date: Tue, 05 Nov 2013 00:03:06 +0100
Message-ID: <527827AA.7050406@corpsmoderne.net>
References: <526A697E.7050605@corpsmoderne.net>	<1256411740.1745741.1383597450835.JavaMail.root@redhat.com> <20131104221824.2bd181e60f01f41e1e4f4898@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from corpsmoderne.net ([88.191.127.221]:42648 "EHLO corpsmoderne.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750819Ab3KDXJV (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 4 Nov 2013 18:09:21 -0500
In-Reply-To: <20131104221824.2bd181e60f01f41e1e4f4898@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>, Benjamin Tissoires <btissoir@redhat.com>
Cc: linux-input@vger.kernel.org

Thanks a lot Benjamin (and everyone) to handle this.

Just to let you know, I've updated from 3.5 to 3.11
(basically, from stock ubuntu-12.04 to stock ubuntu-13.10)
and the bug is still there.

On 11/04/2013 10:18 PM, Antonio Ospite wrote:
> The problem with the left D-PAD should be the one I talk about here:
> http://www.spinics.net/lists/linux-input/msg16881.html

I'll try that as soon as possible, but as you noted, it's not a viable
solution for the long term...

> Marc, if you need the latest BlueZ patches for pairing the sixaxis for
> BT operation just let me know.

I forgot to say I've only tested through tethered USB. I'm not even
sure to have a functioning BT host :) but thanks for the proposal.

On 11/04/2013 10:40 PM, simon@mungewell.org wrote:
 > We did some patching here:
 > 
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/hid/hid-sony.c?id=refs/tags/v3.12#n301
 > 
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/hid/hid-sony.c?id=61ab44bebdefab296487e7cd723a634849278827

The kernel I'm currently running (ubuntu-saucy) includes this patch.
Also, I'm not very good at this, but I've made a diff of the last
version of hid-sony.c and the version currently in ubuntu-saucy (3.11) :
the changes are minimal and can't have fixed the bug (see bellow).

$ diff hid-sony.c ~/ubuntu-saucy/drivers/hid/hid-sony.c
631c631
< 	sc = devm_kzalloc(&hdev->dev, sizeof(*sc), GFP_KERNEL);
---
 > 	sc = kzalloc(sizeof(*sc), GFP_KERNEL);
643c643
< 		return ret;
---
 > 		goto err_free;
656c656
< 		return ret;
---
 > 		goto err_free;
675a676,677
 > err_free:
 > 	kfree(sc);
686a689
 > 	kfree(sc);


-- 
Marc
