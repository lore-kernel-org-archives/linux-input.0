From: Ferenc Wagner <wferi@niif.hu>
Subject: Bug 27362 - ThinkPad Fn key types NULs into the console
Date: Fri, 28 Jan 2011 11:39:37 +0100
Message-ID: <87lj25ia6u.fsf@tac.ki.iif.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from tac.ki.iif.hu ([193.6.222.43]:34495 "EHLO tac.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753355Ab1A1Kjj (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Jan 2011 05:39:39 -0500
Received: from wferi by tac.ki.iif.hu with local (Exim 4.72)
	(envelope-from <wferi@niif.hu>)
	id 1Piljt-0006XB-Vp
	for linux-input@vger.kernel.org; Fri, 28 Jan 2011 11:39:38 +0100
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

I hope it's appropriate to advertise my kernel bug here to get some
traction...

In short: under vanilla 2.6.37, the Fn key of my ThinkPad R50e is active
on the console: it adds NUL characters to the input stream on each
release.  This happens without any userspace involvement, at the very
start of the initramfs phase of bootup (after break=top for those using
initramfs-tools):

(initramfs) cat
^@

At this stage no modules are loaded (my .config and dmesg is linked from
https://bugzilla.kernel.org/show_bug.cgi?id=27362).  Showkey prints
0x00 0x81 0x8f 0x00 0x81 0x8f on release of the Fn key (with autorepeat).

These NUL characters constitute a bug in my opinion.  Please let me know
if I can help finding the cause.
-- 
Thanks,
Feri.
