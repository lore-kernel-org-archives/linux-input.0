From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Game Controllers
Date: Thu, 2 May 2013 09:55:57 -0700
Message-ID: <20130502165556.GB28625@core.coreip.homeip.net>
References: <CAFmpkyiqcwhbJc2A+Ntyisc_CD2z9ssBUQDv6TKvQCX4ES8DOQ@mail.gmail.com>
 <2483279.JlnWrOX8Uv@dtor-d630.eng.vmware.com>
 <CAFmpkyiS+L6OsGmobjHqqJ8AFNNiDk4DYYFo_1GQx2kV_dam1Q@mail.gmail.com>
 <20130502083547.279d08a3cbd7a115489de4b7@studenti.unina.it>
 <CAFmpkygZ+xvpwp9KQr6O4emk2f1Bn0EBS0WeN1ji0qVUJz2rwA@mail.gmail.com>
 <CANq1E4QstEwpxEReYOsmJhPMED+eWv3SBSEMzYMNVq5Ywme38g@mail.gmail.com>
 <CAFmpkyhtrby3OR7zFq3af6SKEBu24AD47bF2y9gdqMWnwgbG9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:60191 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760964Ab3EBQ4B (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 2 May 2013 12:56:01 -0400
Received: by mail-pd0-f179.google.com with SMTP id q10so453366pdj.24
        for <linux-input@vger.kernel.org>; Thu, 02 May 2013 09:56:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAFmpkyhtrby3OR7zFq3af6SKEBu24AD47bF2y9gdqMWnwgbG9Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Todd Showalter <todd@electronjump.com>
Cc: David Herrmann <dh.herrmann@gmail.com>, Antonio Ospite <ospite@studenti.unina.it>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

On Thu, May 02, 2013 at 11:37:48AM -0400, Todd Showalter wrote:
>     Ok, here's a question: could gamepad-like devices have two dev
> entries?  One that exported the full raw device, and one that
> responded to EVIOCGNAME with "Standard Gamepad"?  That way, the raw
> device in all its glory would be available for anything that wanted to
> understand the device, and games that just wanted bog standard console
> gamepad controls could have it without having to jump through hoops.

No, not in the kernel please. Create a library that implements the
"standard gamepad", like we have tslib for "standard touchscreen" and
have it do the transformations.

Kernel can try doing proper mapping but userspace should examine device
and try to make most out of what it offers even if it is not exactly PS3
controller.

Thanks.

-- 
Dmitry
