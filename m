From: <samu.p.onkalo@nokia.com>
Subject: RE: [PATCH 1/1] Polled input device: Add closing indication
Date: Mon, 12 Oct 2009 11:23:57 +0200
Message-ID: <62697B07E9803846BC582181BD6FB6B812F6933BBA@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1255334981-24118-1-git-send-email-samu.p.onkalo@nokia.com>
 <1255334981-24118-2-git-send-email-samu.p.onkalo@nokia.com>
 <200910120154.42432.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:41141 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755009AbZJLJZm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Oct 2009 05:25:42 -0400
In-Reply-To: <200910120154.42432.dmitry.torokhov@gmail.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

>
>Hi Samu,
>
>On Monday 12 October 2009 01:09:41 am Samu Onkalo wrote:
>> When closing polled input device, call optional closing 
>method to make 
>> it possible to turn off the HW.
>
>What about open? How do you re-enable the device if it was 
>closed and then reopened?
>

flush is called when the device is reopened. Is it ok to use that?

-Samu
