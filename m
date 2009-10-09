From: Onkalo Samu <samu.p.onkalo@nokia.com>
Subject: Poll rate change and closing indication to polled input device
Date: Fri, 09 Oct 2009 15:02:59 +0300
Message-ID: <1255089779.28243.24.camel@4fid08082>
Reply-To: samu.p.onkalo@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:64039 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbZJIMEb (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Oct 2009 08:04:31 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n99C31RN017348
	for <linux-input@vger.kernel.org>; Fri, 9 Oct 2009 15:03:02 +0300
Received: from [172.22.144.188] (4fid08082.ntc.nokia.com [172.22.144.188])
	by mgw-sa02.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n99C2xG7028799
	for <linux-input@vger.kernel.org>; Fri, 9 Oct 2009 15:02:59 +0300
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi

I would like to change the polling rate of the polled input device
on the fly depending on the use case. One possible way is to directly
modify poll_interval from my driver. However, I would like to introduce
functions which can be used to set / get polling rate like 

input_polled_device_set_rate(...)

input_polled_device_get_rate(...)

Another missing thing is an indication when the polled device is closed.
This can be used to turn off the HW which is not used anymore.

What do you think, is it ok to introduce these additions to the polled
input device?

-Samu Onkalo


