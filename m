From: Michael Gebetsroither <michael@mgeb.org>
Subject: Add support for elo intellitouch 2700 touchscreen to usbtouchscreen.c
Date: Thu,  3 Nov 2011 11:15:17 +0100
Message-ID: <1320315318-15998-1-git-send-email-michael@mgeb.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.mgeb.org ([178.63.91.126]:58088 "EHLO mail.mgeb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752670Ab1KCKZX (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 3 Nov 2011 06:25:23 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi all,

I've added support for the elo intellitouch 2700 touchscreen
to the usbtouchscreen driver.

The driver is used since a few months in production without
any problems reported. Hope i did get things right as this is
my first patch sent to linux kernel directly.
All information needed for this patch where take from the serial
implementation for elo touchscreens (elo.c).

Kind Regards,
Michael Gebetsroither

