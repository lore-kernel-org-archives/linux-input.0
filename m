From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: Input: psmouse - switch to using dev_*() for messages
Date: Thu, 12 Jun 2014 17:29:12 +0300
Message-ID: <20140612142912.GA13103@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:29321 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755910AbaFLO3Y (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Jun 2014 10:29:24 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

Hello Dmitry Torokhov,

This is a semi-automatic email about new static checker warnings.

The patch b5d21704361e: "Input: psmouse - switch to using dev_*() for
messages" from Oct 10, 2011, leads to the following Smatch complaint:

drivers/input/mouse/psmouse-base.c:1512 psmouse_reconnect()
	 error: we previously assumed 'psmouse' could be null (see line 1511)

drivers/input/mouse/psmouse-base.c
  1510	
  1511		if (!drv || !psmouse) {
                             ^^^^^^^
Old check.

  1512			psmouse_dbg(psmouse,
                                    ^^^^^^^
New dereference.

  1513				    "reconnect request, but serio is disconnected, ignoring...\n");
  1514			return -1;

regards,
dan carpenter
