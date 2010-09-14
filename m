From: Chuck Ebbert <cebbert@redhat.com>
Subject: Wacom Bamboo Pen & Touch almost works now
Date: Tue, 14 Sep 2010 17:17:47 -0400
Message-ID: <20100914171747.1e2f64d1@katamari>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54913 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751711Ab0INVT5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Sep 2010 17:19:57 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>, Chris Bagwell <chris@cnpbagwell.com>

After I apply the nine patches for Bamboo support from the input git
repo, only the pen works on the pen & touch. The light goes brighter
when I touch the pad or press the buttons, but nothing else happens.
Oh, and if I touch the pad while the display is in DPMS mode, the
backlight comes on but that's all.
