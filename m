From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] Infrared Keycode standardization
Date: Thu, 27 Aug 2009 13:17:52 -0700
Message-ID: <20090827205005.8F7AD526EC9@mailhub.coreip.homeip.net>
References: <20090827045710.2d8a7010@pedra.chehab.org> <4A96BD05.1080205@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f178.google.com ([209.85.222.178]:35687 "EHLO
	mail-pz0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752157AbZH0URz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Aug 2009 16:17:55 -0400
Content-Disposition: inline
In-Reply-To: <4A96BD05.1080205@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Brouwer <pb.maillists@googlemail.com>
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>

On Thu, Aug 27, 2009 at 06:06:13PM +0100, Peter Brouwer wrote:
> Mauro Carvalho Chehab wrote:
>
> Hi Mauro, All
>
> Would it be an alternative to let lirc do the mapping and just let the 
> driver pass the codes of the remote to the event port.

I don't think that blindly passing IR codes through input layer is a
good idea, for the same reason we don't do that for HID and PS/2
anymore - task of the kernel is to provide unified interface to the
hardware devices instead of letting userspace deal with the raw data
streams.

-- 
Dmitry
