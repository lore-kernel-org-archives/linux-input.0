From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: question on releasing keys
Date: Wed, 28 Apr 2010 09:42:24 -0700
Message-ID: <201004280942.25746.dmitry.torokhov@gmail.com>
References: <201004281053.52598.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:52501 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755821Ab0D1Qmf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Apr 2010 12:42:35 -0400
Received: by wye20 with SMTP id 20so918255wye.19
        for <linux-input@vger.kernel.org>; Wed, 28 Apr 2010 09:42:34 -0700 (PDT)
In-Reply-To: <201004281053.52598.oneukum@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: linux-input@vger.kernel.org

Hi Oliver,

On Wednesday 28 April 2010 01:53:52 am Oliver Neukum wrote:
> Hi,
> 
> I am seeing a generic problem with buttons on devices released during S3.
> The input layer then assumes that the button is still pressed. It would be
> best for drivers to either verify that a button is still held or
> alternatively, to release all buttons upon resumption. Is there a generic
> way to do that?
>

I think input core should force release of all keys when device is
being suspended, I guess we need to change input.c::input_dev_reset().

-- 
Dmitry
