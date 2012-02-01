From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: not supported hardware: Gigabyte K8100 Aivia USB Gaming
 Keyboard
Date: Wed, 1 Feb 2012 21:06:00 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1202012104030.18918@pobox.suse.cz>
References: <4D55AE81.3030805@freemail.hu> <20120126002100.GA4495@burratino> <4F21C49D.2010906@freemail.hu> <20120126213939.GA5179@burratino> <4F230A1A.7080508@freemail.hu> <20120128071223.GA27331@burratino> <4F299010.5090009@freemail.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:35670 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753444Ab2BAUGC (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 1 Feb 2012 15:06:02 -0500
In-Reply-To: <4F299010.5090009@freemail.hu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: zitev <zitev@freemail.hu>
Cc: Jonathan Nieder <jrnieder@gmail.com>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On Wed, 1 Feb 2012, zitev wrote:

> I did every step of test, but after testing the /tmp/mon.out file is 0byte
> (empty)
> 
> next task?

Does /dev/input/eventX get created? (I guess it does, as at least some 
key(s) make it through).

If so, please provide

	cat /sys/kernel/debug/hid/<device>/rdesc

and
	cat /sys/kernel/debug/hid/<device>/events

Please run the second command, then press some of the non-working keys 
(press "a" for starters), and provide the output.

-- 
Jiri Kosina
SUSE Labs
