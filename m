From: Oliver Neukum <oliver@neukum.org>
Subject: question on device registration
Date: Wed, 2 Jul 2008 22:08:56 +0200
Message-ID: <200807022208.57032.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:53317 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752801AbYGBUI1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Jul 2008 16:08:27 -0400
Received: from linux (p549A2E66.dip0.t-ipconnect.de [84.154.46.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: neukum_org@smtp-out.kontent.com)
	by smtp-out.kontent.com (Postfix) with ESMTP id DD5F44000B45
	for <linux-input@vger.kernel.org>; Wed,  2 Jul 2008 22:08:25 +0200 (CEST)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

what happens if you call input_report_key(), input_report_rel() or input_sync()
for a device before you call input_register_device() ?

	Regards
		Oliver
