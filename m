From: Mario Scholz <mario@expires-2013.mail.trial-n-error.net>
Subject: Logitech K810 Bluetooth F-Keys configuration tool
Date: Wed, 02 Jan 2013 19:49:31 +0100
Message-ID: <50E4813B.1080708@expires-2013.mail.trial-n-error.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay06.ispgateway.de ([80.67.31.101]:46411 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752404Ab3ABSzZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Jan 2013 13:55:25 -0500
Received: from [88.217.114.70] (helo=archvile.trial-n-error.net)
	by smtprelay06.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <mario@expires-2013.mail.trial-n-error.net>)
	id 1TqTNd-0002tb-10
	for linux-input@vger.kernel.org; Wed, 02 Jan 2013 19:49:33 +0100
Received: from vagary.trial-n-error.net ([10.12.0.22])
	by archvile.trial-n-error.net with esmtp (TNE-Exim 4.72)
	(envelope-from <mario@expires-2013.mail.trial-n-error.net>)
	id 1TqTLl-00020v-RN
	for linux-input@vger.kernel.org; Wed, 02 Jan 2013 19:47:37 +0100
Received: from localhost ([127.0.0.1])
	by vagary.trial-n-error.net with esmtp (Exim 4.80)
	(envelope-from <mario@expires-2013.mail.trial-n-error.net>)
	id 1TqTNb-0002Cf-M5
	for linux-input@vger.kernel.org; Wed, 02 Jan 2013 19:49:31 +0100
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Dear linux-input list,

there is a new configuration tool available for the Logitech K810
Bluetooth keyboard.

The keyboard requires to press the FN key together with the F-keys for
normal F-keys function (default behaviour)

If a F-key is pressed without the FN key, they have a special meaning
(e.g. switch bluetooth target, media buttons, etc.)

There is a windows based software 'SetPoint' which can configure this
behaviour. The F-keys are then usable for regular purposes without FN
key. But since it is not permanent and have to be done on each power-on
I created an initial version of a configuration tool to set this behaviour.

I thought perhaps somebody is in need for it besides me.

Best regards,
 Mario Scholz

http://www.trial-n-error.de/static/articles/k810/k810_conf-v0.1.tar.bz2
http://www.trial-n-error.de/posts/2012/12/31/logitech-k810-keyboard-configurator/

