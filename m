From: Anthony Kim <anthony.kim-7TZDMcjUQMzQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH resend 0/1] Input: add support for HiDeep touchscreen.
Date: Mon, 16 Oct 2017 11:10:05 +0900
Message-ID: <1508119806-8074-1-git-send-email-anthony.kim@hideep.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Anthony Kim <anthony.kim-7TZDMcjUQMzQT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi,

I remake patch file as base on last commit of next branch
and resend patch file.
Please review this.

My last mail as below.
http://www.spinics.net/lists/linux-input/msg53312.html

Thanks.
Anthony.

Anthony Kim (1):
  Input: add support for HiDeep touchscreen

 .../bindings/input/touchscreen/hideep.txt          |   42 +
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 drivers/input/touchscreen/Kconfig                  |   11 +
 drivers/input/touchscreen/Makefile                 |    1 +
 drivers/input/touchscreen/hideep.c                 | 1176 ++++++++++++++++++++
 5 files changed, 1231 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/hideep.txt
 create mode 100644 drivers/input/touchscreen/hideep.c

-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
