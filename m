From: Przemo Firszt <przemo@firszt.eu>
Subject: EV_PWR events for reporting battery state?
Date: Tue, 16 Feb 2010 22:00:20 +0000
Message-ID: <1266357620.4195.10.camel@pldmachine>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cheetah.host-care.com ([66.7.219.192]:58085 "EHLO
	cheetah.host-care.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933344Ab0BPWA0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Feb 2010 17:00:26 -0500
Received: from [78.16.248.52] (port=45278 helo=[192.168.1.100])
	by cheetah.host-care.com with esmtpsa (SSLv3:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <przemo@firszt.eu>)
	id 1NhVSv-0005qd-HD
	for linux-input@vger.kernel.org; Tue, 16 Feb 2010 17:00:21 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,
I'm developing device driver for a bluetooth device. I need to report
battery state/ac plugged status via input_event function. I've 2 ideas
what event I could use: EV_MSC/MSC_RAW or define something for EV_PWR
i.e.:
PWR_BAT for reporting battery operation, 
PWR_AC for ac connected and 
PWR_STT for battery state.

There are some definitions in HID usage tables in HID specification, but
I cannot see any of them implemented in kernel (or I omitted something).
Are my ideas fine or there is a standard way or reporting battery
condition of a wireless device - a way that I cannot find?
--
Regards
Przemo

