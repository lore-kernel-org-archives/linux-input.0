From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Asus T91MT, anyone?
Date: Wed, 6 Jan 2010 11:41:35 +0100
Message-ID: <316738D8-212B-4F7B-B1F3-81C26CF367E4@enac.fr>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:48629 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755630Ab0AFKlo (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Jan 2010 05:41:44 -0500
Received: from [10.0.0.100] (unknown [10.0.0.254])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: chatty@smtp.lii-enac.fr)
	by smtp.lii-enac.fr (DoorWays) with ESMTPSA id 6CC7A94FBB
	for <linux-input@vger.kernel.org>; Wed,  6 Jan 2010 11:41:36 +0100 (CET)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Happy new year!

Responding to requests on a French Ubuntu forum I have built an  
experimental driver for the multitouch panel of the Asus T91MT, using  
the principles from the N-Trig, 3M and Stantum drivers.

I don't have a T91MT myself and I need to rely on the output of  
evtest that people send me. Unfortunately the readers of the French  
forum seem to have difficulties dealing with kernel drivers, and I've  
had no feedback from them yet. Would anyone be interested in  
compiling the driver and telling me what happens? I still need a  
couple of iterations because every device has its own understanding  
of what the booleans InRange, Confidence and TipSwitch mean.

If you're interested, the driver is at http://lii-enac.fr/en/projects/ 
shareit/hid-asus.c and there's a howto at http://lii-enac.fr/en/ 
projects/shareit/linux-howto.c

St.

