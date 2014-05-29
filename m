From: Floris <jkfloris@dds.nl>
Subject: joydev devices are world readable
Date: Thu, 29 May 2014 10:11:27 +0200
Message-ID: <op.xgl3pdtz5k9y7g@alice.jkfloris.demon.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-vbr4.xs4all.nl ([194.109.24.24]:2448 "EHLO
	smtp-vbr4.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754878AbaE2IJn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 May 2014 04:09:43 -0400
Received: from alice.jkfloris.demon.nl (jkfloris.demon.nl [82.95.130.205])
	(authenticated bits=0)
	by smtp-vbr4.xs4all.nl (8.13.8/8.13.8) with ESMTP id s4T89eHB010037
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-input@vger.kernel.org>; Thu, 29 May 2014 10:09:41 +0200 (CEST)
	(envelope-from jkfloris@dds.nl)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hey,

after asking the systemd mailing list [1] I will try this list. Maybe  
someone can help me to solve this issue or point me to someone/ some list.

The short version of the problem:

I have created a multiseat setup with systemd. And used "loginctl attach"  
to attach devices to an other seat. The input from the mouse and keyboard  
are working as expected. They both only work on the seat they are attached  
to. Nevertheless, the joysticks ignore the seat rules and works on every  
seat. So a user from seat0 can interact with seat1. Maybe this is not  
directly a security problem as it is annoying.

Please read the systemd-devel mailing list [1] for more information or ask  
me if you need more information about my system or the problem.

tia,

floris

[1]  
http://lists.freedesktop.org/archives/systemd-devel/2014-May/019551.html
