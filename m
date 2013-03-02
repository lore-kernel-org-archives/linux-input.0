From: Olof Johansson <olofj@chromium.org>
Subject: Re: [PATCH 2/2] Platform: x86: chromeos_laptop : Add basic platform
 data for atmel devices
Date: Fri, 1 Mar 2013 20:00:06 -0800
Message-ID: <CALiw-2H6dPM31QJnGCLG4POxWtZ3dCZTgcJ6ADjtNAvty604SQ@mail.gmail.com>
References: <1362187254-9227-1-git-send-email-bleung@chromium.org>
	<1362187254-9227-3-git-send-email-bleung@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1362187254-9227-3-git-send-email-bleung@chromium.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Benson Leung <bleung@chromium.org>
Cc: miletus@chromium.org, dmitry.torokhov@gmail.com, matthew.garrett@nebula.com, rydberg@euromail.se, djkurtz@chromium.org, jy0922.shim@samsung.com, wfp5p@virginia.edu, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-input@vger.kernel.org

2013/3/1 Benson Leung <bleung@chromium.org>:
> Add basic platform data to get the current upstream driver working
> with the 224s touchpad and 1664s touchscreen.
> We will be using NULL config so we will use the settings from the
> devices' NVRAMs.
>
> Signed-off-by: Benson Leung <bleung@chromium.org>
>
> Change-Id: I712bf4726fb4b194fbde44ad200c54d13dc3bdb9

Same thing, please remove Change-Id.

I've tested this patch, and had issues getting touchscreen to work.
Seems to be a driver-side issue, so this patch is still valid.

There was also some flakiness with the touchpad device going
unresponsive after some time that needs to be debugged. Again, driver
side.

With those caveats:

Tested-by: Olof Johansson <olof@lixom.net>


-Olof
