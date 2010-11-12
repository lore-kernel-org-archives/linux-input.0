From: Stefan Achatz <stefan_achatz@web.de>
Subject: [PATCH 0/2] sysfs: Introducing group functions for binary sysfs
 attributes
Date: Fri, 12 Nov 2010 19:18:35 +0100
Message-ID: <1289585915.2629.11.camel@neuromancer>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fmmailgate01.web.de ([217.72.192.221]:56613 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829Ab0KLSVD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Nov 2010 13:21:03 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@suse.de>, "Eric W. Biederman" <ebiederm@aristanetworks.com>, Tejun Heo <tj@kernel.org>, "Serge E. Hallyn" <serue@us.ibm.com>, Benjamin Thery <benjamin.ther>

Dmitry Torokhov asked me to implement group functions for sysfs binary
attributes.
This patchset includes my first proposal and changes on my kone mouse
hid driver that uses part of the new functions.

