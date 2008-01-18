From: Jiri Kosina <jikos@jikos.cz>
Subject: Re: Problem with Genius Ergomedia 700
Date: Fri, 18 Jan 2008 12:09:41 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0801181208380.15647@twin.jikos.cz>
References: <4790713A.9@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from twin.jikos.cz ([213.151.79.26]:51744 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755126AbYARLJq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Jan 2008 06:09:46 -0500
In-Reply-To: <4790713A.9@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alex Torkhov <atorkhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Fri, 18 Jan 2008, Alex Torkhov wrote:

> I have Genius Ergomedia 700 USB keyboard but not all "multimedia" keys 
> are working. In manual it's written that "My document/My picture/My 
> music/Scrolling buttons/Left and right scrolling functions/Zoom in/Zoom 
> out/Messenger/Messenger status/Webcam/Audio 1-3/Word/Excel/Powerpoint do 
> not function unless driver has been installed". And exactly those keys 
> do not working while other multimedia keys are working fine.
> What can be done to enable those additional multimedia keys?

Hi Alex,

please compile your kernel with CONFIG_HID_DEBUG, modprobe the hid module 
with 'debug=1' parameter, and send me the dmesg output that appears when 
you connect the keyboard, and also when you press the individual buttons. 
Please annotate the output (i.e. "this happened when I pressed the XYZ 
key").

Thanks,

-- 
Jiri Kosina
