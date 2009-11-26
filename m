From: lirc@bartelmus.de (Christoph Bartelmus)
Subject: Re: [RFC] Should we create a raw input interface for IR's ? - Was: Re: [PATCH 1/3 v2] lirc core device driver infrastructure
Date: 26 Nov 2009 23:05:00 +0100
Message-ID: <BDccCqq3jFB@christoph>
References: <4B0EEC21.9010001@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:56301 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752933AbZKZWGL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Nov 2009 17:06:11 -0500
In-Reply-To: <4B0EEC21.9010001@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: mchehab@redhat.com
Cc: dmitry.torokhov@gmail.com, j@jannau.net, jarod@redhat.com, khc@pm.waw.pl, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, superm1@ubuntu.com

Hi Mauro,

on 26 Nov 09 at 18:59, Mauro Carvalho Chehab wrote:
> Christoph Bartelmus wrote:
[...]
>>> lircd supports input layer interface. Yet, patch 3/3 exports both devices
>>> that support only pulse/space raw mode and devices that generate scan
>>> codes via the raw mode interface. It does it by generating artificial
>>> pulse codes.
>>
>> Nonsense! There's no generation of artificial pulse codes in the drivers.
>> The LIRC interface includes ways to pass decoded IR codes of arbitrary
>> length to userspace.

> I might have got wrong then a comment in the middle of the
> imon_incoming_packet() of the SoundGraph iMON IR patch:

Indeed, you got it wrong.
As I already explained before, this device samples the signal at a  
constant rate and delivers the current level in a bit-array. This data is  
then condensed to pulse/space data.

Christoph
