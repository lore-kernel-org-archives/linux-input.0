From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/2] GPIO joystick driver
Date: Fri, 06 Feb 2015 07:31:51 -0800
Message-ID: <1AA6C46C-36D9-4243-9DC5-254A7202D339@gmail.com>
References: <1423215122-19947-1-git-send-email-hans.holmberg@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1423215122-19947-1-git-send-email-hans.holmberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hans Holmberg <hans.holmberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Hans,

On February 6, 2015 1:32:00 AM PST, Hans Holmberg <hans.holmberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
>This series adds a driver for digital joysticks connected
>via GPIOs.

Why do we need this new driver when we have gpio-keys driver that can be configured to emit ABS_* events?

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
