From: Julian Exner <jexner@techfak.uni-bielefeld.de>
Subject: Re: Input: mouse: Trackpoint middle button not recognized on Thinkpad
 E470
Date: Tue, 25 Apr 2017 22:06:56 +0200
Message-ID: <f516c725-48d8-6f82-5ac7-c6afee303e59@techfak.uni-bielefeld.de>
References: <13710506-2225-9f81-40e3-7463ac829860@techfak.uni-bielefeld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smarthost.TechFak.Uni-Bielefeld.DE ([129.70.137.17]:54120 "EHLO
        smarthost.TechFak.Uni-Bielefeld.DE" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1953826AbdDYUHA (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 25 Apr 2017 16:07:00 -0400
In-Reply-To: <13710506-2225-9f81-40e3-7463ac829860@techfak.uni-bielefeld.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: aduggan@synaptics.com

I checked the Trackpoint specification [1] and apparently 0xFE stands 
for the Trackpoint controller asking to resend the command due to 
invalid input. Resending the extended-button-data command results in 
0xFC which stands for another invalid input. But 0xFE does not only 
stand for a resend request but might also mean that the issued command 
is not implemented in the ROM. [2]

So maybe when the extended-button-data command is not support, we can 
check for certain Trackpoint or ROM ids to deduce if a middle button is 
present. If you think this is the right approach I may craft a patch for 
this.

[1] http://blogs.epfl.ch/icenet/documents/Ykt3Eext.pdf
[2] http://blogs.epfl.ch/icenet/documents/Ykt3Eext.pdf#page=20

