From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: [RFC, PATCH] horizontal mouse wheel in mousedrv
Date: Thu, 3 Jan 2008 18:27:10 +0100
Message-ID: <20080103182710.26f69d40@poseidon.drzeus.cx>
References: <20071225164921.16bccae3@poseidon.drzeus.cx>
	<d120d5000801030825s5d87c2eflc712979e587d4d6a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gateway.drzeus.cx ([85.8.24.16]:55041 "EHLO smtp.drzeus.cx"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754334AbYACR1O (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 3 Jan 2008 12:27:14 -0500
In-Reply-To: <d120d5000801030825s5d87c2eflc712979e587d4d6a@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Thu, 3 Jan 2008 11:25:21 -0500
"Dmitry Torokhov" <dmitry.torokhov@gmail.com> wrote:

> 
> I'd rather not change the legacy mousedev driver. The extension is
> rather non-standard and there is no telling what applications might
> break. Please use evdev driver, it should support horizontal scrolling
> AFAIK.
> 

It does, but it doesn't support hot-plug. Not something the kernel can be blamed for, but for my use case it was easier to do this modification to the kernel rather than to teach Xorg hot-plug.

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
