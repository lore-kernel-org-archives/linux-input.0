From: "hartleys" <hartleys@visionengravers.com>
Subject: [PATCH 0/5] input: Common macro for keypad drivers
Date: Fri, 30 Jan 2009 13:44:23 -0500
Message-ID: <BD79186B4FD85F4B8E60E381CAEE1909011A5461@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exprod6ob113.obsmtp.com ([64.18.1.30]:50262 "HELO psmtp.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1753030AbZA3SpQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Jan 2009 13:45:16 -0500
Content-class: urn:content-classes:message
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Create a common MATRIX_KEY macro to pack matrix keypad keycodes into a
keymap.

Currently the omap-kaypad and pxa27x_keypad drivers use private
implementations of the same KEY macro to create a keymap for the matrix
array.  This patch set adds a common MATRIX_KEY macro to
include/linux/input.h for these drivers and any future matrix keypad
drivers to use.

H Hartley Sweeten
