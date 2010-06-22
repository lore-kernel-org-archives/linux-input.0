From: Henrik Rydberg <rydberg@bitmath.org>
Subject: [ANNOUNCE] mtdev 1.0.1 released
Date: Tue, 22 Jun 2010 13:46:37 +0200
Message-ID: <4C20A29D.90503@bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from csmtp2.one.com ([91.198.169.22]:40464 "EHLO csmtp2.one.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754562Ab0FVLqj (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Jun 2010 07:46:39 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, "X.Org Devel List" <xorg-devel@lists.freedesktop.org>

Announcement: mtdev v1.0.1 released
-----------------------------------

mtdev - Multitouch Protocol Translation Library (MIT license)

The mtdev library is a kernel input event stream translator, which
greatly simplifies multitouch handling in applications. The input
events are simply routed through mtdev, which transforms them to a
uniform stream of MT slot events. Software finger tracking is
performed when needed, making all devices appear as if they had
tracking capabilities. For further details and the source git tree,
see

http://bitmath.org/code/mtdev/

The bulk of mtdev has been around since 2008, as part of the
Multitouch X Driver project (http://bitmath.org/code/multitouch/). By
releasing mtdev as a stand-alone package under the free MIT (X11)
license, we hope to simplify the adoption of the MT event protocol in
applications.

Enjoy,
Henrik Rydberg
