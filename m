From: Michael Bauer <michael@m-bauer.org>
Subject: Re: [PATCH] Fix autocentering command in hid-lgff driver
Date: Wed, 29 Jun 2011 17:23:46 +0200
Message-ID: <4E0B4382.5060304@m-bauer.org>
References: <2502891.N5kVV5at6b@qosmio-x300> <201106262207.23918.michael@m-bauer.org> <86e0976ce588159c5b8edf14f914bf0c.squirrel@host171.canaca.com> <4765696.45GeP0TYaU@qosmio-x300> <4E0AF022.8020609@m-bauer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay03.ispgateway.de ([80.67.29.7]:39726 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755356Ab1F2PaQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jun 2011 11:30:16 -0400
In-Reply-To: <4E0AF022.8020609@m-bauer.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?Michal_Mal=FD?= <madcatxster@gmail.com>
Cc: simon@mungewell.org, linux-input@vger.kernel.org, peter@slim-one.de

Hi,

another small note:
>>> /sys/bus/hid/drivers/lg4ff/<dev>/native - write 1 to switch to native,
>>> read to get current state
Is there any reason the switch to native mode should not be done 
automatically by the driver? I would prefer to have it working 
out-of-the-box instead of having to wait for userspace interaction. 
(This could be done by some udev rule(s), but then this would need to be 
adopted by all distributions...)

I do not see any point in using the wheel in restricted mode when native 
mode is possible...

Best regards
Michael

> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html

