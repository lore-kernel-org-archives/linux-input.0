From: Henrik Rydberg <rydberg@bitmath.org>
Subject: [ANNOUNCE] mtdev v1.0.8 -- Multitouch Protocol Translation Library
Date: Mon, 02 Aug 2010 02:04:28 +0200
Message-ID: <4C560B8C.2050709@bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from csmtp2.one.com ([91.198.169.22]:40790 "EHLO csmtp2.one.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751695Ab0HBAEc (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 1 Aug 2010 20:04:32 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, "X.Org Devel List" <xorg-devel@lists.freedesktop.org>

mtdev - Multitouch Protocol Translation Library (MIT license)

The mtdev library is a kernel input event stream translator, which greatly
simplifies multitouch device driver testing as well as handling in applications.
The input events are simply routed through mtdev, which transforms them to a
uniform stream of MT slot events. Software finger tracking is performed when
needed, making all devices appear as if they had tracking capabilities. For
further details and the source git tree, see

http://bitmath.org/code/mtdev/

The v1.0.8 release contains a number of packaging fixes, and one header file
change needed for the 2.6.36 release, when MT slots appear in the kernel.

Enjoy,
Henrik Rydberg
