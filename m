From: Mark Lord <kernel@teksavvy.com>
Subject: 2.6.36/2.6.37: broken compatibility with userspace input-utils ?
Date: Sun, 23 Jan 2011 12:03:47 -0500
Message-ID: <4D3C5F73.2050408@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:33661 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751054Ab1AWRDv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 23 Jan 2011 12:03:51 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linux Kernel <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

As of the 2.6.36 kernel, the userspace commands lsinput and input-kbd
no longer work.  And if I grab newer/patched versions of those from the latest
Ubuntu 10.10, then those newer/patched versions do not work with kernels
*before* 2.6.36.

At first glance, this looks like a visible regression.
Is there a version of input-utils that works with both
old and new kernels ?

Thanks
