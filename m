From: wellsk40@gmail.com
Subject: rfc input/touch: LPC32xx: Introduce touch driver for the LPC32xx
Date: Wed, 11 Aug 2010 16:09:01 -0700
Message-ID: <1281568142-12892-1-git-send-email-wellsk40@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:44500 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757404Ab0HKXKj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Aug 2010 19:10:39 -0400
Received: by qyk5 with SMTP id 5so730373qyk.19
        for <linux-input@vger.kernel.org>; Wed, 11 Aug 2010 16:10:38 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

This patch set introduces support for the LPC32xx touchscreen
controller driver. The LPC32xx touchscreen controller supports
automated event detection and conversion for resistive touchscreens.

The patch can be pulled from:
	git://git.lpclinux.com/linux-2.6-lpc ts-lpc32xx

