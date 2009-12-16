From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH 0/3] wacom: update to match upstream
Date: Wed, 16 Dec 2009 17:58:19 -0500
Message-ID: <1261004302-4858-1-git-send-email-mjg@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:49474 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932436AbZLPW7I (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Dec 2009 17:59:08 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: pingc@wacom.com

The upstream linuxwacom driver (http://linuxwacom.sourceforge.net) has
various updates that aren't present in the kernel. I've ported them to the
current state of things and tried to clean them up a little, but some of
the conditionals make >80 column lines pretty inevitable and I don't want
to do any real refactoring.

