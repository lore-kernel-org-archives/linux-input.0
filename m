From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 00/30] constify input serio_device_id
Date: Sun, 20 Aug 2017 09:31:56 -0700
Message-ID: <20170820163156.GC1176@dtor-ws>
References: <1502969911-25408-1-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1502969911-25408-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Aug 17, 2017 at 05:08:01PM +0530, Arvind Yadav wrote:
> serio_device_id are not supposed to change at runtime. All functions
> working with serio_device_id provided by <linux/serio.h> work with
> const serio_device_id. So mark the non-const structs as const.

Applied the lot, thank you.

> 
> Arvind Yadav (30):
>   [PATCH 01/30] Input: iforce: constify serio_device_id
>   [PATCH 02/30] Input: magellan: constify serio_device_id
>   [PATCH 03/30] Input: spaceball: constify serio_device_id
>   [PATCH 04/30] Input: spaceorb: constify serio_device_id
>   [PATCH 05/30] Input: stinger: constify serio_device_id
>   [PATCH 06/30] Input: twidjoy: constify serio_device_id
>   [PATCH 07/30] Input: warrior: constify serio_device_id
>   [PATCH 08/30] Input: zhenhua: constify serio_device_id
>   [PATCH 09/30] Input: iatkbd: constify serio_device_id
>   [PATCH 10/30] Input: hil_kbd: constify serio_device_id
>   [PATCH 11/30] Input: lkkbd: constify serio_device_id
>   [PATCH 12/30] Input: newtonkbd: constify serio_device_id
>   [PATCH 13/30] Input: stowaway: constify serio_device_id
>   [PATCH 14/30] Input: sunkbd: constify serio_device_id
>   [PATCH 15/30] Input: xtkbd: constify serio_device_id
>   [PATCH 16/30] Input: serio: constify serio_device_id
>   [PATCH 17/30] Input: wacom_serial4: constify serio_device_id
>   [PATCH 18/30] Input: dynapro: constify serio_device_id
>   [PATCH 19/30] Input: elo: constify serio_device_id
>   [PATCH 20/30] Input: fujitsu_ts: constify serio_device_id
>   [PATCH 21/30] Input: gunze: constify serio_device_id
>   [PATCH 22/30] Input: hampshire: constify serio_device_id
>   [PATCH 23/30] Input: inexio: constify serio_device_id
>   [PATCH 24/30] Input: mtouch: constify serio_device_id
>   [PATCH 25/30] Input: penmount: constify serio_device_id
>   [PATCH 26/30] Input: touchit213: constify serio_device_id
>   [PATCH 27/30] Input: touchright: constify serio_device_id
>   [PATCH 28/30] Input: touchwin: constify serio_device_id
>   [PATCH 29/30] Input: tsc40: constify serio_device_id
>   [PATCH 30/30] Input: wacom_w8001: constify serio_device_id
> 
>  drivers/input/joystick/iforce/iforce-serio.c | 2 +-
>  drivers/input/joystick/magellan.c            | 2 +-
>  drivers/input/joystick/spaceball.c           | 2 +-
>  drivers/input/joystick/spaceorb.c            | 2 +-
>  drivers/input/joystick/stinger.c             | 2 +-
>  drivers/input/joystick/twidjoy.c             | 2 +-
>  drivers/input/joystick/warrior.c             | 2 +-
>  drivers/input/joystick/zhenhua.c             | 2 +-
>  drivers/input/keyboard/atkbd.c               | 2 +-
>  drivers/input/keyboard/hil_kbd.c             | 2 +-
>  drivers/input/keyboard/lkkbd.c               | 2 +-
>  drivers/input/keyboard/newtonkbd.c           | 2 +-
>  drivers/input/keyboard/stowaway.c            | 2 +-
>  drivers/input/keyboard/sunkbd.c              | 2 +-
>  drivers/input/keyboard/xtkbd.c               | 2 +-
>  drivers/input/serio/serio_raw.c              | 2 +-
>  drivers/input/tablet/wacom_serial4.c         | 2 +-
>  drivers/input/touchscreen/dynapro.c          | 2 +-
>  drivers/input/touchscreen/elo.c              | 2 +-
>  drivers/input/touchscreen/fujitsu_ts.c       | 2 +-
>  drivers/input/touchscreen/gunze.c            | 2 +-
>  drivers/input/touchscreen/hampshire.c        | 2 +-
>  drivers/input/touchscreen/inexio.c           | 2 +-
>  drivers/input/touchscreen/mtouch.c           | 2 +-
>  drivers/input/touchscreen/penmount.c         | 2 +-
>  drivers/input/touchscreen/touchit213.c       | 2 +-
>  drivers/input/touchscreen/touchright.c       | 2 +-
>  drivers/input/touchscreen/touchwin.c         | 2 +-
>  drivers/input/touchscreen/tsc40.c            | 2 +-
>  drivers/input/touchscreen/wacom_w8001.c      | 2 +-
>  30 files changed, 30 insertions(+), 30 deletions(-)
> 
> -- 
> 2.7.4
> 

-- 
Dmitry
