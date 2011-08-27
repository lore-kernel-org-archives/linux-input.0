From: Stefan Achatz <erazor_de@users.sourceforge.net>
Subject: [PATCH 0/5] HID: roccat: Small fixes, cleanups and unifications
Date: Sat, 27 Aug 2011 15:24:28 +0200
Message-ID: <1314451469.24216.66.camel@neuromancer.tessier-ashpool>
Reply-To: erazor_de@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:53434 "EHLO
	mail-in-10.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751394Ab1H0NYf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 27 Aug 2011 09:24:35 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Main content of this patchset is the unification of profile change
reporting behaviour between roccat drivers.
Beside that some code was cleaned up a bit and two cases are fixed where
the drivers returned wrong values on certain occassions.

