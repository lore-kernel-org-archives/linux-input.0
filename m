From: Oliver Neukum <oneukum@suse.de>
Subject: quirk ALWAYS_POLL needed with an unexpectedly high number of mice
Date: Fri, 27 Mar 2015 10:29:31 +0100
Message-ID: <1427448571.5783.41.camel@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:39915 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753404AbbC0JaH (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Mar 2015 05:30:07 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Johan Hovold <johan@kernel.org>, jkosina@suse.cz
Cc: linux-input@vger.kernel.org, jdelvare@suse.com

Hi,

I am getting reports from a customer running an unintentional
stress test for this quirk. I would have to add a dozen mice
in the medium term. Is that desirable?
Should we make the quirk the default? Or add a module parameter
to let the pessimistic users with multiple desktop rodents
select the quirk as default? Or just carry on?
Comments?

	Regards
		Oliver


