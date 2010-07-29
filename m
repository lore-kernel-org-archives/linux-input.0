From: lirc@bartelmus.de (Christoph Bartelmus)
Subject: Re: [PATCH 5/9] IR: extend interfaces to support more device settings
Date: 29 Jul 2010 09:25:00 +0200
Message-ID: <BTlMvkhXqgB@lirc>
References: <1280360452-8852-6-git-send-email-maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:55383 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083Ab0G2H0l (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Jul 2010 03:26:41 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: maximlevitsky@gmail.com
Cc: linux-input@vger.kernel.org, linux-media@vger.kernel.org, lirc-list@lists.sourceforge.net, mchehab@redhat.com

Hi!

Maxim Levitsky "maximlevitsky@gmail.com" wrote:

> Also reuse LIRC_SET_MEASURE_CARRIER_MODE as LIRC_SET_LEARN_MODE
> (LIRC_SET_LEARN_MODE will start carrier reports if possible, and
> tune receiver to wide band mode)

I don't like the rename of the ioctl. The ioctl should enable carrier
reports. Anything else is hardware specific. Learn mode gives a somewhat
wrong association to me. irrecord always has been using "learn mode"
without ever using this ioctl.

Christoph
