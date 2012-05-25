From: Mark Lord <kernel@teksavvy.com>
Subject: Re: [git pull] Input updates for 3.5-rc0
Date: Fri, 25 May 2012 15:05:00 -0400
Message-ID: <4FBFD7DC.9070604@teksavvy.com>
References: <20120524083216.GD10562@core.coreip.homeip.net> <CA+55aFxw0HRpizzJZxhhA2oqPpzg4DPUvH2r7YoYfctXS6K=WQ@mail.gmail.com> <20120524180154.GA15036@core.coreip.homeip.net> <CA+55aFx0ww=BtYAj9WEbqMT2R30ZZpjd014cYCpC=b+HRtUf_A@mail.gmail.com> <20120524195851.GA15306@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.182]:64617 "EHLO
	ironport2-out.teksavvy.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932226Ab2EYTOm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 May 2012 15:14:42 -0400
In-Reply-To: <20120524195851.GA15306@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On 12-05-24 03:58 PM, Dmitry Torokhov wrote:
>
> On  the topic of naming - nobody cares what input devices are called as
> long as they are unique. Userspace does not work with input devices
> directly (there is no API), they are working with iterfaces (such as
> evdev) that have their own interfaces and names.

I regularly work with input devices from userspace,
using the "lsinput" "xinput", and "input-kbd" commands (among others)
from various shell scripts.

So I guess that makes me one of those anonymous "nobody" types
who "don't care" about it.

Usually the device naming I see there makes some kind of sense.

