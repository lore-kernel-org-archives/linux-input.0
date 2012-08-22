From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: QUANTA touchscreen controller integrated in HP2310ti no longer
 recognised (regression in 3.5 and later as compared to 3.3)
Date: Wed, 22 Aug 2012 19:04:03 +0200
Message-ID: <20120822170403.GA6323@polaris.bitmath.org>
References: <1700293.Y8yBuPUG33@f17simon>
 <20120821190626.GA1260@polaris.bitmath.org>
 <2303254.RzNp9y400f@f17simon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b12.telenor.se ([62.127.194.21]:44806 "EHLO
	smtprelay-b12.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964795Ab2HVQ7P (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Aug 2012 12:59:15 -0400
Received: from ipb2.telenor.se (ipb2.telenor.se [195.54.127.165])
	by smtprelay-b12.telenor.se (Postfix) with ESMTP id 38F81C880
	for <linux-input@vger.kernel.org>; Wed, 22 Aug 2012 18:59:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <2303254.RzNp9y400f@f17simon>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Farnsworth <simon.farnsworth@onelan.co.uk>
Cc: Henrik Rydberg <rydberg@bitmath.se>, linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Benjamin Tissoires <benjamin.tissoires@enac.fr>, Jiri Kosina <jkosina@suse.cz>

> > What does 'cat /sys/bus/hid/devices/0003:0408:3001.0001/modalias' say?
> 
> It's the same whether or not I revert the patch:
> 
> # cat /sys/bus/hid/devices/0003:0408:3001.0001/modalias
> hid:b0003g0000v00000408p00003001
> 
> If I've understood hid-code.c correctly, this means that 
> hdev->group == HID_GROUP_ANY, implying that neither hid_scan_usage nor 
> hid_scan_report have run.

Correct, and your subsequent patch is spot on.

Thanks,
Henrik
