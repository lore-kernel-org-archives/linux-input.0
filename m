From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 1/2] SOUND: kill gameport bits
Date: Wed, 20 Aug 2014 09:33:29 +0200
Message-ID: <53F44F49.9050000@ladisch.de>
References: <1408466497-25640-1-git-send-email-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1408466497-25640-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>, Jiri Kosina <jkosina@suse.cz>, Takashi Iwai <tiwai@suse.de>
List-Id: linux-input@vger.kernel.org

Dmitry Torokhov wrote:
> Gameport support hasn't been working well ever since cpufreq became
> mainstream

Back in the gameport-mainstream days, we did not have a usable high-
resolution timer API.  But why can't we use something like
getrawmonotonic() now?  (Yes, I'm volunteering ...)

> and it becomes increasingly hard to find hardware and software that
> would run on such old hardware.

I have two such sound cards, and a joystick.


Regards,
Clemens
