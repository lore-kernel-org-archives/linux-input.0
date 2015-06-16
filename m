From: Martin Herkt <lachs0r@srsfckn.biz>
Subject: Re: [Asus UX303LN] F9 disable/enable Touchpad doesn't produce evdev event Edit
Date: Tue, 16 Jun 2015 06:26:25 +0200
Message-ID: <13554265.q0fZY7p6zo@sakuya>
References: <CAFoCoqUfhkw65U7rwTRyY6SU-0Vr619iO56Zt-PvHUS3k3J2ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from srsfckn.biz ([148.251.137.227]:48498 "EHLO srsfckn.biz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750873AbbFPE01 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Jun 2015 00:26:27 -0400
In-Reply-To: <CAFoCoqUfhkw65U7rwTRyY6SU-0Vr619iO56Zt-PvHUS3k3J2ew@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Grateful Frog <gratefulfrog@gmail.com>

On Monday 15 June 2015 22:46:46 Grateful Frog wrote:
> I am reporting this bug according to the instructions.
> 
> [1.]  One line summary of the problem
> [Asus UX303LN] F9 disable/enable Touchpad doesn't produce evdev event
> 
> [2.] Full description of the problem/report:
> While booted into the newest mainline kernel (4.1.0-40100 -rc8)
> The touchpad disable/enable hotkey (F9) does nothing. This makes it
> very hard to use the machine since the touchpad is constantly
> capturing random "mouse movements", making it impossible to enter text
> in the right place.
> Further, the F1,F2,F5,F6 keys do not work (sleep, airplane mode,
> lower/higher screen brightness).

Seems to be a common problem with ASUS laptops.
http://www.spinics.net/lists/linux-input/msg38965.html
