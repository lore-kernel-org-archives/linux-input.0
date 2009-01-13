From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: input devices handling
Date: Mon, 12 Jan 2009 21:47:25 -0800
Message-ID: <20090112214424.ZZRA012@mailhub.coreip.homeip.net>
References: <496BA5C8.5090506@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.242]:58123 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754676AbZAMFsF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Jan 2009 00:48:05 -0500
Received: by an-out-0708.google.com with SMTP id d40so3638867and.1
        for <linux-input@vger.kernel.org>; Mon, 12 Jan 2009 21:48:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <496BA5C8.5090506@msgid.tls.msk.ru>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: linux-input <linux-input@vger.kernel.org>

On Mon, Jan 12, 2009 at 11:19:20PM +0300, Michael Tokarev wrote:
> [Repost for:
> Message-ID: <48FF9737.5050207@msgid.tls.msk.ru>
> Date:	Thu, 23 Oct 2008 01:12:23 +0400
> To: linux-kernel@vger.kernel.org,
> which is a repost of earlier message with similar
> content/question, both went unanswered]
> 
> Hello.
> 
> Similar question has been asked already by me in the past,
> regarding "conversions" of ACPI button events to "keyboard
> events".  The talk is about how one is supposed to handle
> various "common" "meta-buttons" like Power, Sleep, and so
> on.
> 
> Before, there was /proc/acpi/event and /etc/acpid/* stuff,
> and it was easy (but somewhat clumsy) to act to system power
> down button.  But the "proper way" now is to handle
> /dev/input/event* interface, because such "Power" button can
> be on a keyboard, on a remote control, and so on.  I understand
> the idea, and I like it.
> 
> But now the question.  How one supposed to find all the devices
> which generate such events?  I mean not about scanning the /dev
> directory, which can be done once at startup, but about REscanning
> it to find which NEW keyboards and the like appeared since last
> (re)scan and which were removed.
> 

You can either listen to hotplug events or poll (select)
/proc/bus/input/devices - waiters are woken up every time we
add or remove a new input device or a new input handler.

-- 
Dmitry
