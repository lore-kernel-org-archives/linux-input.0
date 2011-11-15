From: Nuno Santos <nsantos@edigma.com>
Subject: Re: Interacting with a input kernel driver from user space
Date: Tue, 15 Nov 2011 10:40:11 +0000
Message-ID: <4EC2418B.9010706@edigma.com>
References: <4EC10878.20109@edigma.com> <CANq1E4SZnv0yNbmKqV-my3wanKGe4R4UW6_=z-awO6ci14xyRA@mail.gmail.com> <4EC13B0F.2080509@edigma.com> <CANq1E4SMr1HWXSV3Fc6mB8oCWEJv63i_QZFQLMYCBqCdYsDZxA@mail.gmail.com> <4EC1427D.2090703@edigma.com> <20111114171300.GB12659@core.coreip.homeip.net> <20111115103225.GA8074@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx01.edigma.com ([195.22.21.235]:56756 "EHLO mx01.edigma.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754927Ab1KOKkR (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Nov 2011 05:40:17 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mx01.edigma.com (Postfix) with ESMTP id 3D0913761911
	for <linux-input@vger.kernel.org>; Tue, 15 Nov 2011 10:40:15 +0000 (WET)
Received: from mx01.edigma.com ([127.0.0.1])
	by localhost (mx01.edigma.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KUqtmLBkFwI0 for <linux-input@vger.kernel.org>;
	Tue, 15 Nov 2011 10:40:15 +0000 (WET)
Received: from [192.168.3.103] (unknown [62.28.174.82])
	by mx01.edigma.com (Postfix) with ESMTPSA id B9EEF3761903
	for <linux-input@vger.kernel.org>; Tue, 15 Nov 2011 10:40:14 +0000 (WET)
In-Reply-To: <20111115103225.GA8074@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: linux-input@vger.kernel.org

But my device isn't an HID device. My device is a vendor specific device:

bNumEndpoints           2
       bInterfaceClass       255 Vendor Specific Class
       bInterfaceSubClass    255 Vendor Specific Subclass
       bInterfaceProtocol    255 Vendor Specific Protocol
       iInterface              0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x86  EP 6 IN
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0200  1x 512 bytes
         bInterval               0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x02  EP 2 OUT
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0200  1x 512 bytes
         bInterval               0


I need bulk transfers for data in and out.

--

Right. Unless we are talking about haptic feedback or leds, information 
really flows one way, so there should be no reason to send anything back 
to the kernel. For detected but anonymous touches, we have MT protocol A 
in the input subsystem. If your raw data does not even contain detected 
touches, I would try hidraw, as Dmitry suggested. Thanks, Henrik


