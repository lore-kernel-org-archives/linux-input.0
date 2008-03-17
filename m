From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: [patch 0/7] updates for xpad
Date: Mon, 17 Mar 2008 21:22:50 +0200
Message-ID: <20080317192250.208635026@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from pne-smtpout4-sn1.fre.skanova.net ([81.228.11.168]:53853 "EHLO
	pne-smtpout4-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753043AbYCQT2q (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Mar 2008 15:28:46 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

What follows is a few patches for xpad fixing some issues, adding new
ids, and Brian's xbox360 wireless patch adapted for current xpad.c.

They are against current mm, i.e. 'match xbox 360 devices with
interface info' should be applied first.

--
Anssi Hannula
