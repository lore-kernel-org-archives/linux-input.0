From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: not supported hardware: Gigabyte K8100 Aivia USB Gaming Keyboard
Date: Wed, 1 Feb 2012 13:35:32 -0600
Message-ID: <20120201193531.GA28375@burratino>
References: <4D55AE81.3030805@freemail.hu>
 <20120126002100.GA4495@burratino>
 <4F21C49D.2010906@freemail.hu>
 <20120126213939.GA5179@burratino>
 <4F230A1A.7080508@freemail.hu>
 <20120128071223.GA27331@burratino>
 <4F299010.5090009@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:46423 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755160Ab2BATf4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 1 Feb 2012 14:35:56 -0500
Content-Disposition: inline
In-Reply-To: <4F299010.5090009@freemail.hu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: zitev <zitev@freemail.hu>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, jkosina@suse.cz

zitev wrote:

> I did every step of test, but after testing the /tmp/mon.out file is
> 0byte (empty)

Drat.  Just to make sure I have the method right, could you do the
same with another keyboard (setting the bus number accordingly), or
using some key that does work, if any (e.g., backspace is said to
work)?

But anyway, this is believable.  There is a Windows driver for the
keyboard, so if you are able to run Windows (e.g., in a VM), the hints
from

 http://libnetmd.sourceforge.net/howto.html

might help.  Also, contacting the manufacturer might help.

Given a rough description of the protocol the keyboard uses, folks on
this mailing list might be able to come up with a rough patch to try
out.  One way to make progress.

Thanks,
Jonathan
