From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [RFC, PATCH] horizontal mouse wheel in mousedrv
Date: Thu, 3 Jan 2008 13:27:38 -0500
Message-ID: <d120d5000801031027i3c2dade5p16a62ec34d84d465@mail.gmail.com>
References: <20071225164921.16bccae3@poseidon.drzeus.cx>
	 <d120d5000801030825s5d87c2eflc712979e587d4d6a@mail.gmail.com>
	 <20080103182710.26f69d40@poseidon.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:12883 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752024AbYACS1k (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Jan 2008 13:27:40 -0500
Received: by nf-out-0910.google.com with SMTP id g13so421817nfb.21
        for <linux-input@vger.kernel.org>; Thu, 03 Jan 2008 10:27:39 -0800 (PST)
In-Reply-To: <20080103182710.26f69d40@poseidon.drzeus.cx>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: linux-input@vger.kernel.org

On Jan 3, 2008 12:27 PM, Pierre Ossman <drzeus-list@drzeus.cx> wrote:
> On Thu, 3 Jan 2008 11:25:21 -0500
> "Dmitry Torokhov" <dmitry.torokhov@gmail.com> wrote:
>
> >
> > I'd rather not change the legacy mousedev driver. The extension is
> > rather non-standard and there is no telling what applications might
> > break. Please use evdev driver, it should support horizontal scrolling
> > AFAIK.
> >
>
> It does, but it doesn't support hot-plug. Not something the kernel can be blamed for, but for my use case it was easier to do this modification to the kernel rather than to teach Xorg hot-plug.
>

As far as I remember the hotplug for X is being actively developed at
the moment.

-- 
Dmitry
