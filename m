From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] Input: mousedev - stop offering PS/2 to userspace by
 default
Date: Thu, 29 Dec 2016 20:08:32 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1612292008130.28985@cbobk.fhfr.pm>
References: <20161229180731.GA5321@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161229180731.GA5321@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 29 Dec 2016, Dmitry Torokhov wrote:

> Evdev interface has been available for many years and by now everyone
> is switched to using it, so let's stop offering /dev/input/mouseN
> and /dev/psaux by default.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Makes sense to me.

	Acked-by: Jiri Kosina <jkosina@suse.cz>

Thanks,

-- 
Jiri Kosina
SUSE Labs
