From: Jay Philips <philipz85@hotmail.com>
Subject: LG laptop keyboards stop working after Linux 3.9
Date: Sat, 21 Feb 2015 00:27:21 +0400
Message-ID: <BLU437-SMTP55984DCFF97CD1F89EBF30BC2A0@phx.gbl>
References: <BLU436-SMTP919F920C610E2E5EBB935FBC2A0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from blu004-omc4s2.hotmail.com ([65.55.111.141]:58469 "EHLO
	BLU004-OMC4S2.hotmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754911AbbBTUc2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Feb 2015 15:32:28 -0500
In-Reply-To: <BLU436-SMTP919F920C610E2E5EBB935FBC2A0@phx.gbl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello,

I was asked by Greg Kroah-Hartman to send this email to the mailing list 
regarding keyboards on LG laptops no longer functioning after Linux 3.9. 
Below is the text from the bug report i left at (
https://bugzilla.kernel.org/show_bug.cgi?id=93541 ).

----------------------------------

Starting with Linux 3.9, the keyboard in my LG laptop (LG R1 model LGW4) 
stopped functioning in all linux distributions i've tried.

I had spoken to a few guys in the kernel irc channel and they told me 
that i should point out the keyboard is found in the attached dmesg log 
file on line:

[    5.516045] input: AT Translated Set 2 keyboard as 
/devices/platform/i8042/serio0/input/input4

I had submitted the bug to ubuntu's launchpad bug service and they told
me that i should take the bug upstream ( 
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1287325 ) and 
mentioned the following (comment 26).

"It appears the keyboard is not recognized in 13.04, but it is in 13.10. 
... It may be the bug is caused by the fact that the keyboard now being 
recognized in 13.10 and another code path is being used."

Other LG laptop users have also encountered the same problems ( 
http://askubuntu.com/questions/361692/laptop-keyboard-not-responding-after-upgrade-from-13-04-to-13-10, 
http://stevesubuntutweaks.blogspot.no/2013/10/laptop-keyboard-stopped-working-after.html 
) and the solution that i currently use is to set "i8042.dumbkbd=1" in 
the grub commandline to get it running.

----------------------------------

Kind Regards,
Yousuf Philips

