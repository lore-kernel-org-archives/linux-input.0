From: Alessio Sangalli <alesan@manoweb.com>
Subject: Re: Notification when a new device is added or removed
Date: Sat, 28 Feb 2009 18:58:05 -0800
Message-ID: <49A9F9BD.2090604@manoweb.com>
References: <49A8BEF7.9060602@manoweb.com> <20090228183917.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.177]:55340 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234AbZCAC6R (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Feb 2009 21:58:17 -0500
In-Reply-To: <20090228183917.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Dmitry Torokhov wrote:

> You should be able to poll (select) /proc/bus/input/devices.

Yeah that would be great; anyway, I tried and... well nothing happens. I
am obviously missing something here:


#include <poll.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>

int main()
{
        int fd, c;
        struct pollfd pfd;

        fd=open("/proc/bus/input/devices", O_RDONLY);
        if(fd==-1)
                return -1;
        pfd.fd=fd;
        pfd.events=POLLIN;
        while(1) {
                c=poll(&pfd, 1, 20000);
                if(c==-1)
                        printf("Error polling\n");
                else if(c==0)
                        printf("Timeout\n");
                else
                        printf("Something changed");
        }
}



The result, while I detach or attach new devices is:

Timeout
Timeout
Timeout
Timeout
Timeout



bye
Alessio

