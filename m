From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Equivalent of /dev/input/mice for keyboards
Date: Thu, 15 Jan 2009 00:33:27 -0800
Message-ID: <200901150033.27934.dmitry.torokhov@gmail.com>
References: <495EA371.8050304@manoweb.com> <20090112215048.ZZRA012@mailhub.coreip.homeip.net> <496EEC31.3080007@manoweb.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.249]:18152 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755174AbZAOIeJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Jan 2009 03:34:09 -0500
Received: by an-out-0708.google.com with SMTP id d40so435180and.1
        for <linux-input@vger.kernel.org>; Thu, 15 Jan 2009 00:34:07 -0800 (PST)
In-Reply-To: <496EEC31.3080007@manoweb.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alessio Sangalli <alesan@manoweb.com>
Cc: linux-input@vger.kernel.org

On Wednesday 14 January 2009 23:56:33 Alessio Sangalli wrote:
> Dmitry Torokhov wrote:
> > I would take /dev/input/evdev.c as a base but instead of creating a new
> > character device in connect() method I would route all events into a
> > single device created upon module load (also see
> > drivers/input/mousedev.c). That should be really it.
>
> Hi, I've spent a few hours trying to get it right. I am able to
> "connect" the devices correclty but when it's time to open the devices I
> get a file "No such device" error. The code is at:
>
> http://pastebin.ca/1308960
>
> and I think the problem is around evall_open (line 129). Probably just a
> look of an experienced developer can give me some small indication what
> to do to solve the issue.
>

The way character devices are created by input core is tied very much
into existing handlers and is not very easy to plug into. I would
recommend creating a character device manually via misc_register() -
see how it is done in mousedev.c for psaux_mouse.

Also, I'd recommend getting rig of ioctl, write and grab code, they
don't make sense in context of multiplexor device and clutter the
code way too much.

Hope this helps.

-- 
Dmitry
