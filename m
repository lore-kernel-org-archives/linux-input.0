From: Alessio Sangalli <alesan@manoweb.com>
Subject: Re: Equivalent of /dev/input/mice for keyboards
Date: Wed, 14 Jan 2009 23:56:33 -0800
Message-ID: <496EEC31.3080007@manoweb.com>
References: <495EA371.8050304@manoweb.com> <20090111232539.ZZRA012@mailhub.coreip.homeip.net> <496BB2C3.9080307@manoweb.com> <20090112215048.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.177]:52565 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760625AbZAOH4j (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Jan 2009 02:56:39 -0500
In-Reply-To: <20090112215048.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Dmitry Torokhov wrote:

> I would take /dev/input/evdev.c as a base but instead of creating a new
> character device in connect() method I would route all events into a
> single device created upon module load (also see
> drivers/input/mousedev.c). That should be really it.

Hi, I've spent a few hours trying to get it right. I am able to
"connect" the devices correclty but when it's time to open the devices I
get a file "No such device" error. The code is at:

http://pastebin.ca/1308960

and I think the problem is around evall_open (line 129). Probably just a
look of an experienced developer can give me some small indication what
to do to solve the issue.

Thank you
Alessio

