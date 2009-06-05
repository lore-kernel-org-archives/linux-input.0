From: Marcel Holtmann <marcel@holtmann.org>
Subject: Global /dev/input/events device
Date: Fri, 05 Jun 2009 15:54:39 +0200
Message-ID: <1244210079.23850.32.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:53674 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752052AbZFENzH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 5 Jun 2009 09:55:07 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

Hi Dmitry,

so I am working on creating a replacement for the kernel RFKILL input
support with a proper daemon in userspace that allows us to implement
proper policy support for RFKILL soft switch event buttons.

What I am missing is a /dev/input/events device (similar to the mice
device) that combines all events into one to make it easier for
application if they really don't care which actual physical or virtual
device created that event. Is it possible that we create something like
this?

Regards

Marcel


