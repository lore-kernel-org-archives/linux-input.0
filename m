From: lirc@bartelmus.de (Christoph Bartelmus)
Subject: Re: [RFC] Should we create a raw input interface for IR's ? - Was: Re: [PATCH 1/3 v2] lirc core device driver infrastructure
Date: 26 Nov 2009 21:37:00 +0100
Message-ID: <BDcc3mfojFB@christoph>
References: <4B0E765C.2080806@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752796AbZKZUoU@vger.kernel.org>
In-Reply-To: <4B0E765C.2080806@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mchehab@redhat.com
Cc: dmitry.torokhov@gmail.com, j@jannau.net, jarod@redhat.com, khc@pm.waw.pl, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, superm1@ubuntu.com
List-Id: linux-input@vger.kernel.org

Hi Mauro,

on 26 Nov 09 at 10:36, Mauro Carvalho Chehab wrote:
[...]
> lircd supports input layer interface. Yet, patch 3/3 exports both devices
> that support only pulse/space raw mode and devices that generate scan
> codes via the raw mode interface. It does it by generating artificial
> pulse codes.

Nonsense! There's no generation of artificial pulse codes in the drivers.
The LIRC interface includes ways to pass decoded IR codes of arbitrary  
length to userspace.

Christoph
