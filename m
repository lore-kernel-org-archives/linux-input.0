From: Donald Kayser <linux@kayser.net>
Subject: /dev/input/by-path/<link> unreliable with MultiTouch device
Date: Thu, 21 Jun 2012 09:52:32 -0500
Message-ID: <73A57920-C505-48DF-A1F2-393BF18585DC@kayser.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from omr3.networksolutionsemail.com ([205.178.146.53]:33674 "EHLO
	omr3.networksolutionsemail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758341Ab2FUPFb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Jun 2012 11:05:31 -0400
Received: from cm-omr9 (mail.networksolutionsemail.com [205.178.146.50])
	by omr3.networksolutionsemail.com (8.14.4/8.14.4) with ESMTP id q5LEqew6020968
	for <linux-input@vger.kernel.org>; Thu, 21 Jun 2012 10:52:41 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello All,

I am part of development of a product that uses touchscreens  
extensively. We have to maintain touchscreen calibration and X Display  
association across boots. We support up to six screens, 3 internal to  
our product, 3 external to our product. All internal screens have  
touchscreens with cables that don't move, so using the device /dev/ 
input/by-path/<devicelink> I could modify xorg.conf with an  
InputSection and associate the screen and touchscreen, include  
calibration, and every time the user returned, it was already  
calibrated and working correctly. It has worked great until we started  
adding multi-touch devices. The line of multi-touch devices we are  
using is manufactured my MosArt.

I added the defines for the products in my local kernel tree's driver/ 
hid/hid-ids.h and added the quirk for HID_QUIRK_MULTI_INPUT in hid- 
quirks.c. With the kernel 2.6.39.4 and earlier to 2.6.32.n, there is  
confusion with the /dev/input/by-path/<devlink>.  These multi-touch  
devices show up with four entries in /dev/input/<dev>. From looking at  
the output of lsinput, two of the entries have identical information  
with regards to event bits. Only one of these identical entries in / 
dev/input/<dev> actually work; one reports 13 axis, one reports 3  
axis. When the /dev/input/by-path/<devlink> points to the 'working' / 
dev/input/<dev> all is fine. This only happens 50% of the time and  
with three screens it is not likely to get all three right on any boot.

So, is this a good place to ask this question? What other information  
would be beneficial? I purposely left out a bunch of debug info so not  
to get too noisy.

Thanks in advance,
Donald Kayser
linux at kayser dot net
