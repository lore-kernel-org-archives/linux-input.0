From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [PATCH 1/6] Haptic: add haptic class
Date: Tue, 13 Oct 2009 16:43:43 +0530
Message-ID: <5d5443650910130413t6ecd3d54p214d8f80972ed128@mail.gmail.com>
References: <20091007061701.GA7567@july>
	 <359ed6810910130335m45919d6ala921d4cbfa5a341a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f186.google.com ([209.85.221.186]:54958 "EHLO
	mail-qy0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277AbZJMLOV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Oct 2009 07:14:21 -0400
In-Reply-To: <359ed6810910130335m45919d6ala921d4cbfa5a341a@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jani Nikula <ext-jani.1.nikula@nokia.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi Kyungmin, Dmitry,

On Tue, Oct 13, 2009 at 4:05 PM, Jani Nikula
<ext-jani.1.nikula@nokia.com> wrote:
> On Wed, Oct 7, 2009 at 09:17, Kyungmin Park <kyungmin.park@samsung.com> wrote:
>> New haptic class support.
>> This class handles the haptic devices.
>
> I'm wondering why a haptic class is needed when there is force
> feedback support. Admittedly, I don't know the force feedback
> implementation too well, but could someone please enlighten me on
> this? Am I missing something here?
>
> I see haptics as simple force feedback, just with (usually) small
> force and short duration. There are devices out there doing haptics
> using vibra motors, which I think would be limited if implemented
> using this haptics class driver. Would it be somehow problematic
> interfacing with the simple haptic hardware using the force feedback
> API?

Please share your inputs on ff_device usage instead of haptics class.
I think Dmitry could add some points here as I don't see much users of
ff_device and I don't see any embedded device (like mobile) using it.

-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
