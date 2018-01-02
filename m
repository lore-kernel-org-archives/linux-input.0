From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [RFC PATCH] input: Add disable sysfs entry for every input device
Date: Tue, 2 Jan 2018 22:54:37 +0100
Message-ID: <20180102215437.i3x2j6jvxtac4ntt@pali>
References: <1482660296-8432-1-git-send-email-pali.rohar@gmail.com>
 <1483370825.2420.8.camel@hadess.net>
 <201701021809.58943@pali>
 <1483442481.2420.12.camel@hadess.net>
 <60c21c4d-bb81-342a-45e1-7e92313e05d7@gmail.com>
 <1483540655.2420.18.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1483540655.2420.18.camel@hadess.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Chuck Ebbert <cebbert.lkml@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wednesday 04 January 2017 15:37:35 Bastien Nocera wrote:
> I don't doubt that the use cases should be catered for, I essentially
> did that same work without kernel changes for GNOME. What I doubt is
> the fuzzy semantics, the fact that the device is kept opened but no
> data is sent (that's not power saving), that whether users are revoked
> or should be revoked isn't clear, and that the goal is basically to
> work around stupid input handling when at the console. When running a
> display manager, this is all avoided.
> 
> If this were to go through, then the semantics and behaviour needs to
> be better explained, power saving actually made possible, and make sure
> that libinput can proxy that state to the users on the console. Or an
> ioctl added to the evdev device to disable them.

So, do you mean to implement this "disable" action as ioctl for
particular /dev/input/event* device (instead of sysfs entry)?

-- 
Pali Rohár
pali.rohar@gmail.com
