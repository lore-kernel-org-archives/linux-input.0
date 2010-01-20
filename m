From: Onkalo Samu <samu.p.onkalo@nokia.com>
Subject: [RFC] Generic implementation for Input enable disable methods
Date: Wed, 20 Jan 2010 08:28:40 +0200
Message-ID: <1263968920.18053.24.camel@4fid08082>
Reply-To: samu.p.onkalo@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:47447 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755889Ab0ATG3U (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Jan 2010 01:29:20 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: ext Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>


Hi

Some time ago, there were two parallel implementation proposals for
disabling input devices. See following email:
http://www.spinics.net/lists/linux-input/msg05984.html

It was asked to combine these two to have generic interface.
I'm proposing following sysfs interface:

../input0/disable/avail_xx
../input0/disable/disable_xx

So, new directory for disable control entries. Own entries for each
of the events or event group. Implementation is using bitmap format:

Examples

See what event groups can be disabled. Disable and enable all the groups
# cat avail_ev
0-1,4,20
# echo "0-1,4,20" > disable_ev
# cat disable_ev
0-1,4,20
# echo -e "\0" > disable_ev
# cat disable_ev
 
See what individual events can be disabled. Disable and enable one of
them:
# cat avail_key
528
# echo "528" > disable_key
# cat disable_key
528
# echo -e "\0" -> disable_key
# cat disable_key

Input core just provides sysfs entries and call call-back functions. 
Actual work is done in the drivers like gpio-keys.

Does this interface sound acceptable solution?
If it is, I'll finalize my implentation and send it for review.
This interface is tested to work with twl4030_keypad driver and
gpio-keys. It should also work fine with touch screen input drivers.

This is more or less small embedded device feature. Should it be behind
configuration flags similar to CONFIG_PM? Of course this would introduce
some compilation flags to the input-core.

Regard,
Samu



