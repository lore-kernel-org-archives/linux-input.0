From: Henrik Rydberg <rydberg@enmesh.se>
Subject: input: mt: Software finger tracking in the kernel?
Date: Fri, 19 Mar 2010 11:58:35 +0100
Message-ID: <4BA358DB.20708@enmesh.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from node01-shml-0001.s.ipeer.se ([213.180.89.85]:56140 "EHLO
	shml-0001.s.ipeer.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751080Ab0CSLFQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Mar 2010 07:05:16 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Dmitry,

there is an ongoing discussion about adding multitouch to X
(http://lists.x.org/archives/xorg-devel/2010-March/006206.html), which is
beginning to take on more solid form.

One of the suggestions emerging from that discussion is to add the software
finger tracking to the kernel. Back in summer 2009 when I thought about this, I
disregarded it as being too experimental. I have since then reconsidered,
starting to think it really is the right place.

The MT protocol allows applications to take advantage of multi-contact hardware,
but leaves the problems of finger tracking and filtering to the user. Arguably,
no application can make good use of MT without these, so the problem is pushed
forward, in this case to evdev or equivalent.

The knowledge of signal-to-noise ratios and prior input states resides in the
kernel. Because of this, the finger matching and filtering would naturally
reside within the kernel.

So, if there were to appear patches to include matching in the input core, would
you consider them? :-)

Cheers,
Henrik

